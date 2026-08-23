import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' as d;

import '../../../../core/error/auth_exceptions.dart';
import '../../../../core/network/api_response.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../models/user_profile_model.dart';
import '../services/supabase_auth_service.dart';
import '../local/profile_local_data_source.dart';
import '../../../../core/local/app_database.dart';
import '../../../../core/error/exception_mapper.dart';
import '../../../../core/error/app_exception.dart' as core_ex;

class SupabaseAuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthService _service;
  final Dio _dio;
  final ProfileLocalDataSource _localDataSource;

  SupabaseAuthRepositoryImpl(this._service, this._dio, this._localDataSource);

  // ── Sign in ───────────────────────────────────────────────────────────────

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    debugPrint('>>> REPO.signIn() called for: $email');
    try {
      final supaUser = await _service.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _toUserModel(supaUser, email);
    } on UserNotFoundException {
      rethrow;
    } on InvalidCredentialsException {
      rethrow;
    } on EmailNotConfirmedException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on AuthException {
      rethrow;
    } catch (e, stack) {
      debugPrint(
        'SupabaseAuthRepositoryImpl.signIn unexpected error: $e\n$stack',
      );
      throw AuthException('Sign-in failed. Please try again.');
    }
  }

  // ── Sign up ───────────────────────────────────────────────────────────────

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
  }) async {
    debugPrint('>>> REPO.signUp() called for: $email');
    try {
      final supaUser = await _service.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('>>> REPO.signUp: supaUser=$supaUser');
      if (supaUser == null) {
        // Normal: Supabase requires email confirmation before returning a
        // real session (signUp() succeeds but session is null — see
        // SupabaseAuthService.signUpWithEmailAndPassword). Return a pending
        // placeholder so the caller can navigate to the OTP screen, exactly
        // like the Clerk version did.
        debugPrint('>>> REPO.signUp: Returning pending user for OTP flow');
        return UserModel(
          id: 'pending_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
        );
      }

      debugPrint('>>> REPO.signUp: Returning full user object');
      return _toUserModel(supaUser, supaUser.email ?? email);
    } on WeakPasswordException {
      rethrow;
    } on AuthException {
      rethrow;
    } on NetworkException {
      rethrow;
    } catch (e, stack) {
      debugPrint(
        'SupabaseAuthRepositoryImpl.signUp unexpected error: $e\n$stack',
      );
      throw AuthException('Sign-up failed. Please try again.');
    }
  }

  // ── Google OAuth ──────────────────────────────────────────────────────────

  @override
  Future<void> signInWithGoogle() async {
    debugPrint('>>> REPO.signInWithGoogle() called');
    try {
      await _service.signInWithGoogle();
    } on AuthException {
      rethrow;
    } catch (e, stack) {
      debugPrint(
        'SupabaseAuthRepositoryImpl.signInWithGoogle unexpected error: $e\n$stack',
      );
      throw AuthException('Google sign-in failed. Please try again.');
    }
  }

  // ── OTP ───────────────────────────────────────────────────────────────────

  @override
  Future<void> verifyEmailOtp({
    required String email,
    required String code,
  }) async {
    try {
      await _service.verifyEmailOtp(email: email, code: code);
    } on OtpVerificationException {
      rethrow;
    } on ValidationException {
      rethrow;
    } catch (e, stack) {
      debugPrint(
        'SupabaseAuthRepositoryImpl.verifyEmailOtp unexpected error: $e\n$stack',
      );
      throw OtpVerificationException(
        'OTP verification failed. Please try again.',
      );
    }
  }

  @override
  Future<void> resendEmailOtp({required String email}) async {
    try {
      await _service.resendOtp(email: email);
    } on AuthException {
      rethrow;
    } catch (e, stack) {
      debugPrint(
        'SupabaseAuthRepositoryImpl.resendEmailOtp unexpected error: $e\n$stack',
      );
      throw AuthException('Could not resend OTP. Please try again.');
    }
  }

  // ── Sign out ──────────────────────────────────────────────────────────────

  @override
  Future<void> signOut() async {
    try {
      await _service.signOut();
    } catch (e) {
      debugPrint(
        'SupabaseAuthRepositoryImpl.signOut Supabase error (non-fatal): $e',
      );
    }

    await _clearLocalSession();
  }

  // ── Current user ──────────────────────────────────────────────────────────

  @override
  UserEntity? getCurrentUser() {
    final supaUser = _service.currentUser;
    if (supaUser == null) return null;

    return _toUserModel(supaUser, supaUser.email ?? '');
  }

  @override
  Future<void> createOrUpdateProfile({
    required String name,
    required String phone,
    required String gender,
    required String dob,
    required String email,
    required String userId,
  }) async {
    try {
      final response = await _dio.patch(
        '/api/patient/profile',
        data: {
          'name': name,
          'phone': phone,
          'gender': gender.toLowerCase(),
          'dob': dob,
          'email': email,
          'userId': userId,
        },
      );

      final rawData = ApiResponse.process(response.data);
      final networkProfile = UserProfileModel.fromJson(
        rawData as Map<String, dynamic>,
      );

      // Cache profile locally in Drift
      await _localDataSource.upsertProfile(
        ProfileTableCompanion(
          id: d.Value(networkProfile.id),
          name: d.Value(networkProfile.name),
          role: d.Value(networkProfile.role),
          email: d.Value(networkProfile.email),
          phone: d.Value(networkProfile.phone),
          isAccountVerified: d.Value(networkProfile.isAccountVerified),
          clinicId: d.Value(networkProfile.clinicId),
          createdAt: d.Value(networkProfile.createdAt),
          updatedAt: d.Value(networkProfile.updatedAt),
          gender: d.Value(gender),
          dateOfBirth: d.Value(dob),
          cachedAt: d.Value(DateTime.now()),
        ),
      );
    } catch (error) {
      throw mapErrorToException(error);
    }
  }

  UserModel _toUserModel(sb.User supaUser, String email) {
    final metadata = supaUser.userMetadata ?? {};
    return UserModel(
      id: supaUser.id,
      email: email,
      firstName: metadata['first_name'] as String? ?? '',
      lastName: metadata['last_name'] as String? ?? '',
    );
  }

  /// Removes persisted session data from [SharedPreferences].
  Future<void> _clearLocalSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.remove('user_first_name'),
        prefs.remove('user_last_name'),
        prefs.remove('user_gender'),
        prefs.remove('user_dob'),
        prefs.remove('user_email'),
      ]);
    } catch (e) {
      debugPrint(
        'SupabaseAuthRepositoryImpl._clearLocalSession failed (non-fatal): $e',
      );
    }
  }

  bool _isCacheValid(DateTime? cachedAt) {
    if (cachedAt == null) return false;
    final now = DateTime.now();
    final difference = now.difference(cachedAt);
    return difference.inHours < 24;
  }

  @override
  Future<UserProfile> getProfile() async {
    final cachedRow = await _localDataSource.getCachedProfile();
    if (cachedRow != null && _isCacheValid(cachedRow.cachedAt)) {
      debugPrint(
        '[ProfileRepository] Profile cache is fresh (<24h) — serving from CACHE',
      );
      return UserProfile(
        id: cachedRow.id,
        name: cachedRow.name,
        role: cachedRow.role,
        email: cachedRow.email,
        phone: cachedRow.phone,
        isAccountVerified: cachedRow.isAccountVerified,
        clinicId: cachedRow.clinicId,
        createdAt: cachedRow.createdAt,
        updatedAt: cachedRow.updatedAt,
        gender: cachedRow.gender,
        dateOfBirth: cachedRow.dateOfBirth,
      );
    }

    try {
      final response = await _dio.get('/api/patient/profile');
      final rawData = ApiResponse.process(response.data);
      final networkProfile = UserProfileModel.fromJson(
        rawData as Map<String, dynamic>,
      );

      // Cache profile locally in Drift
      await _localDataSource.upsertProfile(
        ProfileTableCompanion(
          id: d.Value(networkProfile.id),
          name: d.Value(networkProfile.name),
          role: d.Value(networkProfile.role),
          email: d.Value(networkProfile.email),
          phone: d.Value(networkProfile.phone),
          isAccountVerified: d.Value(networkProfile.isAccountVerified),
          clinicId: d.Value(networkProfile.clinicId),
          createdAt: d.Value(networkProfile.createdAt),
          updatedAt: d.Value(networkProfile.updatedAt),
          gender: d.Value(networkProfile.gender),
          dateOfBirth: d.Value(networkProfile.dateOfBirth),
          cachedAt: d.Value(DateTime.now()),
        ),
      );

      debugPrint('[ProfileRepository] Fetched from NETWORK — 1 items');
      return networkProfile;
    } catch (error) {
      final appEx = mapErrorToException(error);
      debugPrint(
        '[ProfileRepository] NETWORK failed — falling back to CACHE: $appEx',
      );

      if (cachedRow != null) {
        final profile = UserProfile(
          id: cachedRow.id,
          name: cachedRow.name,
          role: cachedRow.role,
          email: cachedRow.email,
          phone: cachedRow.phone,
          isAccountVerified: cachedRow.isAccountVerified,
          clinicId: cachedRow.clinicId,
          createdAt: cachedRow.createdAt,
          updatedAt: cachedRow.updatedAt,
          gender: cachedRow.gender,
          dateOfBirth: cachedRow.dateOfBirth,
          isFromCache: true,
          cacheError: appEx.message,
        );
        debugPrint(
          '[ProfileRepository] Returned 1 items from CACHE (cachedAt: ${cachedRow.cachedAt.toIso8601String()})',
        );
        return profile;
      }
      throw appEx;
    }
  }
}

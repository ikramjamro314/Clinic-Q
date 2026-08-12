import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../services/supabase_auth_service.dart';

class SupabaseAuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthService _service;

  SupabaseAuthRepositoryImpl(this._service);

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

  // ── Profile update ────────────────────────────────────────────────────────

  @override
  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String gender,
    required String dateOfBirth,
    required String email,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.setString('user_first_name', firstName),
        prefs.setString('user_last_name', lastName),
        prefs.setString('user_gender', gender),
        prefs.setString('user_dob', dateOfBirth),
        prefs.setString('user_email', email),
      ]);
    } catch (e, stack) {
      debugPrint('SupabaseAuthRepositoryImpl.updateProfile failed: $e\n$stack');
      throw AuthException('Failed to save profile. Please try again.');
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
}

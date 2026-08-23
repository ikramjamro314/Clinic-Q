import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../../core/error/auth_exceptions.dart';

class SupabaseAuthService {
  final sb.SupabaseClient _client;

  SupabaseAuthService(this._client);

  sb.GoTrueClient get _auth => _client.auth;

  bool get isSignedIn => _auth.currentSession != null;

  sb.User? get currentUser => _auth.currentUser;

  sb.Session? get currentSession => _auth.currentSession;

  String? get accessToken => _auth.currentSession?.accessToken;

  Stream<sb.AuthState> get onAuthStateChange => _auth.onAuthStateChange;

  // ---- EMAIL + PASSWORD ---------------------------------------------------

  Future<sb.User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    debugPrint('>>> SERVICE.signInWithEmailAndPassword() called for: $email');
    try {
      final response = await _auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw AuthException(
          'Sign-in could not be completed. Please try again.',
        );
      }

      final session = sb.Supabase.instance.client.auth.currentSession;

      print("this is the session: ${session?.toJson()}");
      return user;
    } on sb.AuthException catch (e) {
      throw _mapSignInError(e);
    } catch (e) {
      throw _mapGenericError(e);
    }
  }

  Future<sb.User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    debugPrint('>>> SERVICE.signUpWithEmailAndPassword() called for: $email');
    try {
      final response = await _auth.signUp(
        email: email.trim(),
        password: password,
      );

      debugPrint(
        '>>> POST-SIGNUP CHECK: user=${response.user?.id}, session=${response.session != null}',
      );

      if (response.user != null && response.session == null) {
        return null;
      }
      final session = sb.Supabase.instance.client.auth.currentSession;
      print("this is the session: ${session?.toJson()}");
      return response.user;
    } on sb.AuthException catch (e) {
      throw _mapSignUpError(e);
    } catch (e) {
      throw _mapGenericError(e);
    }
  }

  Future<void> verifyEmailOtp({
    required String email,
    required String code,
  }) async {
    final trimmed = code.trim();
    if (trimmed.isEmpty) {
      throw ValidationException('OTP code cannot be empty.');
    }
    if (trimmed.length != 6) {
      throw ValidationException('OTP must be exactly 6 digits.');
    }

    try {
      final response = await _auth.verifyOTP(
        email: email.trim(),
        token: trimmed,
        type: sb.OtpType.signup,
      );

      if (response.session == null) {
        throw OtpVerificationException(
          'OTP verification failed. Please try again.',
        );
      }
    } on sb.AuthException catch (e) {
      throw OtpVerificationException(_cleanMessage(e.message));
    } on OtpVerificationException {
      rethrow;
    } on ValidationException {
      rethrow;
    } catch (e) {
      throw OtpVerificationException(
        'Verification error: ${_cleanMessage(e.toString())}',
      );
    }
  }

  Future<void> resendOtp({required String email}) async {
    try {
      await _auth.resend(type: sb.OtpType.signup, email: email.trim());
    } on sb.AuthException catch (e) {
      throw AuthException('Could not resend OTP: ${_cleanMessage(e.message)}');
    } catch (e) {
      throw AuthException(
        'Could not resend OTP: ${_cleanMessage(e.toString())}',
      );
    }
  }

  // ---- OAUTH (GOOGLE) -----------------------------------------------------

  Future<sb.User> signInWithGoogle() async {
    debugPrint('>>> ATTEMPTING NATIVE GOOGLE SIGN IN');
    try {
      final googleAccount = await gsi.GoogleSignIn.instance.authenticate();

      final googleAuthorization = await googleAccount.authorizationClient
          .authorizationForScopes(['email', 'profile']);
      final idToken = googleAccount.authentication.idToken;
      final accessToken = googleAuthorization?.accessToken;

      if (idToken == null) {
        throw AuthException('Google sign-in did not return an ID token.');
      }

      final response = await _auth.signInWithIdToken(
        provider: sb.OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      final user = response.user;
      if (user == null) {
        throw AuthException('Google sign-in could not be completed.');
      }
      debugPrint('>>> GOOGLE SIGN IN - success, user=${user.id}');
      final session = sb.Supabase.instance.client.auth.currentSession;
      print("this is the session: ${session?.toJson()}");
      return user;
    } on gsi.GoogleSignInException catch (e) {
      if (e.code == gsi.GoogleSignInExceptionCode.canceled) {
        throw AuthException('Sign-in cancelled.');
      }
      throw AuthException(
        'Google sign-in failed: ${e.description ?? e.code.name}',
      );
    } on sb.AuthException catch (e) {
      throw AuthException('Google sign-in failed: ${_cleanMessage(e.message)}');
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(
        'Google sign-in failed. Details: ${_cleanMessage(e.toString())}',
      );
    }
  }

  // ---- SIGN OUT -------------------------------------------------------------

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on sb.AuthException catch (e) {
      throw AuthException('Sign-out failed: ${_cleanMessage(e.message)}');
    } catch (e) {
      throw AuthException('Sign-out failed: ${_cleanMessage(e.toString())}');
    }
  }

  String _cleanMessage(String raw) =>
      raw.replaceFirst(RegExp(r'^Exception:\s*'), '');

  AuthException _mapSignInError(sb.AuthException e) {
    switch (e.code) {
      case 'invalid_credentials':
        return InvalidCredentialsException('Incorrect email or password.');
      case 'user_not_found':
        return UserNotFoundException(
          'No account found for this email address.',
        );
      case 'email_not_confirmed':
        return EmailNotConfirmedException();
      case 'over_request_rate_limit':
        return AuthException('Too many attempts. Please wait and try again.');
    }
    final msg = e.message.toLowerCase();
    if (msg.contains('network') ||
        msg.contains('socket') ||
        msg.contains('timeout')) {
      return NetworkException();
    }
    return AuthException(_cleanMessage(e.message));
  }

  AuthException _mapSignUpError(sb.AuthException e) {
    switch (e.code) {
      case 'user_already_exists':
        return AuthException('An account with this email already exists.');
      case 'weak_password':
        return WeakPasswordException(
          'Password is too weak. Use at least 8 characters with a mix of letters and numbers.',
        );
      case 'over_request_rate_limit':
        return AuthException('Too many attempts. Please wait and try again.');
    }
    final msg = e.message.toLowerCase();
    if (msg.contains('already') ||
        msg.contains('exists') ||
        msg.contains('registered')) {
      return AuthException('An account with this email already exists.');
    }
    if (msg.contains('network') ||
        msg.contains('socket') ||
        msg.contains('timeout')) {
      return NetworkException();
    }
    return AuthException(_cleanMessage(e.message));
  }

  AuthException _mapGenericError(Object e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('network') ||
        msg.contains('socket') ||
        msg.contains('timeout')) {
      return NetworkException();
    }
    return AuthException(_cleanMessage(e.toString()));
  }
}

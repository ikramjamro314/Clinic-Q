import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Sign out the currently authenticated user.
  Future<void> signOut();

  /// Verify email OTP code.
  Future<void> verifyEmailOtp({required String email, required String code});

  /// Resend email OTP code.
  Future<void> resendEmailOtp({required String email});

  /// Update user profile.
  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String gender,
    required String dateOfBirth,
    required String email,
  });

  /// Returns the current user entity, or null if not authenticated.
  UserEntity? getCurrentUser();

  /// Sign in with email and password.
  Future<UserEntity> signIn({required String email, required String password});

  /// Sign up with email and password.
  Future<UserEntity> signUp({required String email, required String password});

  /// Sign in with Google authentication.
  Future<void> signInWithGoogle();
}

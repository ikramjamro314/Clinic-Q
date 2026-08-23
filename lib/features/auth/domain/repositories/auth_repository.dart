import '../entities/user_entity.dart';
import '../entities/user_profile.dart';

abstract class AuthRepository {
  /// Sign out the currently authenticated user.
  Future<void> signOut();

  /// Verify email OTP code.
  Future<void> verifyEmailOtp({required String email, required String code});

  /// Resend email OTP code.
  Future<void> resendEmailOtp({required String email});

  /// Fetch the current user's profile details.
  Future<UserProfile> getProfile();

  /// Create user profile.
  Future<void> createOrUpdateProfile({
    required String name,
    required String phone,
    required String gender,
    required String dob,
    required String email,
    required String userId,
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

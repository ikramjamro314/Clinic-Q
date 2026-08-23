import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/domain/entities/user_profile.dart';
import '../../../auth/presentation/auth_providers.dart';
import '../../../../core/error/app_exception.dart';

class ProfileState {
  final UserProfile? profile;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  ProfileState copyWith({
    UserProfile? profile,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ProfileViewModel extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    Future.microtask(fetchProfile);
    return const ProfileState();
  }

  Future<void> fetchProfile() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final profile = await ref.read(authRepositoryProvider).getProfile();
      state = state.copyWith(profile: profile, isLoading: false);
      ref.read(hasProfileProvider.notifier).setState(true);
    } catch (e) {
      if (e is NotFoundException) {
        ref.read(hasProfileProvider.notifier).setState(false);
      }
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String gender,
    required String dateOfBirth,
    required String email,
    required String phone,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isSuccess: false,
    );
    try {
      await ref
          .read(authRepositoryProvider)
          .createOrUpdateProfile(
            name: name,
            gender: gender,
            dob: dateOfBirth,
            email: email,
            userId: ref.read(authRepositoryProvider).getCurrentUser()!.id,
            phone: phone.trim(),
          );

      // Re-fetch profile to load updated cached data
      final updatedProfile = await ref
          .read(authRepositoryProvider)
          .getProfile();
      state = state.copyWith(
        profile: updatedProfile,
        isLoading: false,
        isSuccess: true,
      );
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
      return false;
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    ref.read(hasProfileProvider.notifier).setState(null);
  }
}

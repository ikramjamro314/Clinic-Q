import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_providers.dart';

class ProfileState {
  final String name;
  final String gender;
  final String dateOfBirth;
  final String email;
  final String phone;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const ProfileState({
    this.name = '',
    this.gender = 'Male', // Default selected gender
    this.dateOfBirth = '',
    this.email = '',
    this.phone = '',
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  bool get isValid {
    final phoneClean = phone.replaceAll(RegExp(r'[\s\-]+'), '');
    final pkPhoneRegex = RegExp(r'^(\+92|92|0)?3[0-9]{9}$');
    return name.trim().isNotEmpty &&
        gender.isNotEmpty &&
        dateOfBirth.isNotEmpty &&
        pkPhoneRegex.hasMatch(phoneClean);
  }

  ProfileState copyWith({
    String? name,
    String? gender,
    String? dateOfBirth,
    String? email,
    String? phone,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return ProfileState(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class ProfileNotifier extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    final currentUser = ref.watch(authRepositoryProvider).getCurrentUser();
    if (currentUser != null) {
      final name =
          '${currentUser.firstName ?? ''} ${currentUser.lastName ?? ''}'.trim();
      return ProfileState(name: name, email: currentUser.email, phone: '');
    }
    return const ProfileState();
  }

  void updateName(String name) {
    state = state.copyWith(name: name, errorMessage: null);
  }

  void updateGender(String gender) {
    state = state.copyWith(gender: gender, errorMessage: null);
  }

  void updateDateOfBirth(String dob) {
    state = state.copyWith(dateOfBirth: dob, errorMessage: null);
  }

  void updatePhone(String phone) {
    state = state.copyWith(phone: phone, errorMessage: null);
  }

  Future<bool> submitProfile() async {
    if (!state.isValid) {
      state = state.copyWith(
        errorMessage:
            'Please enter a valid Pakistani phone number (+923XXXXXXXXX or 03XXXXXXXXX), name, and select your details.',
      );
      return false;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isSuccess: false,
    );

    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.createOrUpdateProfile(
        name: state.name,
        phone: state.phone.trim(),
        gender: state.gender,
        dob: state.dateOfBirth,
        email: state.email.trim(),
        userId: ref.read(authRepositoryProvider).getCurrentUser()!.id,
      );

      ref.read(hasProfileProvider.notifier).state = true;
      state = state.copyWith(isSuccess: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

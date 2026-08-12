import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_providers.dart';

class SignUpState {
  final String email;
  final String password;
  final bool obscurePassword;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const SignUpState({
    this.email = '',
    this.password = '',
    this.obscurePassword = true,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  bool get isEmailValid {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email.trim());
  }

  bool get isPasswordValid {
    return password.length >= 6;
  }

  bool get isValid {
    return isEmailValid && isPasswordValid;
  }

  SignUpState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class SignUpNotifier extends Notifier<SignUpState> {
  @override
  SignUpState build() {
    return const SignUpState();
  }

  void reset() {
    state = const SignUpState();
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value, errorMessage: null);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value, errorMessage: null);
  }

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  Future<bool> submit() async {
    debugPrint('>>> NOTIFIER.submit() called for: ${state.email}');
    if (!state.isValid) {
      state = state.copyWith(
        errorMessage:
            'Please enter valid email and password (min 6 chars).',
      );
      return false;
    }

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );

    try {
      final authRepository = ref.read(authRepositoryProvider);
      debugPrint('>>> NOTIFIER.signUp: Calling repository.signUp()');
      await authRepository.signUp(
        email: state.email.trim(),
        password: state.password,
      );

      debugPrint('>>> NOTIFIER.signUp: SUCCESS - setting successMessage');
      state = state.copyWith(successMessage: 'Sign up successful!');
      return true;
    } catch (e) {
      debugPrint('>>> NOTIFIER.signUp: ERROR - $e');
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      state = state.copyWith(
        errorMessage: errorMsg.isNotEmpty ? errorMsg : 'Sign up failed',
      );
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

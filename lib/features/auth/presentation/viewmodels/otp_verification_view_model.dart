import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth_providers.dart';

class OtpVerificationState {
  const OtpVerificationState({
    this.otpCode = '',
    this.submittedIncomplete = false,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  final String otpCode;
  final bool submittedIncomplete;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  bool get isComplete => otpCode.length == 6;

  bool get showOtpError => submittedIncomplete && !isComplete;

  OtpVerificationState copyWith({
    String? otpCode,
    bool? submittedIncomplete,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return OtpVerificationState(
      otpCode: otpCode ?? this.otpCode,
      submittedIncomplete: submittedIncomplete ?? this.submittedIncomplete,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class OtpVerificationNotifier extends Notifier<OtpVerificationState> {
  @override
  OtpVerificationState build() {
    return const OtpVerificationState();
  }

  /// Update OTP code as user types
  void updateCode(String value) {
    state = state.copyWith(
      otpCode: value,
      submittedIncomplete: value.length == 6
          ? false
          : state.submittedIncomplete,
      errorMessage: null,
    );
  }

  /// Submit OTP for phone verification
  Future<bool> verifyEmailOtp({
    required String email,
    required String code,
  }) async {
    // Set loading state
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final authRepository = ref.read(authRepositoryProvider);
      // Verify OTP via repository
      await authRepository.verifyEmailOtp(email: email, code: code);

      state = state.copyWith(
        successMessage: 'OTP verified successfully!',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
        submittedIncomplete: true,
      );
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Resend OTP to the user's phone number
  Future<bool> resendEmailOtp({required String email}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final authRepository = ref.read(authRepositoryProvider);
      await authRepository.resendEmailOtp(email: email);

      state = state.copyWith(
        successMessage: 'A new OTP has been sent to your email.',
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Failed to resend OTP. Please try again.',
      );
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../domain/repositories/auth_repository.dart';
import '../data/repositories/supabase_auth_repository_impl.dart';
import '../data/services/supabase_auth_service.dart';

import 'viewmodels/sign_in_view_model.dart';
import 'viewmodels/sign_up_view_model.dart';
import 'viewmodels/otp_verification_view_model.dart';
import 'viewmodels/profile_view_model.dart';
import 'viewmodels/onboarding_view_model.dart';

final supabaseClientProvider = Provider<sb.SupabaseClient>((ref) {
  return sb.Supabase.instance.client;
});

final supabaseAuthServiceProvider = Provider<SupabaseAuthService>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthService(client);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final supabaseService = ref.watch(supabaseAuthServiceProvider);
  return SupabaseAuthRepositoryImpl(supabaseService);
});

final authStateChangesProvider = StreamProvider<sb.AuthState>((ref) {
  final service = ref.watch(supabaseAuthServiceProvider);
  return service.onAuthStateChange;
});

final signInViewModelProvider = NotifierProvider<SignInNotifier, SignInState>(
  SignInNotifier.new,
);

final signUpViewModelProvider = NotifierProvider<SignUpNotifier, SignUpState>(
  SignUpNotifier.new,
);

final otpViewModelProvider =
    NotifierProvider<OtpVerificationNotifier, OtpVerificationState>(
      OtpVerificationNotifier.new,
    );

final profileViewModelProvider =
    NotifierProvider<ProfileNotifier, ProfileState>(ProfileNotifier.new);

final onboardingViewModelProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
      OnboardingNotifier.new,
    );

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/network/dio_client.dart';
import '../domain/repositories/auth_repository.dart';
import '../data/repositories/supabase_auth_repository_impl.dart';
import '../data/services/supabase_auth_service.dart';

import 'viewmodels/sign_in_view_model.dart';
import 'viewmodels/sign_up_view_model.dart';
import 'viewmodels/otp_verification_view_model.dart';
import 'viewmodels/profile_view_model.dart';
import 'viewmodels/onboarding_view_model.dart';

import '../../../core/local/app_database.dart';
import '../data/local/profile_local_data_source.dart';

final supabaseClientProvider = Provider<sb.SupabaseClient>((ref) {
  return sb.Supabase.instance.client;
});

final supabaseAuthServiceProvider = Provider<SupabaseAuthService>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthService(client);
});

final profileLocalDataSourceProvider = Provider<ProfileLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return ProfileLocalDataSource(db);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final supabaseService = ref.watch(supabaseAuthServiceProvider);
  final dio = ref.watch(dioProvider);
  final localDataSource = ref.watch(profileLocalDataSourceProvider);
  final db = ref.watch(databaseProvider);
  return SupabaseAuthRepositoryImpl(supabaseService, dio, localDataSource, db);
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

final authProfileSyncNotifierProvider =
    NotifierProvider<ProfileNotifier, ProfileState>(ProfileNotifier.new);

final onboardingViewModelProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
      OnboardingNotifier.new,
    );

class HasProfileNotifier extends Notifier<bool?> {
  @override
  bool? build() => null;

  void setState(bool? value) {
    state = value;
  }
}

final hasProfileProvider = NotifierProvider<HasProfileNotifier, bool?>(
  HasProfileNotifier.new,
);

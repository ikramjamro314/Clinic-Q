import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clinic_q/features/doctor/presentation/doctor_providers.dart';
import '../../../../core/local/app_database.dart';
import '../../../../core/network/dio_client.dart';
import '../data/local/tokens_local_data_source.dart';
import '../data/local/tracking_local_data_source.dart';
import '../data/repositories/appointment_repository_impl.dart';
import '../data/repositories/tracking_repository_impl.dart';
import '../data/services/appointment_api_service.dart';
import '../data/services/tracking_api_service.dart';
import '../domain/repositories/appointment_repository.dart';
import '../domain/repositories/tracking_repository.dart';
import 'viewmodels/appointment_state.dart';
import 'viewmodels/appointment_view_model.dart';
import 'viewmodels/tracking_state.dart';
import 'viewmodels/tracking_view_model.dart';

export 'viewmodels/appointment_state.dart';
export 'viewmodels/appointment_view_model.dart';
export 'viewmodels/tracking_state.dart';
export 'viewmodels/tracking_view_model.dart';

final tokensLocalDataSourceProvider = Provider<TokensLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return TokensLocalDataSource(db);
});

final trackingLocalDataSourceProvider = Provider<TrackingLocalDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  return TrackingLocalDataSource(db);
});

final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  final apiService = AppointmentApiService(ref.watch(dioProvider));
  final localSource = ref.watch(tokensLocalDataSourceProvider);
  final doctorRepo = ref.watch(doctorRepositoryProvider);
  return AppointmentRepositoryImpl(apiService, localSource, doctorRepo);
});

final trackingRepositoryProvider = Provider<TrackingRepository>((ref) {
  final apiService = TrackingApiService(ref.watch(dioProvider));
  final localSource = ref.watch(trackingLocalDataSourceProvider);
  return TrackingRepositoryImpl(apiService, localSource);
});

final appointmentViewModelProvider = NotifierProvider<AppointmentNotifier, AppointmentState>(
  AppointmentNotifier.new,
);

final trackingViewModelProvider = NotifierProvider.family<TrackingNotifier, TrackingState, String>(
  TrackingNotifier.new,
);

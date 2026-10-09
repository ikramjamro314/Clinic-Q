import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clinic_q/features/doctor/presentation/doctor_providers.dart';
import 'package:clinic_q/features/doctor/domain/entities/doctor_entity.dart';
import '../../../../core/local/app_database.dart';
import '../../../../core/network/dio_client.dart';
import '../data/local/tokens_local_data_source.dart';
import '../data/local/tracking_local_data_source.dart';
import '../data/repositories/appointment_repository_impl.dart';
import '../data/repositories/tracking_repository_impl.dart';
import '../data/services/appointment_api_service.dart';
import '../data/services/tracking_api_service.dart';
import '../domain/entities/queue_preview.dart';
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

class TokenInfoData {
  final DoctorEntity doctor;
  final QueuePreview preview;
  const TokenInfoData(this.doctor, this.preview);
}

class TokenInfoParams {
  final String doctorId;
  final String clinicId;
  const TokenInfoParams({required this.doctorId, required this.clinicId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenInfoParams &&
          runtimeType == other.runtimeType &&
          doctorId == other.doctorId &&
          clinicId == other.clinicId;

  @override
  int get hashCode => doctorId.hashCode ^ clinicId.hashCode;
}

final doctorLoaderProvider = FutureProvider.family<DoctorEntity?, String>((
  ref,
  doctorId,
) {
  return ref.watch(doctorRepositoryProvider).getDoctorById(doctorId);
});

final tokenInfoQueueStreamProvider =
    StreamProvider.family<QueuePreview, TokenInfoParams>((ref, params) {
      return ref
          .watch(trackingRepositoryProvider)
          .getDoctorQueueStream(params.doctorId, params.clinicId);
    });

final tokenInfoLoaderProvider =
    FutureProvider.family<TokenInfoData, TokenInfoParams>((ref, params) async {
      final doctor = await ref
          .watch(doctorRepositoryProvider)
          .getDoctorById(params.doctorId);
      if (doctor == null) {
        throw Exception('Doctor not found');
      }
      final preview = await ref
          .watch(appointmentRepositoryProvider)
          .getQueuePreview(
            doctorId: params.doctorId,
            clinicId: params.clinicId,
          );
      return TokenInfoData(doctor, preview);
    });

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
  final appointmentRepo = ref.watch(appointmentRepositoryProvider);
  return TrackingRepositoryImpl(apiService, localSource, appointmentRepo);
});

final appointmentViewModelProvider = NotifierProvider<AppointmentNotifier, AppointmentState>(
  AppointmentNotifier.new,
);

final trackingViewModelProvider = NotifierProvider.family<TrackingNotifier, TrackingState, String>(
  TrackingNotifier.new,
);

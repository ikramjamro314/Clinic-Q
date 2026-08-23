import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/interest_local_data_source.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../../doctor/presentation/doctor_providers.dart';
import '../../../clinic/domain/entities/clinic_entity.dart';
import '../../../clinic/presentation/clinic_providers.dart';

class InterestListState {
  final int activeTabIndex; // 0: Doctor, 1: Hospital
  final List<DoctorEntity> doctors;
  final List<ClinicEntity> clinics;
  final bool isLoading;
  final String? errorMessage;

  const InterestListState({
    this.activeTabIndex = 0,
    this.doctors = const [],
    this.clinics = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  InterestListState copyWith({
    int? activeTabIndex,
    List<DoctorEntity>? doctors,
    List<ClinicEntity>? clinics,
    bool? isLoading,
    String? errorMessage,
  }) {
    return InterestListState(
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      doctors: doctors ?? this.doctors,
      clinics: clinics ?? this.clinics,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class InterestListViewModel extends Notifier<InterestListState> {
  @override
  InterestListState build() {
    Future.microtask(loadInterestList);
    return const InterestListState();
  }

  void setActiveTab(int index) {
    if (state.activeTabIndex != index) {
      state = state.copyWith(activeTabIndex: index);
    }
  }

  Future<void> loadInterestList() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final localSource = ref.read(interestLocalDataSourceProvider);

      // Resolve Doctors
      final savedDoctors = await localSource.getAllByType('doctor');
      final doctorRepo = ref.read(doctorRepositoryProvider);
      final doctorFutures = savedDoctors.map((item) async {
        try {
          return await doctorRepo.getDoctorById(item.entityId);
        } catch (e) {
          return null;
        }
      });

      // Resolve Clinics
      final savedClinics = await localSource.getAllByType('clinic');
      final clinicRepo = ref.read(clinicRepositoryProvider);
      final clinicFutures = savedClinics.map((item) async {
        try {
          return await clinicRepo.getClinicById(item.entityId);
        } catch (e) {
          return null;
        }
      });

      final results = await Future.wait([
        Future.wait(doctorFutures),
        Future.wait(clinicFutures),
      ]);

      final resolvedDoctors = results[0].whereType<DoctorEntity>().toList();
      final resolvedClinics = results[1].whereType<ClinicEntity>().toList();

      state = state.copyWith(
        doctors: resolvedDoctors,
        clinics: resolvedClinics,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> toggleInterest(String entityId, String entityType) async {
    final localSource = ref.read(interestLocalDataSourceProvider);
    final isFav = await localSource.isInterested(entityId, entityType);
    if (isFav) {
      await localSource.remove(entityId, entityType);
    } else {
      await localSource.add(entityId, entityType);
    }
    await loadInterestList();
  }
}

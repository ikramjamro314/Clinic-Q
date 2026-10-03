import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/exception_mapper.dart';
import '../clinic_providers.dart';
import 'clinic_state.dart';

class ClinicNotifier extends Notifier<ClinicState> {
  @override
  ClinicState build() {
    // Initial fetch on build
    Future.microtask(_loadInitialData);
    return const ClinicState(isLoading: true);
  }

  Future<void> _loadInitialData({bool forceRefresh = false}) async {
    state = state.copyWith(isLoading: true).clearError();

    try {
      final repository = ref.read(clinicRepositoryProvider);
      
      final all = await repository.getAllClinics(
        city: state.city,
        specialty: state.specialty,
        search: state.searchQuery,
        forceRefresh: forceRefresh,
      );

      final hasCache = all.isNotEmpty && all.any((e) => e.isFromCache);
      state = state.copyWith(
        isLoading: false,
        clinics: all,
        isFromCache: hasCache,
        errorMessage: hasCache ? all.firstWhere((e) => e.isFromCache).cacheError : null,
      );
    } catch (e) {
      final appEx = mapErrorToException(e);
      state = state.copyWith(
        isLoading: false,
        errorMessage: appEx.message,
        isFromCache: false,
      );
    }
  }

  Future<void> searchClinics(String query) async {
    final trimmed = query.trim();
    state = state.copyWith(searchQuery: trimmed, isLoading: true).clearError();

    try {
      final repository = ref.read(clinicRepositoryProvider);
      
      final all = await repository.getAllClinics(
        city: state.city,
        specialty: state.specialty,
        search: trimmed.isEmpty ? null : trimmed,
      );

      final hasCache = all.isNotEmpty && all.any((e) => e.isFromCache);
      state = state.copyWith(
        isLoading: false,
        clinics: all,
        isFromCache: hasCache,
        errorMessage: hasCache ? all.firstWhere((e) => e.isFromCache).cacheError : null,
      );
    } catch (e) {
      final appEx = mapErrorToException(e);
      state = state.copyWith(
        isLoading: false,
        errorMessage: appEx.message,
        isFromCache: false,
      );
    }
  }

  void resetSearch() {
    if (state.searchQuery != null && state.searchQuery!.isNotEmpty) {
      searchClinics('');
    }
  }

  /// Sets city and/or specialty filters and triggers a clinic refresh.
  Future<void> filterClinics({String? city, String? specialty}) async {
    state = state.copyWith(
      city: city,
      specialty: specialty,
      isLoading: true,
    ).clearError();

    try {
      final repository = ref.read(clinicRepositoryProvider);
      final all = await repository.getAllClinics(
        city: city,
        specialty: specialty,
        search: state.searchQuery,
      );

      final hasCache = all.isNotEmpty && all.any((e) => e.isFromCache);
      state = state.copyWith(
        isLoading: false,
        clinics: all,
        isFromCache: hasCache,
        errorMessage: hasCache ? all.firstWhere((e) => e.isFromCache).cacheError : null,
      );
    } catch (e) {
      final appEx = mapErrorToException(e);
      state = state.copyWith(
        isLoading: false,
        errorMessage: appEx.message,
        isFromCache: false,
      );
    }
  }

  Future<void> refresh() async {
    await _loadInitialData(forceRefresh: true);
  }
}

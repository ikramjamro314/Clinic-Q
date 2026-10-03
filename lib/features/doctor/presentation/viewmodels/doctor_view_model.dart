import 'package:clinic_q/features/doctor/domain/entities/doctor_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/exception_mapper.dart';
import '../doctor_providers.dart';
import 'doctor_state.dart';

class DoctorNotifier extends Notifier<DoctorState> {
  @override
  DoctorState build() {
    // Initial fetch on build
    Future.microtask(_loadInitialData);
    return const DoctorState(isLoading: true);
  }

  static List<DoctorEntity> _computeFilteredDoctors({
    required List<DoctorEntity> allDoctors,
    required String searchQuery,
    required Map<String, dynamic> filters,
  }) {
    var result = List<DoctorEntity>.from(allDoctors);

    // 1. Filter by specialties
    final specialtiesList = filters['specialties'] as List<String>?;
    final specialization =
        (specialtiesList != null && specialtiesList.isNotEmpty)
        ? specialtiesList.first
        : (filters['specialization'] as String? ??
              filters['specialty'] as String?);

    if (specialtiesList != null && specialtiesList.isNotEmpty) {
      result = result
          .where(
            (doc) => specialtiesList.any(
              (s) => s.toLowerCase() == doc.specialty.toLowerCase(),
            ),
          )
          .toList();
    } else if (specialization != null && specialization.trim().isNotEmpty) {
      final specQuery = specialization.trim().toLowerCase();
      result = result
          .where((doc) => doc.specialty.toLowerCase() == specQuery)
          .toList();
    }

    // 2. Filter by clinic ID
    final clinicId =
        filters['clinicId'] as String? ?? filters['clinic_id'] as String?;
    if (clinicId != null && clinicId.trim().isNotEmpty) {
      result = result.where((doc) => doc.clinicId == clinicId.trim()).toList();
    }

    // 3. Filter by search query
    final trimmedQuery = searchQuery.trim().toLowerCase();
    if (trimmedQuery.isNotEmpty) {
      result = result.where((doc) {
        final nameMatch = doc.name.toLowerCase().contains(trimmedQuery);
        final specMatch = doc.specialty.toLowerCase().contains(trimmedQuery);
        final qualMatch =
            doc.qualification != null &&
            doc.qualification!.toLowerCase().contains(trimmedQuery);
        return nameMatch || specMatch || qualMatch;
      }).toList();
    }

    return result;
  }

  Future<void> _loadInitialData({bool forceRefresh = false}) async {
    state = state.copyWith(isLoading: true).clearError();

    try {
      final repository = ref.read(doctorRepositoryProvider);

      final interested = await repository.getInterestedDoctors(
        forceRefresh: forceRefresh,
      );
      final all = await repository.getAllDoctors(forceRefresh: forceRefresh);

      final hasCache =
          (interested.isNotEmpty && interested.any((e) => e.isFromCache)) ||
          (all.isNotEmpty && all.any((e) => e.isFromCache));
      final cacheErr =
          interested.isNotEmpty && interested.any((e) => e.isFromCache)
          ? interested.firstWhere((e) => e.isFromCache).cacheError
          : (all.isNotEmpty && all.any((e) => e.isFromCache)
                ? all.firstWhere((e) => e.isFromCache).cacheError
                : null);

      final filtered = _computeFilteredDoctors(
        allDoctors: all,
        searchQuery: state.searchQuery,
        filters: state.filters,
      );

      state = state.copyWith(
        isLoading: false,
        interestedDoctors: interested,
        allDoctors: all,
        filteredDoctors: filtered,
        isFromCache: hasCache,
        errorMessage: cacheErr,
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

  void searchDoctors(String query) {
    final trimmed = query.trim();
    if (state.allDoctors.isEmpty && state.isLoading) {
      state = state.copyWith(searchQuery: trimmed);
      return;
    }

    final filtered = _computeFilteredDoctors(
      allDoctors: state.allDoctors,
      searchQuery: trimmed,
      filters: state.filters,
    );

    state = state.copyWith(searchQuery: trimmed, filteredDoctors: filtered);
  }

  void resetSearch() {
    if (state.searchQuery.isNotEmpty) {
      final filtered = _computeFilteredDoctors(
        allDoctors: state.allDoctors,
        searchQuery: '',
        filters: state.filters,
      );

      state = state.copyWith(searchQuery: '', filteredDoctors: filtered);
    }
  }

  void applyFilters(Map<String, dynamic> filters) {
    final filtered = _computeFilteredDoctors(
      allDoctors: state.allDoctors,
      searchQuery: state.searchQuery,
      filters: filters,
    );

    state = state.copyWith(filters: filters, filteredDoctors: filtered);
  }

  Future<void> refresh() async {
    await _loadInitialData(forceRefresh: true);
  }
}

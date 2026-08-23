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

  Future<void> _loadInitialData() async {
    state = state.copyWith(isLoading: true).clearError();

    try {
      final repository = ref.read(doctorRepositoryProvider);
      
      final interested = await repository.getInterestedDoctors();
      final all = await repository.getAllDoctors();

      final hasCache = (interested.isNotEmpty && interested.any((e) => e.isFromCache)) ||
          (all.isNotEmpty && all.any((e) => e.isFromCache));
      final cacheErr = interested.isNotEmpty && interested.any((e) => e.isFromCache)
          ? interested.firstWhere((e) => e.isFromCache).cacheError
          : (all.isNotEmpty && all.any((e) => e.isFromCache)
              ? all.firstWhere((e) => e.isFromCache).cacheError
              : null);

      state = state.copyWith(
        isLoading: false,
        interestedDoctors: interested,
        allDoctors: all,
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

  Future<void> searchDoctors(String query) async {
    state = state.copyWith(searchQuery: query, isLoading: true).clearError();

    try {
      final repository = ref.read(doctorRepositoryProvider);
      
      final all = await repository.getAllDoctors(query: query, filters: state.filters);

      final hasCache = all.isNotEmpty && all.any((e) => e.isFromCache);
      state = state.copyWith(
        isLoading: false,
        allDoctors: all,
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

  Future<void> applyFilters(Map<String, dynamic> filters) async {
    state = state.copyWith(filters: filters, isLoading: true).clearError();

    try {
      final repository = ref.read(doctorRepositoryProvider);
      
      final all = await repository.getAllDoctors(query: state.searchQuery, filters: filters);

      final hasCache = all.isNotEmpty && all.any((e) => e.isFromCache);
      state = state.copyWith(
        isLoading: false,
        allDoctors: all,
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
    await _loadInitialData();
  }
}

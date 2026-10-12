import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../providers.dart';
import 'appointment_state.dart';

class AppointmentNotifier extends Notifier<AppointmentState> {
  @override
  AppointmentState build() {
    return const AppointmentState();
  }

  Future<void> fetchTokens({
    String? doctorId,
    String? clinicId,
    String? userId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final tokens = await ref.read(appointmentRepositoryProvider).getTokens(
            doctorId: doctorId,
            clinicId: clinicId,
            userId: userId,
          );
      final isFromCache = tokens.any((t) => t.isFromCache);
      state = state.copyWith(
        tokens: tokens,
        isLoading: false,
        isFromCache: isFromCache,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<bool> createToken({
    required String doctorId,
    required String clinicId,
    required String userId,
    String? appointmentDate,
    bool? isFuture,
    String? notes,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final token = await ref.read(appointmentRepositoryProvider).createToken(
            doctorId: doctorId,
            clinicId: clinicId,
            userId: userId,
            appointmentDate: appointmentDate,
            isFuture: isFuture,
            notes: notes,
          );
      state = state.copyWith(
        tokens: [token, ...state.tokens],
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Patches the in-memory token list with a status reported by live data
  /// (e.g. cancelled, completed, skipped) without hitting the repository.
  void markTokenStatus(String id, String status) {
    final updatedTokens = state.tokens.map((t) {
      if (t.id == id && t.normalizedStatus != status.toLowerCase().trim()) {
        return t.copyWith(status: status);
      }
      return t;
    }).toList();

    state = state.copyWith(tokens: updatedTokens);
  }

  void markTokenCancelled(String id) => markTokenStatus(id, 'cancelled');

  Future<bool> cancelToken(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await ref.read(appointmentRepositoryProvider).cancelToken(id);

      markTokenCancelled(id);

      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> deleteToken(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await ref.read(appointmentRepositoryProvider).deleteToken(id);
      
      // Update local state by removing the deleted token
      final updatedTokens = state.tokens.where((t) => t.id != id).toList();
      
      state = state.copyWith(
        tokens: updatedTokens,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}

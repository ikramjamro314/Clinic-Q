import 'dart:async';
import 'package:clinic_q/features/tracking/domain/entities/token.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../providers.dart';
import 'tracking_state.dart';
import '../../../ratings/presentation/ratings_providers.dart';
import '../../../auth/presentation/auth_providers.dart';
import '../../../doctor/presentation/doctor_providers.dart';

class TrackingNotifier extends Notifier<TrackingState> {
  TrackingNotifier(this.tokenId);
  final String tokenId;

  StreamSubscription? _socketSubscription;

  @override
  TrackingState build() {
    ref.onDispose(() {
      _unsubscribeFromWebSocket();
    });

    _subscribeToWebSocket();

    return const TrackingState(isLoading: true);
  }

  void _subscribeToWebSocket() {
    _unsubscribeFromWebSocket();

    _socketSubscription = ref
        .read(trackingRepositoryProvider)
        .getLiveTrackingStream(tokenId)
        .listen(
          (snapshot) {
            state = state.copyWith(snapshot: snapshot, isLoading: false);

            // Live data is the source of truth: when the token reaches a
            // terminal status (cancelled / completed / skipped / missed...),
            // stop listening and sync the appointment list so the home
            // banner and active-token lookup reset immediately.
            if (snapshot.isClosed) {
              _unsubscribeFromWebSocket();
              ref
                  .read(appointmentViewModelProvider.notifier)
                  .markTokenStatus(tokenId, snapshot.status);
            }
          },
          onError: (e) {
            state = state.copyWith(
              isLoading: false,
              errorMessage: e.toString(),
            );
          },
        );
  }

  void _unsubscribeFromWebSocket() {
    _socketSubscription?.cancel();
    _socketSubscription = null;
  }

  Future<bool> cancelTrackingToken() async {
    debugPrint(
      '[Tracking] Cancel requested for tokenId=$tokenId — delegating to AppointmentRepository.cancelToken',
    );
    _unsubscribeFromWebSocket();

    try {
      // Single repository call: hits the cancel API (with local-cache
      // fallback) and marks the cached row as cancelled.
      await ref.read(appointmentRepositoryProvider).cancelToken(tokenId);
      // Patch the in-memory token list without hitting the repo again.
      ref
          .read(appointmentViewModelProvider.notifier)
          .markTokenCancelled(tokenId);

      if (state.snapshot != null) {
        state = state.copyWith(
          snapshot: state.snapshot!.copyWith(status: 'cancelled'),
          wasUserCancelled: true,
        );
      } else {
        state = state.copyWith(wasUserCancelled: true);
      }
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  void updateFeedbackRating(int rating) {
    state = state.copyWith(feedbackRating: rating);
  }

  void updateFeedbackText(String text) {
    state = state.copyWith(feedbackText: text);
  }

  Future<bool> submitFeedback() async {
    state = state.copyWith(isFeedbackSubmitting: true);
    try {
      final tokens = await ref.read(appointmentRepositoryProvider).getTokens();
      Token? token;
      try {
        token = tokens.firstWhere((t) => t.id == tokenId);
      } catch (_) {
        if (state.snapshot != null &&
            state.snapshot!.fullTokenList.isNotEmpty) {
          try {
            token = state.snapshot!.fullTokenList.firstWhere(
              (t) => t.id == tokenId,
            );
          } catch (_) {
            token = state.snapshot!.fullTokenList.first;
          }
        }
      }

      if (token == null) {
        throw Exception("Appointment token details not found.");
      }

      final currentUser = ref.read(authRepositoryProvider).getCurrentUser();
      final userId = currentUser?.id ?? token.userId;

      await ref
          .read(ratingsRepositoryProvider)
          .submitFeedback(
            doctorId: token.doctorId,
            clinicId: token.clinicId,
            stars: state.feedbackRating.clamp(1, 5),
            review: state.feedbackText,
            userId: userId,
          );

      state = state.copyWith(
        isFeedbackSubmitting: false,
        isFeedbackSubmitted: true,
      );
      // Ensure the appointment list reflects completion even when the live
      // stream already stopped (autoDispose) — keeps the home banner reset.
      ref
          .read(appointmentViewModelProvider.notifier)
          .markTokenStatus(tokenId, 'completed');
      return true;
    } catch (e) {
      state = state.copyWith(
        isFeedbackSubmitting: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}

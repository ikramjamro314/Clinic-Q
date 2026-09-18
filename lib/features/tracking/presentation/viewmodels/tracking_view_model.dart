import 'dart:async';
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
            state = state.copyWith(
              snapshot: snapshot,
              isLoading: false,
              isFromCache: snapshot.isFromCache,
              isStale: snapshot.isStale,
            );
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
      await ref.read(appointmentRepositoryProvider).cancelToken(tokenId);

      if (state.snapshot != null) {
        state = state.copyWith(
          snapshot: state.snapshot!.copyWith(status: 'cancelled'),
        );
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
      final token = tokens.firstWhere((t) => t.id == tokenId);
      
      final currentUser = ref.read(authRepositoryProvider).getCurrentUser();
      if (currentUser == null) throw Exception("Please login to submit feedback.");

      await ref.read(ratingsRepositoryProvider).submitFeedback(
        doctorId: token.doctorId,
        clinicId: token.clinicId,
        stars: state.feedbackRating,
        review: state.feedbackText,
        userId: currentUser.id,
      );

      state = state.copyWith(
        isFeedbackSubmitting: false,
        isFeedbackSubmitted: true,
      );
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

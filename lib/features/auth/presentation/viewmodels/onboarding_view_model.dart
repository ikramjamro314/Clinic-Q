import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final int currentIndex;
  final int totalSlides;

  const OnboardingState({this.currentIndex = 0, this.totalSlides = 3});

  OnboardingState copyWith({int? currentIndex, int? totalSlides}) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      totalSlides: totalSlides ?? this.totalSlides,
    );
  }
}

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() {
    return const OnboardingState();
  }

  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void nextPage(PageController controller, VoidCallback onComplete) {
    if (state.currentIndex < state.totalSlides - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      onComplete();
    }
  }
}

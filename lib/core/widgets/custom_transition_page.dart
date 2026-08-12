import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppTransitionType {
  fadeSlide,
  fade,
  slideUp,
  slideLeft,
}

CustomTransitionPage<T> buildPageWithTransition<T>({
  required GoRouterState state,
  required Widget child,
  AppTransitionType transitionType = AppTransitionType.fadeSlide,
}) {
  final Duration duration;
  switch (transitionType) {
    case AppTransitionType.fadeSlide:
      duration = const Duration(milliseconds: 300);
      break;
    case AppTransitionType.fade:
      duration = const Duration(milliseconds: 400);
      break;
    case AppTransitionType.slideUp:
    case AppTransitionType.slideLeft:
      duration = const Duration(milliseconds: 350);
      break;
  }

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case AppTransitionType.fadeSlide:
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            ),
          );
        case AppTransitionType.fade:
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          );
        case AppTransitionType.slideUp:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        case AppTransitionType.slideLeft:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
      }
    },
  );
}

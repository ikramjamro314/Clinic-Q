import 'package:clinic_q/features/ratings/presentation/screens/all_reviews_screen.dart';
import 'package:clinic_q/features/tracking/presentation/screens/tracking_screen.dart';
import 'package:clinic_q/features/tracking/presentation/screens/token_info_screen.dart';
import 'package:clinic_q/features/tracking/presentation/screens/confirm_booking_screen.dart';
import 'package:clinic_q/features/tracking/presentation/screens/booking_success_screen.dart';
import 'package:clinic_q/features/tracking/presentation/screens/appointment_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/auth_providers.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/onboarding_screen.dart';
import '../features/auth/presentation/screens/clinic_marketing_screen.dart';
import '../features/auth/presentation/screens/role_selection_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/otp_verification_screen.dart';
import '../features/auth/presentation/screens/profile_details_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/profile/presentation/screens/interest_list_screen.dart';
import '../features/profile/presentation/screens/terms_and_policy_screen.dart';
import '../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../features/profile/presentation/screens/faq_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/clinic/presentation/screens/clinic_screen.dart';
import '../features/clinic/presentation/screens/clinic_view_screen.dart';
import '../features/clinic/presentation/screens/select_doctor_screen.dart';
import '../features/doctor/presentation/screens/doctor_screen.dart';
import '../features/doctor/presentation/screens/filter_screen.dart';
import '../features/doctor/presentation/screens/doctor_profile_screen.dart';
import '../core/widgets/custom_transition_page.dart';
import 'app_routes.dart';

final initialLocationProvider = Provider<String>((ref) => AppRoutes.splash);

final routerProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final initialLocation = ref.watch(initialLocationProvider);

  return GoRouter(
    initialLocation: initialLocation,
    redirect: (context, state) {
      debugPrint(
        '>>> GO_ROUTER REDIRECT: matchedLocation = ${state.matchedLocation}',
      );
      // Allow initial launch to stay on splash screen so animation plays for full 2.5s duration
      if (state.matchedLocation == AppRoutes.splash) {
        return null;
      }

      final isAuthenticated = authRepository.getCurrentUser() != null;
      final isAuthRoute =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.onboarding ||
          state.matchedLocation == AppRoutes.otpVerification ||
          state.matchedLocation == AppRoutes.clinicMarketing ||
          state.matchedLocation == AppRoutes.roleSelection ||
          state.matchedLocation == AppRoutes.walkInEntry;

      if (!isAuthenticated) {
        if (!isAuthRoute) {
          return AppRoutes.splash;
        }
        return null;
      }

      // If authenticated, don't allow auth routes, redirect to home
      if (isAuthRoute) {
        return AppRoutes.home;
      }

      // Redirect for Profile routes when profile does not exist
      final isProfileRoute =
          state.matchedLocation.startsWith('/profile') &&
          state.matchedLocation != AppRoutes.profileDetails;
      final hasProfile = ref.read(hasProfileProvider);
      if (isProfileRoute && hasProfile == false) {
        return AppRoutes.profileDetails;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) =>
            buildPageWithTransition(state: state, child: const SplashScreen()),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.clinicMarketing,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const ClinicMarketingScreen(),
          transitionType: AppTransitionType.fade,
        ),
      ),
      GoRoute(
        path: AppRoutes.roleSelection,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const RoleSelectionScreen(),
          transitionType: AppTransitionType.slideUp,
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const LoginScreen(),
          transitionType: AppTransitionType.slideLeft,
        ),
      ),
      GoRoute(
        path: AppRoutes.walkInEntry,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const LoginScreen(),
          transitionType: AppTransitionType.slideLeft,
        ),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        pageBuilder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          return buildPageWithTransition(
            state: state,
            child: OtpVerificationScreen(email: email),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.profileDetails,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const ProfileDetailsScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.profile,
        pageBuilder: (context, state) =>
            buildPageWithTransition(state: state, child: const ProfileScreen()),
      ),
      GoRoute(
        path: AppRoutes.profileEdit,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const EditProfileScreen(),
          transitionType: AppTransitionType.slideLeft,
        ),
      ),
      GoRoute(
        path: AppRoutes.profileInterestList,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const InterestListScreen(),
          transitionType: AppTransitionType.slideLeft,
        ),
      ),
      GoRoute(
        path: AppRoutes.profileTermsAndPolicy,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const TermsAndPolicyScreen(),
          transitionType: AppTransitionType.slideLeft,
        ),
      ),
      GoRoute(
        path: AppRoutes.profilePrivacyPolicy,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const PrivacyPolicyScreen(),
          transitionType: AppTransitionType.slideLeft,
        ),
      ),
      GoRoute(
        path: AppRoutes.profileFAQ,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const FAQScreen(),
          transitionType: AppTransitionType.slideLeft,
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) =>
            buildPageWithTransition(state: state, child: const HomeScreen()),
      ),
      GoRoute(
        path: AppRoutes.clinics,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const ClinicScreen(),
          transitionType: AppTransitionType.fade,
        ),
      ),
      GoRoute(
        path: AppRoutes.doctors,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const DoctorScreen(),
          transitionType: AppTransitionType.fade,
        ),
      ),
      GoRoute(
        path: AppRoutes.doctorFilter,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const FilterScreen(),
          transitionType: AppTransitionType.slideUp,
        ),
      ),
      GoRoute(
        path: AppRoutes.doctorProfile,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return buildPageWithTransition(
            state: state,
            child: DoctorProfileScreen(doctorId: id),
            transitionType: AppTransitionType.slideLeft,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.allReviews,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return buildPageWithTransition(
            state: state,
            child: AllReviewsScreen(doctorId: id),
            transitionType: AppTransitionType.slideLeft,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.clinicView,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return buildPageWithTransition(
            state: state,
            child: ClinicViewScreen(clinicId: id),
            transitionType: AppTransitionType.slideLeft,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.selectDoctor,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return buildPageWithTransition(
            state: state,
            child: SelectDoctorScreen(clinicId: id),
            transitionType: AppTransitionType.slideLeft,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.trackingDebug,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const TrackingScreen(),
          transitionType: AppTransitionType.fade,
        ),
      ),
      GoRoute(
        path: AppRoutes.appointmentHistory,
        pageBuilder: (context, state) => buildPageWithTransition(
          state: state,
          child: const AppointmentHistoryScreen(),
          transitionType: AppTransitionType.slideLeft,
        ),
      ),
      GoRoute(
        path: AppRoutes.tracking,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return buildPageWithTransition(
            state: state,
            child: TrackingScreen(tokenId: id),
            transitionType: AppTransitionType.slideLeft,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.bookingTokenInfo,
        pageBuilder: (context, state) {
          final doctorId = state.uri.queryParameters['doctorId'] ?? '';
          final clinicId = state.uri.queryParameters['clinicId'] ?? '';
          return buildPageWithTransition(
            state: state,
            child: TokenInfoScreen(doctorId: doctorId, clinicId: clinicId),
            transitionType: AppTransitionType.slideLeft,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.bookingConfirm,
        pageBuilder: (context, state) {
          final doctorId = state.uri.queryParameters['doctorId'] ?? '';
          final clinicId = state.uri.queryParameters['clinicId'] ?? '';
          final extra = state.extra as TokenInfoData?;
          return buildPageWithTransition(
            state: state,
            child: ConfirmBookingScreen(
              doctorId: doctorId,
              clinicId: clinicId,
              initialData: extra,
            ),
            transitionType: AppTransitionType.slideLeft,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.bookingSuccess,
        pageBuilder: (context, state) {
          final extra = state.extra as BookingSuccessParams?;
          if (extra == null) {
            return buildPageWithTransition(
              state: state,
              child: const Scaffold(body: Center(child: Text('Invalid State'))),
            );
          }
          return buildPageWithTransition(
            state: state,
            child: BookingSuccessScreen(
              doctor: extra.doctor,
              preview: extra.preview,
              token: extra.token,
            ),
            transitionType: AppTransitionType.slideLeft,
          );
        },
      ),
    ],
  );
});

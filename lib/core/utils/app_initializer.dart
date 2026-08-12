import 'package:shared_preferences/shared_preferences.dart';
import '../../app/app_routes.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

class AppInitializer {
  static const String _onboardingKey = 'has_seen_onboarding';

  static Future<String> initializeAndGetRoute() async {
    return AppRoutes.splash;
  }

  static Future<String> getNextRoute(AuthRepository authRepository) async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool(_onboardingKey) ?? false;

    if (!hasSeenOnboarding) {
      return AppRoutes.onboarding;
    }

    final user = authRepository.getCurrentUser();

    if (user == null) {
      return AppRoutes.roleSelection;
    }

    return AppRoutes.home;
  }

  static Future<void> markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }
}

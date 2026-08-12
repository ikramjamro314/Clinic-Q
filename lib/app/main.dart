import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/theme/clinic_q_theme.dart';
import '../core/utils/app_initializer.dart';
import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('Warning: .env file not found');
  }

  final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  final supabaseKey = dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? '';

  debugPrint('>>> SUPABASE URL LOADED: $supabaseUrl');
  debugPrint('>>> SUPABASE KEY LOADED: ${supabaseKey.substring(0, 8)}...');

  await Supabase.initialize(url: supabaseUrl, publishableKey: supabaseKey);

  await GoogleSignIn.instance.initialize(
    clientId: dotenv.env['GOOGLE_IOS_CLIENT_ID'],
    serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
  );

  final initialRoute = await AppInitializer.initializeAndGetRoute();

  runApp(
    ProviderScope(
      overrides: [initialLocationProvider.overrideWithValue(initialRoute)],
      child: const ClinicQApp(),
    ),
  );
}

class ClinicQApp extends ConsumerWidget {
  const ClinicQApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'ClinicQ',
      theme: ClinicQTheme.light(),
      darkTheme: ClinicQTheme.dark(),
      themeMode: ThemeMode.light,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_routes.dart';
import '../../../auth/presentation/auth_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinic Discovery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // Sign out logic
              await ref.read(authRepositoryProvider).signOut();
              if (context.mounted) {
                context.go(AppRoutes.login);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              'Welcome Home',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text('You are successfully logged in!'),
          ],
        ),
      ),
    );
  }
}

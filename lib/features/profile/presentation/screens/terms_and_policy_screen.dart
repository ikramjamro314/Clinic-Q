import 'package:clinic_q/app/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../profile_providers.dart';
import '../widgets/profile_menu_item.dart';
import 'static_content_screen.dart';

class TermsAndPolicyScreen extends ConsumerWidget {
  const TermsAndPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final repo = ref.read(contentRepositoryProvider);

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        title: Text(
          'Terms and Policy',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: ClinicQColors.textPrimary,
          ),
        ),
        backgroundColor: ClinicQColors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ClinicQColors.textPrimary,
            size: 20,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.profile);
            }
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            ProfileMenuItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy policy',
              onTap: () => context.push('/profile/privacy-policy'),
            ),
            ProfileMenuItem(
              icon: Icons.gavel_outlined,
              title: 'Terms of use',
              onTap: () async {
                final content = await repo.getTermsOfUse();
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StaticContentScreen(
                        title: 'Terms of use',
                        content: content,
                      ),
                    ),
                  );
                }
              },
            ),
            ProfileMenuItem(
              icon: Icons.rule_folder_outlined,
              title: 'Regulations on booking activities',
              onTap: () async {
                final content = await repo.getRegulations();
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StaticContentScreen(
                        title: 'Regulations',
                        content: content,
                      ),
                    ),
                  );
                }
              },
            ),
            ProfileMenuItem(
              icon: Icons.support_agent_outlined,
              title: 'Complaint handling process',
              onTap: () async {
                final content = await repo.getComplaintHandling();
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StaticContentScreen(
                        title: 'Complaint handling process',
                        content: content,
                      ),
                    ),
                  );
                }
              },
            ),
            ProfileMenuItem(
              icon: Icons.info_outline_rounded,
              title: 'About',
              onTap: () async {
                final content = await repo.getAbout();
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StaticContentScreen(
                        title: 'About ClinicQ',
                        content: content,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:clinic_q/features/tracking/presentation/screens/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart' as ul;
import '../../../../app/app_routes.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/feedback/offline_banner.dart';
import '../../../home/presentation/widgets/home_bottom_nav_bar.dart';
import '../profile_providers.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(profileViewModelProvider);
    final notifier = ref.read(profileViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: ClinicQColors.textPrimary,
          ),
        ),
        backgroundColor: ClinicQColors.cardBackground,
        elevation: 0,
        automaticallyImplyLeading: false, // bottom nav tab destination
      ),
      body: Column(
        children: [
          if (state.profile?.isFromCache ?? false)
            OfflineBanner(message: state.profile?.cacheError),
          Expanded(
            child: Builder(
              builder: (context) {
                // Skeleton loading state
                if (state.isLoading && state.profile == null) {
                  return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SkeletonBox(
                                width: 80,
                                height: 80,
                                borderRadius: 40,
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SkeletonBox(
                                    width: 120,
                                    height: 20,
                                    borderRadius: 4,
                                  ),
                                  const SizedBox(height: 8),
                                  const SkeletonBox(
                                    width: 160,
                                    height: 14,
                                    borderRadius: 4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          ...List.generate(
                            4,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: SkeletonBox(
                                width: double.infinity,
                                height: 56,
                                borderRadius: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Error State
                if (state.errorMessage != null && state.profile == null) {
                  return Center(
                    child: ClinicQErrorWidget(
                      message: state.errorMessage!,
                      onRetry: () => notifier.fetchProfile(),
                    ),
                  );
                }

                final profile = state.profile;
                final initials = profile != null && profile.name.isNotEmpty
                    ? profile.name
                          .trim()
                          .split(' ')
                          .map((e) => e[0])
                          .take(2)
                          .join()
                          .toUpperCase()
                    : 'U';

                return RefreshIndicator(
                  onRefresh: () async => notifier.fetchProfile(),
                  color: ClinicQColors.primaryTeal,
                  child: ListView(
                    padding: const EdgeInsets.all(20.0),
                    children: [
                      // Header Row Card
                      InkWell(
                        onTap: () => context.push('/profile/edit'),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: ClinicQColors.cardBackground,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: ClinicQColors.cardBorder),
                            boxShadow: [
                              BoxShadow(
                                color: ClinicQColors.cardShadow.withOpacity(
                                  0.04,
                                ),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Avatar circle
                              CircleAvatar(
                                radius: 36,
                                backgroundColor: ClinicQColors.primaryTeal
                                    .withOpacity(0.1),
                                child: Text(
                                  initials,
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                        color: ClinicQColors.primaryTeal,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Name and Info chevron
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile?.name ?? 'User Name',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: ClinicQColors.textPrimary,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Personal information',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  color: ClinicQColors
                                                      .textSecondary,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.chevron_right_rounded,
                                          color: ClinicQColors.textSecondary,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Visual Notification Bell
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: ClinicQColors.secondaryBackground,
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    const Icon(
                                      Icons.notifications_none_rounded,
                                      color: ClinicQColors.textPrimary,
                                      size: 24,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: ClinicQColors.tokenActive,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Menu items in a single grouped container card block
                      Container(
                        decoration: BoxDecoration(
                          color: ClinicQColors.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ClinicQColors.cardBorder),
                          boxShadow: [
                            BoxShadow(
                              color: ClinicQColors.cardShadow.withOpacity(0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ProfileMenuItem(
                              icon: Icons.bookmark_border_rounded,
                              title: 'Interest list',
                              onTap: () =>
                                  context.push('/profile/interest-list'),
                            ),
                            const Divider(
                              height: 1,
                              color: ClinicQColors.cardBorder,
                              indent: 16,
                              endIndent: 16,
                            ),
                            ProfileMenuItem(
                              icon: Icons.group_outlined,
                              title: 'Join the community',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Community feature coming soon!',
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Divider(
                              height: 1,
                              color: ClinicQColors.cardBorder,
                              indent: 16,
                              endIndent: 16,
                            ),
                            ProfileMenuItem(
                              icon: Icons.description_outlined,
                              title: 'Terms and Policy',
                              onTap: () =>
                                  context.push('/profile/terms-and-policy'),
                            ),
                            const Divider(
                              height: 1,
                              color: ClinicQColors.cardBorder,
                              indent: 16,
                              endIndent: 16,
                            ),
                            ProfileMenuItem(
                              icon: Icons.question_answer_outlined,
                              title: 'Frequently asked questions',
                              onTap: () => context.push('/profile/faq'),
                            ),
                            const Divider(
                              height: 1,
                              color: ClinicQColors.cardBorder,
                              indent: 16,
                              endIndent: 16,
                            ),
                            ProfileMenuItem(
                              icon: Icons.phone_in_talk_outlined,
                              title: 'Hotline 1900-2020',
                              onTap: () async {
                                final uri = Uri.parse('tel:1900-2020');
                                if (await ul.canLaunchUrl(uri)) {
                                  await ul.launchUrl(uri);
                                }
                              },
                            ),
                            const Divider(
                              height: 1,
                              color: ClinicQColors.cardBorder,
                              indent: 16,
                              endIndent: 16,
                            ),
                            ProfileMenuItem(
                              icon: Icons.logout_rounded,
                              iconColor: ClinicQColors.tokenMissed,
                              title: 'Log out',
                              textColor: ClinicQColors.tokenMissed,
                              onTap: () async {
                                await notifier.signOut();
                                if (context.mounted) {
                                  context.go(AppRoutes.splash);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          if (index == 0) {
            context.go(AppRoutes.clinics);
          } else if (index == 1) {
            context.go(AppRoutes.doctors);
          } else if (index == 2) {
            context.go(AppRoutes.home);
          } else if (index == 3) {
            final activeToken = ref.read(activeTokenLookupProvider).value;
            context.go('/tracking/${activeToken?.id ?? "none"}');
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/feedback/offline_banner.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/buttons/clinicq_outlined_button.dart';
import '../../../home/presentation/widgets/home_bottom_nav_bar.dart';
import '../../../doctor/presentation/doctor_providers.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../domain/entities/token.dart';
import '../providers.dart';
import '../widgets/doctor_queue_card.dart';
import '../widgets/queue_stat_box.dart';
import '../widgets/queue_progress_row.dart';

/// Resolves the Doctor associated with a given Token ID
final trackingDoctorProvider = FutureProvider.family<DoctorEntity?, String>((ref, tokenId) async {
  try {
    final tokens = await ref.read(appointmentRepositoryProvider).getTokens();
    final token = tokens.firstWhere((t) => t.id == tokenId);
    return ref.read(doctorRepositoryProvider).getDoctorById(token.doctorId);
  } catch (e) {
    debugPrint('[Tracking] Failed to resolve doctor for tokenId=$tokenId: $e');
    return null;
  }
});

/// Checks if there is an active token for the current user
final activeTokenLookupProvider = FutureProvider<Token?>((ref) async {
  try {
    final tokens = await ref.read(appointmentRepositoryProvider).getTokens();
    final active = tokens.where((t) => t.status != 'completed' && t.status != 'cancelled').toList();
    if (active.isNotEmpty) {
      // Return the most recent active token
      active.sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
      return active.first;
    }
  } catch (e) {
    debugPrint('[Tracking] Error looking up active token: $e');
  }
  return null;
});

class TrackingScreen extends ConsumerWidget {
  final String? tokenId;

  const TrackingScreen({
    super.key,
    this.tokenId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tokenId != null) {
      return _TrackingContent(tokenId: tokenId!);
    }

    final activeTokenAsync = ref.watch(activeTokenLookupProvider);

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.appBackground,
        elevation: 0,
        title: const Text(
          'Live Tracking',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: activeTokenAsync.when(
        loading: () => const Center(child: ClinicQLoader()),
        error: (err, stack) => Center(
          child: ClinicQErrorWidget(
            message: 'Failed to look up active appointments.',
            onRetry: () => ref.refresh(activeTokenLookupProvider),
          ),
        ),
        data: (activeToken) {
          if (activeToken == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: ClinicQColors.primaryTeal.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.track_changes_rounded,
                        color: ClinicQColors.primaryTeal,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'No Active Token',
                      style: TextStyle(
                        color: ClinicQColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'You do not have any active appointments at the moment.',
                      style: TextStyle(
                        color: ClinicQColors.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ClinicQButton(
                      label: 'Book an Appointment',
                      gradient: ClinicQColors.gradientPrimary,
                      onPressed: () {
                        context.go('/home');
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return _TrackingContent(tokenId: activeToken.id, showBottomNav: true);
        },
      ),
      bottomNavigationBar: tokenId == null
          ? HomeBottomNavBar(
              currentIndex: 3,
              onTap: (index) {
                if (index == 0) {
                  context.go('/clinics');
                } else if (index == 1) {
                  context.go('/doctors');
                } else if (index == 2) {
                  context.go('/home');
                } else if (index == 3) {
                  // Already on tracking
                } else if (index == 4) {
                  context.go('/profile');
                }
              },
            )
          : null,
    );
  }
}

class _TrackingContent extends ConsumerWidget {
  final String tokenId;
  final bool showBottomNav;

  const _TrackingContent({
    required this.tokenId,
    this.showBottomNav = false,
  });

  String _formatLastSynced(DateTime dateTime) {
    final hrs = dateTime.hour.toString().padLeft(2, '0');
    final mins = dateTime.minute.toString().padLeft(2, '0');
    final secs = dateTime.second.toString().padLeft(2, '0');
    return '$hrs:$mins:$secs';
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Cancel Appointment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to cancel this appointment token? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'No, Keep It',
              style: TextStyle(color: ClinicQColors.textSecondary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ClinicQColors.errorIcon,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              final trackingNotifier = ref.read(trackingViewModelProvider(tokenId).notifier);
              final success = await trackingNotifier.cancelTrackingToken();
              if (success) {
                ref.invalidate(activeTokenLookupProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Appointment cancelled successfully.')),
                  );
                  context.go('/home');
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to cancel appointment.'),
                      backgroundColor: ClinicQColors.errorIcon,
                    ),
                  );
                }
              }
            },
            child: const Text('Yes, Cancel', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackingState = ref.watch(trackingViewModelProvider(tokenId));
    final doctorAsync = ref.watch(trackingDoctorProvider(tokenId));

    final isOffline = trackingState.isFromCache || trackingState.isStale;

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: showBottomNav
          ? null
          : AppBar(
              backgroundColor: ClinicQColors.appBackground,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: ClinicQColors.textPrimary),
                onPressed: () => context.pop(),
              ),
              title: const Text(
                'Live Tracking',
                style: TextStyle(
                  color: ClinicQColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: SafeArea(
        child: Column(
          children: [
            if (isOffline)
              const OfflineBanner(
                message: 'Connection lost — showing cached queue status',
              ),
            if (trackingState.snapshot?.status == 'paused')
              Container(
                width: double.infinity,
                color: Colors.amber.shade800,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.pause_circle_filled, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'The doctor is currently on break. The queue is temporarily paused.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: trackingState.isLoading
                  ? const Center(child: ClinicQLoader())
                  : trackingState.errorMessage != null
                      ? Center(
                          child: ClinicQErrorWidget(
                            message: trackingState.errorMessage!,
                            onRetry: () => ref.refresh(trackingViewModelProvider(tokenId)),
                          ),
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              doctorAsync.when(
                                loading: () => const Center(child: ClinicQLoader()),
                                error: (err, stack) => const SizedBox(),
                                data: (doctor) {
                                  if (doctor == null) return const SizedBox();
                                  return DoctorQueueCard(
                                    doctor: doctor,
                                    tokenNumber: trackingState.snapshot?.yourTokenNumber,
                                    nowServingNumber: trackingState.snapshot?.currentTokenNumber,
                                    dateString: 'Today',
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              if (trackingState.snapshot != null) ...[
                                Row(
                                  children: [
                                    Expanded(
                                      child: QueueStatBox(
                                        icon: Icons.people_outline_rounded,
                                        iconColor: ClinicQColors.primaryBlue,
                                        iconBackgroundColor:
                                            ClinicQColors.primaryBlue.withOpacity(0.1),
                                        value: trackingState.snapshot!.patientsAheadCount.toString(),
                                        label: 'Patients ahead of you',
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: QueueStatBox(
                                        icon: Icons.access_time_rounded,
                                        iconColor: ClinicQColors.primaryTeal,
                                        iconBackgroundColor:
                                            ClinicQColors.primaryTeal.withOpacity(0.1),
                                        value: '${trackingState.snapshot!.estimatedWaitMinutes} min',
                                        label: 'Estimated wait time',
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                QueueProgressRow(
                                  nowServingNumber: trackingState.snapshot!.currentTokenNumber,
                                  totalTokens: trackingState.snapshot!.yourTokenNumber,
                                  yourTokenNumber: trackingState.snapshot!.yourTokenNumber,
                                ),
                                const SizedBox(height: 16),
                                // Last synced timestamp
                                Center(
                                  child: Text(
                                    'Last synced at: ${_formatLastSynced(trackingState.snapshot!.lastSyncedAt)}',
                                    style: const TextStyle(
                                      color: ClinicQColors.textTertiary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                              ],
                              // Cancel Action (Outlined Red Button for destructive style)
                              if (trackingState.snapshot?.status != 'cancelled')
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: ClinicQColors.errorIcon,
                                      side: const BorderSide(color: ClinicQColors.errorIcon),
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    onPressed: () => _showCancelDialog(context, ref),
                                    icon: const Icon(Icons.cancel_outlined, size: 20),
                                    label: const Text(
                                      'Cancel Appointment',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: showBottomNav
          ? HomeBottomNavBar(
              currentIndex: 3,
              onTap: (index) {
                if (index == 0) {
                  context.go('/clinics');
                } else if (index == 1) {
                  context.go('/doctors');
                } else if (index == 2) {
                  context.go('/home');
                } else if (index == 3) {
                  // Already on tracking
                } else if (index == 4) {
                  context.go('/profile');
                }
              },
            )
          : null,
    );
  }
}

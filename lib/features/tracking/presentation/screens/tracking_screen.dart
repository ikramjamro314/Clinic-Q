import 'dart:async';
import 'package:clinic_q/features/auth/presentation/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_routes.dart';

import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../../../../core/widgets/feedback/offline_banner.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../home/presentation/widgets/home_bottom_nav_bar.dart';
import '../../../doctor/presentation/doctor_providers.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../domain/entities/token.dart';
import '../providers.dart';
import '../widgets/tracking_header_card.dart';
import '../widgets/tracking_stats_grid.dart';
import '../widgets/tracking_queue_lineup.dart';
import '../widgets/tracking_queue_timeline.dart';

/// Resolves the Doctor associated with a given Token ID
final trackingDoctorProvider = FutureProvider.family<DoctorEntity?, String>((
  ref,
  tokenId,
) async {
  try {
    // 1. Check in-memory tokens
    final inMemTokens = ref.read(appointmentViewModelProvider).tokens;
    final inMemToken = inMemTokens.where((t) => t.id == tokenId).firstOrNull;
    if (inMemToken != null && inMemToken.doctorId.isNotEmpty) {
      return ref.read(doctorRepositoryProvider).getDoctorById(inMemToken.doctorId);
    }

    // 2. Check repository tokens
    final tokens = await ref.read(appointmentRepositoryProvider).getTokens();
    final token = tokens.where((t) => t.id == tokenId).firstOrNull;
    if (token != null && token.doctorId.isNotEmpty) {
      return ref.read(doctorRepositoryProvider).getDoctorById(token.doctorId);
    }

    // 3. Fallback to cached tokens in SQLite
    final cached = await ref.read(tokensLocalDataSourceProvider).getCachedTokens();
    final cachedToken = cached.where((t) => t.id == tokenId).firstOrNull;
    if (cachedToken != null && cachedToken.doctorId.isNotEmpty) {
      return ref.read(doctorRepositoryProvider).getDoctorById(cachedToken.doctorId);
    }
  } catch (e) {
    debugPrint('[Tracking] Failed to resolve doctor for tokenId=$tokenId: $e');
  }
  return null;
});

/// Checks if there is an active token for the current user (strictly latest active appointment)
final activeTokenLookupProvider = FutureProvider.autoDispose<Token?>((ref) async {
  // Watch appointmentViewModelProvider so newly booked / fetched tokens trigger immediate re-eval
  final appState = ref.watch(appointmentViewModelProvider);
  final currentUser = ref.watch(authRepositoryProvider).getCurrentUser();

  bool isTokenActive(Token t) {
    final s = t.status.toLowerCase().trim();
    return s != 'completed' &&
        s != 'cancelled' &&
        s != 'canceled' &&
        s != 'done' &&
        s != 'rejected' &&
        s != 'missed' &&
        s != 'expired';
  }

  // 1. Check in-memory state first
  if (appState.tokens.isNotEmpty) {
    final activeList = appState.tokens.where((t) {
      if (!isTokenActive(t)) return false;
      if (currentUser != null && t.userId.isNotEmpty && t.userId != currentUser.id) {
        return false;
      }
      return true;
    }).toList();

    if (activeList.isNotEmpty) {
      activeList.sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
      return activeList.first;
    }
  }

  // 2. Fetch from repository (network + cache)
  try {
    final tokens = await ref
        .read(appointmentRepositoryProvider)
        .getTokens(userId: currentUser?.id);

    final userActiveTokens = tokens.where((t) {
      if (!isTokenActive(t)) return false;
      if (currentUser != null && t.userId.isNotEmpty && t.userId != currentUser.id) {
        return false;
      }
      return true;
    }).toList();

    if (userActiveTokens.isNotEmpty) {
      userActiveTokens.sort(
        (a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''),
      );
      return userActiveTokens.first;
    }
  } catch (e) {
    debugPrint('[Tracking] Error looking up active token from network: $e');
  }

  // 3. Fallback to local DB cache directly
  try {
    final cached = await ref.read(tokensLocalDataSourceProvider).getCachedTokens();
    if (cached.isNotEmpty) {
      final activeCached = cached.where((r) {
        final s = r.status.toLowerCase().trim();
        final isActive = s != 'completed' &&
            s != 'cancelled' &&
            s != 'canceled' &&
            s != 'done' &&
            s != 'rejected' &&
            s != 'missed' &&
            s != 'expired';
        if (!isActive) return false;
        if (currentUser != null && r.userId.isNotEmpty && r.userId != currentUser.id) {
          return false;
        }
        return true;
      }).toList();

      if (activeCached.isNotEmpty) {
        activeCached.sort((a, b) => (b.createdAt ?? '').compareTo(a.createdAt ?? ''));
        final r = activeCached.first;
        return Token(
          id: r.id,
          doctorId: r.doctorId,
          clinicId: r.clinicId,
          userId: r.userId,
          notes: r.notes,
          status: r.status,
          tokenNumber: r.tokenNumber,
          createdAt: r.createdAt,
          isFromCache: true,
        );
      }
    }
  } catch (e) {
    debugPrint('[Tracking] Local cache token lookup error: $e');
  }

  return null;
});

class TrackingScreen extends ConsumerWidget {
  final String? tokenId;

  const TrackingScreen({super.key, this.tokenId});

  void _handleNavigation(BuildContext context, int index, WidgetRef ref) {
    if (index == 0) {
      context.go(AppRoutes.clinics);
    } else if (index == 1) {
      context.go(AppRoutes.doctors);
    } else if (index == 2) {
      context.go(AppRoutes.home);
    } else if (index == 3) {
      // Already on Queue/Tracking tab
    } else if (index == 4) {
      context.go(AppRoutes.profile);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasSpecificToken =
        tokenId != null && tokenId != 'none' && tokenId != 'active';

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.appBackground,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Live Tracking',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.history_rounded,
              color: ClinicQColors.textPrimary,
            ),
            onPressed: () => context.push(AppRoutes.appointmentHistory),
            tooltip: 'Appointment History',
          ),
        ],
      ),
      body: hasSpecificToken
          ? _TrackingBody(tokenId: tokenId!)
          : _buildActiveLookupBody(context, ref),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: 3,
        onTap: (index) => _handleNavigation(context, index, ref),
      ),
    );
  }

  Widget _buildActiveLookupBody(BuildContext context, WidgetRef ref) {
    final activeTokenAsync = ref.watch(activeTokenLookupProvider);

    return activeTokenAsync.when(
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
            child: SingleChildScrollView(
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
                    onPressed: () => context.go(AppRoutes.home),
                  ),
                ],
              ),
            ),
          );
        }
        return _TrackingBody(tokenId: activeToken.id);
      },
    );
  }
}

class _TrackingBody extends ConsumerWidget {
  final String tokenId;

  const _TrackingBody({required this.tokenId});

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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              // Show non-dismissible loading overlay spinner
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext loadingContext) {
                  return const Center(child: ClinicQLoader());
                },
              );

              final trackingNotifier = ref.read(
                trackingViewModelProvider(tokenId).notifier,
              );
              final success = await trackingNotifier.cancelTrackingToken();

              // Dismiss loading overlay
              if (context.mounted) {
                Navigator.pop(context);
              }
              // Dismiss confirmation dialog
              Navigator.pop(ctx);

              if (success) {
                ref.invalidate(activeTokenLookupProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appointment cancelled successfully.'),
                    ),
                  );
                  context.go(AppRoutes.home);
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
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<TrackingState>(trackingViewModelProvider(tokenId), (
      previous,
      next,
    ) {
      if (next.snapshot?.status == 'completed') {
        context.go('/tracking/$tokenId/completed');
      }
    });

    final trackingState = ref.watch(trackingViewModelProvider(tokenId));
    final doctorAsync = ref.watch(trackingDoctorProvider(tokenId));
    final isOffline = trackingState.isFromCache || trackingState.isStale;

    return SafeArea(
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
              child: const Row(
                children: [
                  Icon(
                    Icons.pause_circle_filled,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
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
                      onRetry: () =>
                          ref.refresh(trackingViewModelProvider(tokenId)),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Premium Header Gradient Card
                        doctorAsync.when(
                          loading: () => const Center(child: ClinicQLoader()),
                          error: (err, stack) => TrackingHeaderCard(
                            snapshot: trackingState.snapshot!,
                          ),
                          data: (doctor) => TrackingHeaderCard(
                            snapshot: trackingState.snapshot!,
                            doctor: doctor,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 2. Stats Grid Row (Wait Time & Patients In Queue)
                        if (trackingState.snapshot != null) ...[
                          TrackingStatsGrid(snapshot: trackingState.snapshot!),
                          const SizedBox(height: 24),

                          // 3. Horizontal Visual Lineup of Queue
                          TrackingQueueLineup(
                            snapshot: trackingState.snapshot!,
                            doctor: doctorAsync.value,
                          ),
                          const SizedBox(height: 24),

                          // 4. Queue Status Vertical Timeline
                          TrackingQueueTimeline(
                            snapshot: trackingState.snapshot!,
                          ),
                          const SizedBox(height: 24),

                          // 5. Notification banner
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: ClinicQColors.infoBackground,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: ClinicQColors.infoBorder.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.notifications_active_rounded,
                                  color: ClinicQColors.infoIcon,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'We\'ll notify you when your turn is near.',
                                    style: TextStyle(
                                      color: ClinicQColors.infoText,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

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

                        // 6. Cancel Action
                        if (trackingState.snapshot?.status != 'cancelled')
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () => _showCancelDialog(context, ref),
                              child: const Text(
                                'Cancel Appointment',
                                style: TextStyle(
                                  color: ClinicQColors.errorIcon,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
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
    );
  }
}

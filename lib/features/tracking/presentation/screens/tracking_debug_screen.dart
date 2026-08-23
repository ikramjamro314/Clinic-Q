import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clinic_q/features/doctor/presentation/doctor_providers.dart';
import 'package:clinic_q/features/auth/presentation/auth_providers.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../providers.dart';

class TrackingDebugScreen extends ConsumerStatefulWidget {
  const TrackingDebugScreen({super.key});

  @override
  ConsumerState<TrackingDebugScreen> createState() => _TrackingDebugScreenState();
}

class _TrackingDebugScreenState extends ConsumerState<TrackingDebugScreen> {
  String? _testTokenId;

  @override
  void initState() {
    super.initState();
    // Trigger a default test check in background with a sample tokenId
    // to verify the initial state logging
    _testTokenId = 't9090909-0000-0000-0000-000000000001';
  }

  Future<void> _runE2ETestFlow() async {
    final appointmentNotifier = ref.read(appointmentViewModelProvider.notifier);
    final doctorRepo = ref.read(doctorRepositoryProvider);
    final authRepo = ref.read(authRepositoryProvider);

    debugPrint('=== FETCHING REAL DATA FOR BOOKING FLOW ===');
    
    // Fetch real doctor from repository
    final doctors = await doctorRepo.getInterestedDoctors();
    if (doctors.isEmpty) {
      debugPrint('[Tracking] Error: No real doctors found in database.');
      return;
    }
    final doctor = doctors.first;
    final doctorId = doctor.id;
    final clinicId = doctor.clinicId ?? 'c1010101-0000-0000-0000-000000000001';

    // Fetch real current user
    final currentUser = authRepo.getCurrentUser();
    if (currentUser == null) {
      debugPrint('[Tracking] Error: No authenticated user found.');
      return;
    }
    final userId = currentUser.id;
    final notes = 'Fever and mild chest congestion';

    debugPrint('=== STARTING E2E BOOKING FLOW TEST ===');
    final success = await appointmentNotifier.createToken(
      doctorId: doctorId,
      clinicId: clinicId,
      userId: userId,
      notes: notes,
    );

    if (success) {
      final state = ref.read(appointmentViewModelProvider);
      if (state.tokens.isNotEmpty) {
        final newToken = state.tokens.first;
        debugPrint('=== BOOKED NEW TOKEN: ${newToken.id} ===');
        
        setState(() {
          _testTokenId = newToken.id;
        });

        // 2. Fetch list of tokens to test GET list
        await appointmentNotifier.fetchTokens(userId: userId);
      }
    } else {
      debugPrint('=== BOOKING FLOW TEST FAILED ===');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the live tracking viewmodel for the active tokenId
    final trackingState = _testTokenId != null
        ? ref.watch(trackingViewModelProvider(_testTokenId!))
        : null;

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        title: const Text('Live Tracking Console Debug'),
        backgroundColor: ClinicQColors.primaryTeal,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tracking — check console for live output',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ClinicQColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Every API call, Drift database query, caching operation, and lifecycle event is logged in your terminal/debug console.',
                style: TextStyle(
                  fontSize: 14,
                  color: ClinicQColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ClinicQColors.primaryTeal,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _runE2ETestFlow,
                icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                label: const Text(
                  'Trigger E2E Book & Track Flow',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              if (_testTokenId != null) ...[
                const SizedBox(height: 24),
                Text(
                  'Active Tracking Token ID:\n$_testTokenId',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: ClinicQColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (trackingState != null && trackingState.snapshot != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Current Token: ${trackingState.snapshot!.currentTokenNumber} | Your Token: ${trackingState.snapshot!.yourTokenNumber}\n'
                    'Patients Ahead: ${trackingState.snapshot!.patientsAheadCount} | ETA: ${trackingState.snapshot!.estimatedWaitMinutes} mins\n'
                    'Status: ${trackingState.snapshot!.status}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ClinicQColors.primaryTeal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (_testTokenId != null) {
                      final trackingNotifier = ref.read(trackingViewModelProvider(_testTokenId!).notifier);
                      await trackingNotifier.cancelTrackingToken();
                    }
                  },
                  icon: const Icon(Icons.cancel_rounded, color: Colors.white),
                  label: const Text(
                    'Cancel Active Token',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

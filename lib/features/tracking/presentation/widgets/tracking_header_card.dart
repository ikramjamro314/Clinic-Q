import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';
import '../../domain/entities/tracking_snapshot.dart';

class TrackingHeaderCard extends StatelessWidget {
  final TrackingSnapshot snapshot;
  final DoctorEntity? doctor;

  const TrackingHeaderCard({super.key, required this.snapshot, this.doctor});

  @override
  Widget build(BuildContext context) {
    final progressVal =
        (snapshot.currentTokenNumber > 0 && snapshot.yourTokenNumber > 0)
        ? (snapshot.currentTokenNumber / snapshot.yourTokenNumber).clamp(
            0.0,
            1.0,
          )
        : 0.0;

    final isPaused = snapshot.status == 'paused';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: ClinicQColors.gradientPrimary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ClinicQColors.primaryTeal.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Core Card Contents
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                children: [
                  // Top live badge & info icon
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'LIVE TRACKING',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.white.withOpacity(0.8),
                          size: 22,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Token Number display
                  const Text(
                    'YOUR TOKEN NUMBER',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '#${snapshot.yourTokenNumber.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Doctor & Clinic display
                  Text(
                    doctor?.name ?? 'Loading Doctor...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor?.clinicName ?? 'ClinicQ Partner Center',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Glassmorphic Progress Section
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'QUEUE PROGRESS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              '${snapshot.currentTokenNumber}/${snapshot.yourTokenNumber}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progressVal,
                            minHeight: 6,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            snapshot.currentTokenNumber ==
                                    snapshot.yourTokenNumber
                                ? 'It\'s your turn now! Please go inside.'
                                : (snapshot.patientsAheadCount <= 1
                                      ? 'Almost your turn! Be ready.'
                                      : 'Waiting in queue...'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Paused Overlay (Glassmorphism + Blur)
            if (isPaused)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.pause_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'QUEUE PAUSED',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Please wait for the doctor to resume.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

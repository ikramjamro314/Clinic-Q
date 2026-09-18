import 'package:clinic_q/app/app_routes.dart';
import 'package:clinic_q/features/tracking/presentation/screens/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../viewmodels/tracking_view_model.dart';
import '../providers.dart';

class TrackingCompletedScreen extends ConsumerStatefulWidget {
  final String tokenId;

  const TrackingCompletedScreen({super.key, required this.tokenId});

  @override
  ConsumerState<TrackingCompletedScreen> createState() =>
      _TrackingCompletedScreenState();
}

class _TrackingCompletedScreenState
    extends ConsumerState<TrackingCompletedScreen> {
  late final TextEditingController _feedbackController;

  @override
  void initState() {
    super.initState();
    final initialText = ref
        .read(trackingViewModelProvider(widget.tokenId))
        .feedbackText;
    _feedbackController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackingState = ref.watch(trackingViewModelProvider(widget.tokenId));
    final trackingNotifier = ref.read(
      trackingViewModelProvider(widget.tokenId).notifier,
    );

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Curved Wave with Star Badge Illustration
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipPath(
                    clipper: _TopWaveClipper(),
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ClinicQColors.primaryTeal,
                            ClinicQColors.primaryBlue,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700), // Gold
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 76,
                        height: 76,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFC107), // Secondary Gold
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Main Content Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Text(
                      'Thank you for using the online health consultation service',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ClinicQColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'The results of the consultation will be sent to you later. Please check your health records.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ClinicQColors.textSecondary,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Review Section Label
                    const Text(
                      'Review the consultation',
                      style: TextStyle(
                        color: ClinicQColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Star rating row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starRating = index + 1;
                        final isSelected =
                            starRating <= trackingState.feedbackRating;
                        return GestureDetector(
                          onTap: () {
                            trackingNotifier.updateFeedbackRating(starRating);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6.0,
                            ),
                            child: Icon(
                              Icons.star_rounded,
                              color: isSelected
                                  ? const Color(0xFFFFC107)
                                  : ClinicQColors.textTertiary.withOpacity(0.3),
                              size: 36,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 32),

                    // Feedback field Card
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: ClinicQColors.cardBackground,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: ClinicQColors.cardBorder,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ClinicQColors.textPrimary.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _feedbackController,
                        maxLines: 4,
                        onChanged: (val) {
                          trackingNotifier.updateFeedbackText(val);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Your feedback',
                          hintStyle: TextStyle(
                            color: ClinicQColors.textTertiary,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: ClinicQColors.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Done Button
                    SizedBox(
                      width: double.infinity,
                      child: ClinicQButton(
                        label: 'Done',
                        isLoading: trackingState.isFeedbackSubmitting,
                        onPressed: () async {
                          // Submit feedback and return home
                          final success = await trackingNotifier
                              .submitFeedback();
                          if (success && mounted) {
                            ref.invalidate(activeTokenLookupProvider);
                            context.go(AppRoutes.home);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);

    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 3 / 4, size.height - 60);
    final secondEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

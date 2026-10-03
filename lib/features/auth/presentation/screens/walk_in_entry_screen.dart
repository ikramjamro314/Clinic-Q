import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/inputs/clinicq_text_field.dart';
import '../../../../core/widgets/layout/clinicq_gradient_background.dart';

class WalkInEntryScreen extends StatefulWidget {
  const WalkInEntryScreen({super.key});

  @override
  State<WalkInEntryScreen> createState() => _WalkInEntryScreenState();
}

class _WalkInEntryScreenState extends State<WalkInEntryScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _tokenIdController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _errorMessage;

  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _tokenIdController.dispose();
    _focusNode.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _handleTrackQueue() {
    final tokenId = _tokenIdController.text.trim();
    if (tokenId.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your Walk-in Token ID';
      });
      HapticFeedback.lightImpact();
      return;
    }

    setState(() {
      _errorMessage = null;
    });

    HapticFeedback.mediumImpact();
    // Navigate to live tracking screen with the provided token ID
    context.push('/tracking/$tokenId');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? ClinicQColors.darkBackground
          : const Color(0xFFF3F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Back Button & Top Navigation Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(AppRoutes.roleSelection);
                          }
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: isDark
                                ? Colors.white
                                : ClinicQColors.textPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: ClinicQColors.primaryTeal.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.airline_seat_recline_normal_rounded,
                              size: 14,
                              color: ClinicQColors.primaryTeal,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Walk-in Mode',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ClinicQColors.primaryTeal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Header Badge Icon & Welcome Info
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: ClinicQColors.gradientPrimary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ClinicQColors.primaryTeal.withValues(
                              alpha: 0.35,
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.confirmation_number_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Header Title & Subtitle
                  Text(
                    'Track Walk-in Token',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : ClinicQColors.textPrimary,
                      letterSpacing: -0.5,
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Enter the Token ID or Number given to you at the clinic reception to monitor your live turn.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? ClinicQColors.textTertiary
                            : ClinicQColors.textSecondary,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Main Interactive Card
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? ClinicQColors.darkSurface : Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 24,
                          spreadRadius: 2,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Field Label
                        Text(
                          'Walk-in Token ID',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? Colors.white
                                : ClinicQColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Token Input Field
                        ClinicQTextField(
                          controller: _tokenIdController,
                          focusNode: _focusNode,
                          hintText: 'e.g. W-104 or CLQ-7821',
                          prefixIcon: Icons.tag_rounded,
                          keyboardType: TextInputType.text,
                          onSubmitted: (_) => _handleTrackQueue(),
                          onChanged: (val) {
                            if (_errorMessage != null) {
                              setState(() => _errorMessage = null);
                            }
                          },
                          suffixIcon: _tokenIdController.text.isNotEmpty
                              ? Icons.clear_rounded
                              : null,
                          onSuffixIconPressed: () {
                            _tokenIdController.clear();
                            setState(() => _errorMessage = null);
                          },
                        ),

                        // Error Message if present
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.error_outline_rounded,
                                size: 14,
                                color: ClinicQColors.errorIcon,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  color: ClinicQColors.errorText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 20),

                        // Helper Tip Box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: ClinicQColors.primaryBlue.withValues(
                              alpha: 0.06,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: ClinicQColors.primaryBlue.withValues(
                                alpha: 0.15,
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info_outline_rounded,
                                color: ClinicQColors.primaryBlue,
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Your token ID is printed on your physical token slip or sent via SMS upon walk-in registration.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.4,
                                    color: isDark
                                        ? ClinicQColors.textSecondary
                                        : ClinicQColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Track Queue CTA Button
                        ClinicQButton(
                          label: 'Track My Queue',
                          icon: Icons.radar_rounded,
                          gradient: ClinicQColors.gradientPrimary,
                          height: 54,
                          onPressed: _handleTrackQueue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Alternative Action: Have an account?
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.go(AppRoutes.login);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: 'Have a registered account? ',
                          style: TextStyle(
                            color: isDark
                                ? ClinicQColors.textTertiary
                                : ClinicQColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          children: const [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: ClinicQColors.primaryTeal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

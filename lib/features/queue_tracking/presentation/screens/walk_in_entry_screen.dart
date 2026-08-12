import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/layout/clinicq_card.dart';
import '../../../../core/widgets/inputs/clinicq_text_field.dart';
import '../widgets/walk_in_logo_illustration.dart';

class WalkInIdEntryScreen extends StatefulWidget {
  const WalkInIdEntryScreen({super.key});

  @override
  State<WalkInIdEntryScreen> createState() => _WalkInIdEntryScreenState();
}

class _WalkInIdEntryScreenState extends State<WalkInIdEntryScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _idController;
  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    ));

    _entranceController.forward();
  }

  @override
  void dispose() {
    _idController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _applySuggestion(String id) {
    setState(() {
      _idController.text = id;
    });
  }

  void _handleTrackQueue() {
    final code = _idController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid Walk-in ID')),
      );
      return;
    }

    // Since there's no actual API integration for walk-ins in the skeleton,
    // we show a mock confirmation and route them to Home.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tracking queue for Walk-in ID: $code'),
        backgroundColor: ClinicQColors.tokenActive,
      ),
    );
    context.go(AppRoutes.home);
  }

  void _navigateToRoleSelection() {
    context.go(AppRoutes.roleSelection);
  }

  void _navigateToLogin() {
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ClinicQColors.darkBackground : ClinicQColors.appBackground,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 32,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top back button
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: _navigateToRoleSelection,
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isDark ? ClinicQColors.darkSurface : Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color: isDark ? Colors.white : ClinicQColors.textPrimary,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // Logo illustration (Green rounded square + clinic outline)
                          WalkInLogoIllustration(isDark: isDark),
                          const SizedBox(height: 36),
                          
                          // Title & Subtitle
                          Text(
                            'Enter your Walk-in ID',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: isDark ? Colors.white : ClinicQColors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Your Walk-in ID was provided at the clinic reception',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isDark ? ClinicQColors.textTertiary : ClinicQColors.textSecondary,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 36),
                          
                          // Custom TextField Card for input using AppCard
                          ClinicQCard(
                            padding: const EdgeInsets.all(24),
                            borderRadius: 24,
                            backgroundColor: isDark ? ClinicQColors.darkSurface : ClinicQColors.cardBackground,
                            border: Border.all(
                              color: isDark
                                  ? ClinicQColors.darkSurfaceVariant
                                  : ClinicQColors.inputBorderDefault,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClinicQTextField(
                                  label: 'WALK-IN ID',
                                  hintText: 'e.g. WI-1042',
                                  controller: _idController,
                                  keyboardType: TextInputType.text,
                                ),
                                const SizedBox(height: 16),
                                // Suggester
                                Row(
                                  children: [
                                    Text(
                                      'Try: ',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: ClinicQColors.textTertiary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _applySuggestion('WI-1042'),
                                      child: Text(
                                        'WI-1042',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: isDark ? ClinicQColors.lightTeal : ClinicQColors.primaryTeal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' or ',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: ClinicQColors.textTertiary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _applySuggestion('WI-2088'),
                                      child: Text(
                                        'WI-2088',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: isDark ? ClinicQColors.lightTeal : ClinicQColors.primaryTeal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // Bottom CTA and alternative login link
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClinicQButton(
                                  label: 'Track My Queue',
                                  onPressed: _handleTrackQueue,
                                  height: 56,
                                  backgroundColor: ClinicQColors.primaryTeal,
                                  textColor: Colors.white,
                                ),
                                const SizedBox(height: 24),
                                GestureDetector(
                                  onTap: _navigateToLogin,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: ClinicQColors.textTertiary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Not a walk-in? '),
                                        TextSpan(
                                          text: 'Sign in here',
                                          style: TextStyle(
                                            color: isDark ? ClinicQColors.lightTeal : ClinicQColors.primaryTeal,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

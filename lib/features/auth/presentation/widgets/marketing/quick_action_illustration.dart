import 'package:flutter/material.dart';
import '../../../../../core/theme/clinic_q_colors.dart';

class QuickActionIllustration extends StatefulWidget {
  const QuickActionIllustration({super.key});

  @override
  State<QuickActionIllustration> createState() =>
      _QuickActionIllustrationState();
}

class _QuickActionIllustrationState extends State<QuickActionIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _queueNumber = 15;
  bool _booked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerBookAction() {
    if (_booked) {
      setState(() {
        _queueNumber = 15;
        _booked = false;
      });
      return;
    }

    setState(() {
      _booked = true;
    });

    _controller.reset();
    _controller.forward();

    // Rapid countdown animation
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 40));
      if (!mounted || !_booked) return false;
      if (_queueNumber > 1) {
        setState(() {
          _queueNumber--;
        });
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: _triggerBookAction,
      child: Container(
        width: 240,
        height: 240,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(
            isDark ? 0.08 : 0.25,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Mobile Mockup
              Container(
                width: 120,
                height: 200,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: theme.colorScheme.outline,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    // Speaker bar
                    Container(
                      width: 30,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outline,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Ticket card inside phone
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outline.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Queue',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '#$_queueNumber',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: _booked
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Book Action Button in phone mockup
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: double.infinity,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _booked
                            ? ClinicQColors.tokenActive
                            : theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _booked ? 'Booked' : 'Book Visit',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Floating star/check icon
              if (_booked)
                Positioned(
                  top: 24,
                  right: 24,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ClinicQColors.tokenActive,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

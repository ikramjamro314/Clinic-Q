import 'package:flutter/material.dart';

class AppointmentBookingIllustration extends StatefulWidget {
  const AppointmentBookingIllustration({super.key});

  @override
  State<AppointmentBookingIllustration> createState() =>
      _AppointmentBookingIllustrationState();
}

class _AppointmentBookingIllustrationState
    extends State<AppointmentBookingIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _badgeScale;
  late Animation<Offset> _badgeOffset;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _badgeScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.9, curve: Curves.elasticOut),
      ),
    );

    _badgeOffset = Tween<Offset>(
      begin: const Offset(0, -50),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward().then((_) {
      if (mounted) {
        setState(() {
          _isChecked = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerTapInteraction() {
    _controller.reset();
    setState(() {
      _isChecked = false;
    });
    _controller.forward().then((_) {
      if (mounted) {
        setState(() {
          _isChecked = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: _triggerTapInteraction,
      child: Container(
        width: 240,
        height: 240,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(isDark ? 0.1 : 0.3),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Calendar Back Card
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(color: theme.colorScheme.outline),
                ),
                child: Column(
                  children: [
                    // Header Bar
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(19),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'CALENDAR',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    // Grid lines placeholders
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            if (index == 6) {
                              // Slot we are booking
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  color: _isChecked
                                      ? theme.colorScheme.primary.withOpacity(0.15)
                                      : theme.colorScheme.outline.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: _isChecked
                                        ? theme.colorScheme.primary
                                        : Colors.transparent,
                                  ),
                                ),
                                child: _isChecked
                                    ? Icon(
                                        Icons.check,
                                        size: 14,
                                        color: theme.colorScheme.primary,
                                      )
                                    : null,
                              );
                            }
                            return Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.outline.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Doctor Badge flying in
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: _badgeOffset.value,
                    child: Transform.scale(
                      scale: _badgeScale.value,
                      child: child,
                    ),
                  );
                },
                child: Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.shadow.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: theme.colorScheme.secondary,
                          child: const Icon(
                            Icons.person,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Dr. Smith',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
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

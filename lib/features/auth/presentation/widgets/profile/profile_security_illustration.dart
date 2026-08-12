import 'package:flutter/material.dart';

class ProfileSecurityIllustration extends StatefulWidget {
  const ProfileSecurityIllustration({super.key});

  @override
  State<ProfileSecurityIllustration> createState() =>
      _ProfileSecurityIllustrationState();
}

class _ProfileSecurityIllustrationState extends State<ProfileSecurityIllustration>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shieldScale;
  late Animation<double> _lockRotation;
  bool _isLocked = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _shieldScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _lockRotation = Tween<double>(begin: 0.1, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLock() {
    setState(() {
      _isLocked = !_isLocked;
    });
    if (_isLocked) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: _toggleLock,
      child: Container(
        width: 240,
        height: 240,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer.withOpacity(isDark ? 0.1 : 0.3),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Medical Folder Card
              Container(
                width: 140,
                height: 160,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withOpacity(0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(color: theme.colorScheme.outline),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // File Tab Graphic
                    Container(
                      width: 40,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outline,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Line placeholders
                    Container(
                      width: 100,
                      height: 10,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outline.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 70,
                      height: 10,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outline.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 90,
                      height: 10,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outline.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),

              // Shield Lock
              ScaleTransition(
                scale: _shieldScale,
                child: RotationTransition(
                  turns: _lockRotation,
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.shadow.withOpacity(0.12),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      border: Border.all(
                        color: _isLocked ? theme.colorScheme.primary : theme.colorScheme.outline,
                        width: 2.0,
                      ),
                    ),
                    child: Icon(
                      _isLocked ? Icons.lock : Icons.lock_open,
                      color: _isLocked ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                      size: 36,
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

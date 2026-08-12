import 'package:flutter/material.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
  });

  final String title;
  final String description;
  final Widget illustration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Graphic Area
          Expanded(
            flex: 5,
            child: Center(child: illustration),
          ),
          const SizedBox(height: 24),
          // Text Area
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

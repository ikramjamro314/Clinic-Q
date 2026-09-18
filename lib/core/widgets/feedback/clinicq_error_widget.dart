import 'package:flutter/material.dart';
import '../../../app/theme/clinic_q_colors.dart';

class ClinicQErrorWidget extends StatelessWidget {
  const ClinicQErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 12.0,
  });

  final String message;
  final VoidCallback? onRetry;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Dark mode fallback vs Light mode design tokens
    final bg = isDark
        ? Colors.red.withOpacity(0.15)
        : ClinicQColors.errorBackground;
    final border = isDark
        ? Colors.red.withOpacity(0.3)
        : ClinicQColors.errorBorder;
    final text = isDark ? Colors.red.shade200 : ClinicQColors.errorText;
    final icon = isDark ? Colors.red.shade300 : ClinicQColors.errorIcon;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded, color: icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: onRetry,
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Text(
                        'Retry',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: text,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

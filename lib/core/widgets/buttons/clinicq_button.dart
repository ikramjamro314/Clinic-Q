import 'package:flutter/material.dart';
import '../../theme/clinic_q_colors.dart';

class ClinicQButton extends StatelessWidget {
  const ClinicQButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isExpanded = true,
    this.height = 48,
    this.borderRadius = 12,
    this.backgroundColor,
    this.textColor,
    this.gradient,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isExpanded;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final Gradient? gradient;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDisabled = onPressed == null || isLoading;

    Color bg;
    Color fg;
    Gradient? finalGradient;

    if (isDisabled) {
      bg = isDark
          ? theme.colorScheme.surfaceContainerHighest
          : ClinicQColors.buttonDisabledBackground;
      fg = isDark
          ? theme.colorScheme.onSurfaceVariant
          : ClinicQColors.buttonDisabledText;
      finalGradient = null;
    } else {
      // Defaults to the premium brand gradient unless explicit single backgroundColor is supplied
      if (backgroundColor != null) {
        bg = backgroundColor!;
        finalGradient = null;
      } else {
        bg = Colors.transparent;
        finalGradient = gradient ?? ClinicQColors.gradientPrimary;
      }
      fg = textColor ?? (isDark ? ClinicQColors.textPrimary : Colors.white);
    }

    final buttonChild = Container(
      height: height,
      decoration: BoxDecoration(
        color: finalGradient == null ? bg : null,
        gradient: finalGradient,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      alignment: Alignment.center,
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: fg,
                strokeWidth: 2.5,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: fg, size: 18),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: isExpanded
            ? SizedBox(width: double.infinity, child: buttonChild)
            : buttonChild,
      ),
    );
  }
}

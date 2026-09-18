import 'package:flutter/material.dart';
import '../../../app/theme/clinic_q_colors.dart';

class ClinicQOutlinedButton extends StatelessWidget {
  const ClinicQOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isExpanded = true,
    this.height = 48,
    this.borderColor,
    this.textColor,
    this.borderRadius = 12,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isExpanded;
  final double height;
  final Color? borderColor;
  final Color? textColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onPressed == null || isLoading;

    Color bg;
    Color fg;
    Color border;

    if (isDisabled) {
      bg = theme.brightness == Brightness.dark
          ? theme.colorScheme.surfaceContainerHighest
          : ClinicQColors.buttonDisabledBackground;
      fg = theme.brightness == Brightness.dark
          ? theme.colorScheme.onSurfaceVariant
          : ClinicQColors.buttonDisabledText;
      border = Colors.transparent;
    } else {
      bg = Colors.transparent;
      fg = textColor ?? ClinicQColors.secondaryButtonText;
      border = borderColor ?? ClinicQColors.secondaryButtonBorder;
    }

    final buttonChild = Container(
      height: height,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: border, width: 1.5),
      ),
      alignment: Alignment.center,
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: fg, strokeWidth: 2.5),
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

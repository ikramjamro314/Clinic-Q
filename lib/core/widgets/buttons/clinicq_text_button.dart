import 'package:flutter/material.dart';
import '../../theme/clinic_q_colors.dart';

class ClinicQTextButton extends StatelessWidget {
  const ClinicQTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textColor,
    this.fontSize,
    this.fontWeight = FontWeight.w700,
    this.icon,
    this.padding,
    this.backgroundColor,
    this.shape,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? textColor;
  final double? fontSize;
  final FontWeight fontWeight;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeTextColor = textColor ?? ClinicQColors.primaryBlue;

    final textStyle = theme.textTheme.labelLarge?.copyWith(
      color: activeTextColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );

    final buttonChild = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: textStyle),
              const SizedBox(width: 6),
              icon!,
            ],
          )
        : Text(label, style: textStyle);

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: activeTextColor,
        backgroundColor: backgroundColor,
        padding: padding,
        shape: shape,
      ),
      child: buttonChild,
    );
  }
}

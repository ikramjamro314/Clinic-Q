import 'package:flutter/material.dart';

class ClinicQBadge extends StatelessWidget {
  const ClinicQBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    this.icon,
    this.padding,
    this.borderRadius = 999,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foregroundColor),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

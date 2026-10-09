import 'package:flutter/material.dart';

class QueueStatusBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;

  const QueueStatusBadge({
    super.key,
    this.text = 'Queue running',
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor ?? const Color(0xFFA7F3D0),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? const Color(0xFF059669),
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

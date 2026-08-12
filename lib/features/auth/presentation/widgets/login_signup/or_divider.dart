import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFE2E8F0),
            thickness: 1.5,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'OR',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFE2E8F0),
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}

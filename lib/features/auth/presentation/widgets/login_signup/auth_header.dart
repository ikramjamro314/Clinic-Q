import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Premium Medical Briefcase Logo Card
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFFDBEAFE), // Light blue background
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.medical_services_rounded,
            color: Color(0xFF2563EB), // Dark blue briefcase color
            size: 32,
          ),
        ),
        const SizedBox(height: 6),
        // ClinicQ Brand Text
        const Text(
          'ClinicQ',
          style: TextStyle(
            color: Color(0xFF0F172A), // Premium dark text color
            fontWeight: FontWeight.w900,
            fontSize: 32,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        // Subtitle
        const Text(
          'Empowering your healthcare journey',
          style: TextStyle(
            color: Color(0xFF64748B), // Subtle grey subtitle
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

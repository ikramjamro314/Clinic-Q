import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';

class BookingTicketCard extends StatelessWidget {
  final int tokenNumber;
  final String dateText;
  final DoctorEntity doctor;

  const BookingTicketCard({
    super.key,
    required this.tokenNumber,
    required this.dateText,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final tokenStr = tokenNumber > 0
        ? tokenNumber.toString().padLeft(2, '0')
        : '--';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ClinicQColors.cardBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
            child: Column(
              children: [
                // Top section: TOKEN, Big Number, Date
                const Text(
                  'TOKEN',
                  style: TextStyle(
                    color: ClinicQColors.textTertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tokenStr,
                  style: const TextStyle(
                    color: Color(0xFF0F6258),
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  dateText,
                  style: const TextStyle(
                    color: ClinicQColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),

                // Dashed separator line
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: List.generate(
                      24,
                      (index) => Expanded(
                        child: Container(
                          height: 1.5,
                          color: index.isEven
                              ? ClinicQColors.dividerMedium
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Bottom section: Doctor, Clinic & specialty
                Text(
                  doctor.name,
                  style: const TextStyle(
                    color: ClinicQColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${doctor.clinicName} · ${doctor.specialty}',
                  style: const TextStyle(
                    color: ClinicQColors.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Left notch
          Positioned(
            left: -12,
            top: 172,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: ClinicQColors.appBackground,
                shape: BoxShape.circle,
                border: Border.all(color: ClinicQColors.cardBorder, width: 1.2),
              ),
            ),
          ),

          // Right notch
          Positioned(
            right: -12,
            top: 172,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: ClinicQColors.appBackground,
                shape: BoxShape.circle,
                border: Border.all(color: ClinicQColors.cardBorder, width: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

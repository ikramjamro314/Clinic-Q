import 'package:flutter/material.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';

class SelectableDoctorRow extends StatelessWidget {
  final DoctorEntity doctor;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableDoctorRow({
    super.key,
    required this.doctor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ClinicQColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? ClinicQColors.primaryTeal
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: ClinicQColors.cardShadow,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: ClinicQColors.gradientPrimary,
                shape: BoxShape.circle,
                image: doctor.photoUrl != null && doctor.photoUrl!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(doctor.photoUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              alignment: Alignment.center,
              child: doctor.photoUrl == null || doctor.photoUrl!.isEmpty
                  ? Text(
                      _getInitials(doctor.name),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ClinicQColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialty,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ClinicQColors.textLink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: ClinicQColors.starFilled,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        doctor.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ClinicQColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${doctor.reviewCount})',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ClinicQColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '?';
    final parts = name.split(' ');
    String initials = '';
    for (var part in parts) {
      if (part.isNotEmpty && part.toLowerCase() != 'dr.' && part.toLowerCase() != 'dr') {
        initials += part[0].toUpperCase();
        if (initials.length >= 2) break;
      }
    }
    if (initials.isEmpty && name.isNotEmpty) return name[0].toUpperCase();
    return initials;
  }
}

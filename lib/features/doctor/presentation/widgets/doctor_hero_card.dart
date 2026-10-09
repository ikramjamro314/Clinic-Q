import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../domain/entities/doctor_entity.dart';

class DoctorHeroCard extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorHeroCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final initials = doctor.name.isNotEmpty
        ? doctor.name
            .replaceFirst('Dr. ', '')
            .split(' ')
            .where((e) => e.isNotEmpty)
            .map((e) => e[0])
            .take(2)
            .join()
            .toUpperCase()
        : 'DR';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ClinicQColors.cardBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: doctor.photoUrl != null && doctor.photoUrl!.isNotEmpty
                ? Image.network(
                    doctor.photoUrl!,
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildInitialsAvatar(initials),
                  )
                : _buildInitialsAvatar(initials),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(
                    color: ClinicQColors.textPrimary,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: ClinicQColors.appointmentBadgeBackground,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    doctor.specialty,
                    style: const TextStyle(
                      color: ClinicQColors.primaryTeal,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (doctor.qualification != null &&
                    doctor.qualification!.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    doctor.qualification!,
                    style: const TextStyle(
                      color: ClinicQColors.textSecondary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFF59E0B),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      doctor.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: ClinicQColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '(${doctor.reviewCount}+ reviews)',
                      style: const TextStyle(
                        color: ClinicQColors.textTertiary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialsAvatar(String initials) {
    return Container(
      width: 84,
      height: 84,
      decoration: const BoxDecoration(
        color: Color(0xFFCCFBF1),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          color: Color(0xFF0F6258),
          fontSize: 26,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

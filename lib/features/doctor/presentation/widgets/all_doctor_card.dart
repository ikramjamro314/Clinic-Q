import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../domain/entities/doctor_entity.dart';

class AllDoctorCard extends StatelessWidget {
  const AllDoctorCard({super.key, required this.doctor, this.onTap});

  final DoctorEntity doctor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: ClinicQColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: ClinicQColors.cardShadow,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: ClinicQColors.secondaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: const Icon(
                  Icons.person,
                  color: ClinicQColors.primaryTeal,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ClinicQColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Specialty Tag
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ClinicQColors.availableBadgeBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      doctor.specialty,
                      style: const TextStyle(
                        color: ClinicQColors.availableBadgeText,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Clinic Name
                  if (doctor.clinicName.isNotEmpty) ...[
                    Text(
                      doctor.clinicName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: ClinicQColors.textLink,
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],

                  // Bottom Row: Rating, Price, Duration
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Rating
                      const Icon(
                        Icons.star_rounded,
                        color: ClinicQColors.starFilled,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        doctor.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ClinicQColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '(${doctor.reviewCount})',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ClinicQColors.textSecondary,
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Price
                      const Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ClinicQColors.primaryTeal,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'Rs ${doctor.price.toInt()}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ClinicQColors.textPrimary,
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Duration
                      const Icon(
                        Icons.access_time_rounded,
                        color: ClinicQColors.textSecondary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '~${doctor.durationMinutes} min',
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
}

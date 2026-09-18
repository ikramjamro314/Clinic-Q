import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../domain/entities/clinic_entity.dart';

class ClinicListCard extends StatelessWidget {
  const ClinicListCard({super.key, required this.clinic, this.onTap});

  final ClinicEntity clinic;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Image Area
            Stack(
              children: [
                Container(
                  height: 140,
                  decoration: const BoxDecoration(
                    color: ClinicQColors.secondaryBackground,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.apartment_rounded,
                      color: ClinicQColors.iconDisabled,
                      size: 48,
                    ),
                  ),
                ),
                // Specialty Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ClinicQColors.specialtyTagBackground.withOpacity(
                        0.9,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      clinic.specialtyTag,
                      style: const TextStyle(
                        color: ClinicQColors.specialtyTagText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Details Area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Clinic Name
                  Text(
                    clinic.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: ClinicQColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating Row
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: ClinicQColors.starFilled,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        clinic.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: ClinicQColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${clinic.reviewCount})',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ClinicQColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Hours
                      const Icon(
                        Icons.access_time_rounded,
                        color: ClinicQColors.textSecondary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          clinic.openingHours,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: ClinicQColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: ClinicQColors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          clinic.address,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: ClinicQColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  const Divider(height: 1, color: ClinicQColors.dividerLight),
                  const SizedBox(height: 12),

                  // Bottom Row: Status and Action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left: Doctors Available / Open Now
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${clinic.doctorCount} doctors available',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: ClinicQColors.textPrimary,
                            ),
                          ),
                          if (clinic.isOpen) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: ClinicQColors.successIcon,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'Open Now',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: ClinicQColors.successText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),

                      // Right: View Clinic Button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: ClinicQColors.primaryTeal.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: ClinicQColors.primaryTeal.withOpacity(0.2),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View Clinic',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ClinicQColors.primaryTeal,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 16,
                              color: ClinicQColors.primaryTeal,
                            ),
                          ],
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

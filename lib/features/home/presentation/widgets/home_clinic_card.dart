import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../viewmodels/home_state.dart';

class HomeClinicCard extends StatelessWidget {
  const HomeClinicCard({super.key, required this.clinic, this.onTap});

  final ClinicItem clinic;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ClinicQColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ClinicQColors.cardBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail / Image Placeholder
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: ClinicQColors.quickActionBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: clinic.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        clinic.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: ClinicQColors.quickActionBackground,
                          child: const Icon(
                            Icons.local_hospital_rounded,
                            color: ClinicQColors.quickActionIcon,
                            size: 32,
                          ),
                        ),
                      ),
                    )
                  : const Icon(
                      Icons.local_hospital_rounded,
                      color: ClinicQColors.quickActionIcon,
                      size: 32,
                    ),
            ),

            const SizedBox(width: 12),

            // Name, Location, and Rating Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    clinic.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ClinicQColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 13,
                        color: ClinicQColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          clinic.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: ClinicQColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: ClinicQColors.starFilled,
                        size: 13,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        clinic.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: ClinicQColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Small circular message/chat icon button
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: ClinicQColors.primaryTeal,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

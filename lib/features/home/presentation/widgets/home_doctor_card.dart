import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../viewmodels/home_state.dart';

class HomeDoctorCard extends StatelessWidget {
  const HomeDoctorCard({super.key, required this.doctor, this.onTap});

  final DoctorItem doctor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: ClinicQColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ClinicQColors.cardBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo section with overlapping chat button
              Stack(
                clipBehavior: Clip.none,
                children: [
                  doctor.avatarUrl != null
                      ? Image.network(
                          doctor.avatarUrl!,
                          width: double.infinity,
                          height: 85,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: double.infinity,
                                height: 85,
                                color: ClinicQColors.quickActionBackground,
                                child: const Icon(
                                  Icons.person,
                                  color: ClinicQColors.primaryTeal,
                                  size: 36,
                                ),
                              ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 85,
                          color: ClinicQColors.quickActionBackground,
                          child: const Icon(
                            Icons.person,
                            color: ClinicQColors.primaryTeal,
                            size: 36,
                          ),
                        ),
                  Positioned(
                    right: 8,
                    bottom: -12,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: ClinicQColors.primaryTeal,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Details section below image
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Doctor Name
                      Text(
                        doctor.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: ClinicQColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 2),

                      // Specialty
                      Text(
                        doctor.specialty,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: ClinicQColors.textSecondary,
                        ),
                      ),

                      const Spacer(),

                      // Rating Row below specialty
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: ClinicQColors.starFilled,
                            size: 13,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            doctor.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: ClinicQColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

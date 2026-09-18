import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../domain/entities/doctor_entity.dart';

class DoctorProfileHeader extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorProfileHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: doctor.photoUrl != null
              ? Image.network(
                  doctor.photoUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 100,
                    color: ClinicQColors.dividerLight,
                    child: const Icon(
                      Icons.person,
                      color: ClinicQColors.iconSecondary,
                      size: 40,
                    ),
                  ),
                )
              : Container(
                  width: 100,
                  height: 100,
                  color: ClinicQColors.dividerLight,
                  child: const Icon(
                    Icons.person,
                    color: ClinicQColors.iconSecondary,
                    size: 40,
                  ),
                ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ClinicQColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                doctor.specialty,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: ClinicQColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: ClinicQColors.starFilled,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.star,
                    color: ClinicQColors.starFilled,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.star,
                    color: ClinicQColors.starFilled,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.star,
                    color: ClinicQColors.starFilled,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.star_half,
                    color: ClinicQColors.starFilled,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    doctor.rating.toString(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: ClinicQColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (doctor.location != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: ClinicQColors.primaryBlue,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        doctor.location!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: ClinicQColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

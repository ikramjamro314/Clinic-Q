import 'package:flutter/material.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../doctor/domain/entities/doctor_entity.dart';

class ClinicDoctorCard extends StatelessWidget {
  final DoctorEntity doctor;
  final VoidCallback onBookTap;

  const ClinicDoctorCard({
    super.key,
    required this.doctor,
    required this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar
          Container(
            width: 70,
            height: 70,
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
                      fontSize: 24,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 12),
          // Name
          Text(
            doctor.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ClinicQColors.textPrimary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          // Specialty Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          // Price
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Rs ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ClinicQColors.successIcon,
                ),
              ),
              Text(
                '${doctor.price.toInt()}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ClinicQColors.successIcon,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
          const Spacer(),
          // Book Button
          SizedBox(
            width: double.infinity,
            height: 36,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: ClinicQColors.gradientHomeFab,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: onBookTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Book',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '?';
    final parts = name.split(' ');
    String initials = '';
    for (var part in parts) {
      if (part.isNotEmpty &&
          part.toLowerCase() != 'dr.' &&
          part.toLowerCase() != 'dr') {
        initials += part[0].toUpperCase();
        if (initials.length >= 2) break;
      }
    }
    if (initials.isEmpty && name.isNotEmpty) return name[0].toUpperCase();
    return initials;
  }
}

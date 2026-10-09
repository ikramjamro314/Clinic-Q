import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../domain/entities/doctor_entity.dart';

class DoctorBookingBottomBar extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorBookingBottomBar({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ClinicQButton(
          label: 'Book a token',
          gradient: ClinicQColors.gradientPrimary,
          onPressed: () {
            final clinicId = doctor.clinicId ?? '';
            context.push(
              '/booking/confirm?doctorId=${doctor.id}&clinicId=$clinicId',
              extra: doctor,
            );
          },
        ),
      ),
    );
  }
}

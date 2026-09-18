import 'package:clinic_q/features/clinic/presentation/clinic_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/feedback/clinicq_loader.dart';
import '../../../../core/widgets/feedback/clinicq_error_widget.dart';
import '../widgets/selectable_doctor_row.dart';

class SelectDoctorScreen extends ConsumerWidget {
  final String clinicId;

  const SelectDoctorScreen({super.key, required this.clinicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorsAsync = ref.watch(clinicDoctorsProvider(clinicId));
    final selectState = ref.watch(selectDoctorViewModelProvider(clinicId));
    final selectNotifier = ref.read(
      selectDoctorViewModelProvider(clinicId).notifier,
    );

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.appBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ClinicQColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Select doctor',
          style: TextStyle(
            color: ClinicQColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: doctorsAsync.when(
        loading: () => const Center(child: ClinicQLoader()),
        error: (err, stack) => Center(
          child: ClinicQErrorWidget(
            message: err.toString(),
            onRetry: () => ref.refresh(clinicDoctorsProvider(clinicId)),
          ),
        ),
        data: (doctors) {
          if (doctors.isEmpty) {
            return const Center(
              child: Text(
                'No doctors available at this clinic.',
                style: TextStyle(color: ClinicQColors.textSecondary),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              final isSelected = selectState.selectedDoctorId == doctor.id;

              return SelectableDoctorRow(
                doctor: doctor,
                isSelected: isSelected,
                onTap: () {
                  selectNotifier.selectDoctor(doctor.id);
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              gradient: ClinicQColors.gradientPrimary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ElevatedButton(
              onPressed: selectState.selectedDoctorId != null
                  ? () {
                      context.push(
                        '/booking/confirm?doctorId=${selectState.selectedDoctorId}&clinicId=$clinicId',
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

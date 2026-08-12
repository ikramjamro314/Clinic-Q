import 'package:clinic_q/features/doctor/presentation/doctor_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../viewmodels/filter_view_model.dart';
import '../widgets/filter_specialty_row.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ClinicQColors.secondaryBackground,
      appBar: AppBar(
        backgroundColor: ClinicQColors.secondaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ClinicQColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Filter',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: ClinicQColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: filterState.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ClinicQColors.primaryTeal,
                      ),
                    )
                  : filterState.errorMessage != null
                  ? Center(child: Text(filterState.errorMessage!))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      itemCount: filterState.specialties.length,
                      itemBuilder: (context, index) {
                        final specialty = filterState.specialties[index];
                        final isSelected = filterState.selectedSpecialtyIds
                            .contains(specialty.id);
                        return FilterSpecialtyRow(
                          specialty: specialty,
                          isSelected: isSelected,
                          onChanged: (value) {
                            ref
                                .read(filterViewModelProvider.notifier)
                                .toggleSpecialty(specialty.id);
                          },
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ClinicQButton(
                label: 'Apply filter',
                onPressed: () {
                  // TODO: Pass selected filters back to parent screen or update global state
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

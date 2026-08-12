import 'package:flutter/material.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../domain/entities/specialty_entity.dart';

class FilterSpecialtyRow extends StatelessWidget {
  final SpecialtyEntity specialty;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const FilterSpecialtyRow({
    super.key,
    required this.specialty,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: ClinicQColors.gradientPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            specialty.iconReference,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          specialty.name,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: ClinicQColors.textPrimary,
          ),
        ),
        trailing: Checkbox(
          value: isSelected,
          onChanged: onChanged,
          activeColor: ClinicQColors.primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(
            color: ClinicQColors.inputBorderDefault,
            width: 1.5,
          ),
        ),
        onTap: () => onChanged(!isSelected),
      ),
    );
  }
}

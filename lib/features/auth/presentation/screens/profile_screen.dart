import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_routes.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/layout/clinicq_card.dart';
import '../../../../core/widgets/inputs/clinicq_text_field.dart';
import '../auth_providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(profileViewModelProvider);
    _nameController = TextEditingController(text: state.name);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _dobController = TextEditingController(text: state.dateOfBirth);

    _nameController.addListener(() {
      ref.read(profileViewModelProvider.notifier).updateName(_nameController.text);
    });
    _phoneController.addListener(() {
      ref.read(profileViewModelProvider.notifier).updatePhone(_phoneController.text);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final theme = Theme.of(context);
    final initialDate = DateTime.now().subtract(const Duration(days: 365 * 25)); // default to age 25
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,
              onPrimary: theme.colorScheme.onPrimary,
              onSurface: theme.colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      final dobStr = "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      _dobController.text = dobStr;
      ref.read(profileViewModelProvider.notifier).updateDateOfBirth(dobStr);
    }
  }

  Future<void> _handleSave() async {
    final success = await ref.read(profileViewModelProvider.notifier).submitProfile();
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
      context.go(AppRoutes.home);
    } else {
      final error = ref.read(profileViewModelProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? 'Failed to save profile. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: context.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      // Header Section
                      Text(
                        'Personal details',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.onSurface,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please initialize your personal information for your health profile.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Input card containing profile details using AppCard
                      ClinicQCard(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
                        borderRadius: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Email Address (Read-Only)
                            Text(
                              'Email Address',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ClinicQTextField(
                              controller: _emailController,
                              readOnly: true,
                              enabled: false,
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Email address',
                              prefixIcon: Icons.email_outlined,
                            ),
                            const SizedBox(height: 16),

                            // Name input
                            Text(
                              'Full Name',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ClinicQTextField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              hintText: 'Enter your name',
                              prefixIcon: Icons.person_outline_rounded,
                            ),
                            const SizedBox(height: 16),

                            // Gender selection
                            Text(
                              'Gender',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: _GenderOption(
                                    label: 'Male',
                                    icon: Icons.male_rounded,
                                    isSelected: state.gender == 'Male',
                                    onTap: () {
                                      ref.read(profileViewModelProvider.notifier).updateGender('Male');
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _GenderOption(
                                    label: 'Female',
                                    icon: Icons.female_rounded,
                                    isSelected: state.gender == 'Female',
                                    onTap: () {
                                      ref.read(profileViewModelProvider.notifier).updateGender('Female');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Date of Birth
                            Text(
                              'Date of Birth',
                              style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ClinicQTextField(
                              controller: _dobController,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              hintText: 'Select your date of birth',
                              prefixIcon: Icons.calendar_today_rounded,
                            ),
                            const SizedBox(height: 16),

                            // Phone Number
                            Text(
                              'Phone Number',
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ClinicQTextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              hintText: '+92 300 1234567',
                              prefixIcon: Icons.phone_outlined,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      // Action button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: ClinicQButton(
                          label: 'Done',
                          onPressed: (state.isValid && !state.isLoading)
                              ? _handleSave
                              : null,
                          isLoading: state.isLoading,
                          height: 56,
                          borderRadius: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.08)
              : theme.colorScheme.surfaceContainerHighest.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

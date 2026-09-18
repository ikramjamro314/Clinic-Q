import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/inputs/clinicq_text_field.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../profile_providers.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  String _selectedGender = 'Male';
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String _formatDob(String? dob) {
    if (dob == null || dob.trim().isEmpty) return '';
    try {
      final parsed = DateTime.tryParse(dob.trim());
      if (parsed != null) {
        return "${parsed.year}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}";
      }
    } catch (_) {}
    if (dob.contains('T')) {
      return dob.split('T').first;
    }
    return dob;
  }

  void _populateFields(dynamic profile) {
    if (profile == null) return;
    _nameController.text = profile.name ?? '';
    _dobController.text = _formatDob(profile.dateOfBirth);
    _phoneController.text = profile.phone ?? '';
    _emailController.text = profile.email ?? '';
    if (profile.gender != null && profile.gender.toString().isNotEmpty) {
      final g = profile.gender.toString().toLowerCase();
      if (g == 'female') {
        _selectedGender = 'Female';
      } else {
        _selectedGender = 'Male';
      }
    }
    _initialized = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final profile = ref.read(profileViewModelProvider).profile;
      if (profile != null) {
        _populateFields(profile);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now().subtract(
      const Duration(days: 365 * 25),
    ); // default to age 25

    if (_dobController.text.trim().isNotEmpty) {
      final parsed = DateTime.tryParse(_dobController.text.trim());
      if (parsed != null && parsed.isBefore(DateTime.now())) {
        initialDate = parsed;
      }
    }

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      final dobStr =
          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      setState(() {
        _dobController.text = dobStr;
      });
    }
  }

  Future<void> _handleSave() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Name cannot be empty')));
      return;
    }

    if (phone.isNotEmpty) {
      final phoneClean = phone.replaceAll(RegExp(r'[\s\-]+'), '');
      final pkPhoneRegex = RegExp(r'^(\+92|92|0)?3[0-9]{9}$');
      if (!pkPhoneRegex.hasMatch(phoneClean)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please enter a valid Pakistani phone number (+923XXXXXXXXX or 03XXXXXXXXX)',
            ),
          ),
        );
        return;
      }
    }

    final profile = ref.read(profileViewModelProvider).profile;
    if (profile == null) return;

    final success = await ref
        .read(profileViewModelProvider.notifier)
        .updateProfile(
          name: name,
          gender: _selectedGender,
          dateOfBirth: _dobController.text,
          email: profile.email,
          phone: phone,
        );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.of(context).pop();
    } else {
      final error = ref.read(profileViewModelProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Failed to update profile. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(profileViewModelProvider);

    if (!_initialized && state.profile != null) {
      _populateFields(state.profile);
    }

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: null, // Custom curved header is used instead of standard appbar
      body: SafeArea(
        top: false,
        child: Builder(
          builder: (context) {
            if (state.isLoading && state.profile == null) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const SkeletonBox(
                      width: 100,
                      height: 100,
                      borderRadius: 50,
                    ),
                    const SizedBox(height: 30),
                    ...List.generate(
                      4,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: SkeletonBox(
                          width: double.infinity,
                          height: 50,
                          borderRadius: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            final profile = state.profile;
            if (profile == null) {
              return const Center(child: Text('No profile data available.'));
            }

            final initials = profile.name.isNotEmpty
                ? profile.name
                      .trim()
                      .split(' ')
                      .map((e) => e[0])
                      .take(2)
                      .join()
                      .toUpperCase()
                : 'U';

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Curved Header Stack
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Header Curve Background
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 180),
                        painter: _HeaderCurvePainter(),
                      ),

                      // Back Button
                      Positioned(
                        top: 50,
                        left: 12,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),

                      // Centered Title Text on Header
                      Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),

                      // Avatar overlapping bottom boundary
                      Positioned(
                        bottom: -44,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 46,
                                  backgroundColor: ClinicQColors.primaryTeal
                                      .withOpacity(0.1),
                                  child: Text(
                                    initials,
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                          color: ClinicQColors.primaryTeal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: ClinicQColors.primaryTeal,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 56),

                  // Name text under profile picture
                  Center(
                    child: Text(
                      profile.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ClinicQColors.textPrimary,
                        fontSize: 22,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Form content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Name Field
                        Text(
                          'Name',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClinicQTextField(
                          controller: _nameController,
                          hintText: 'Elon Musk',
                          prefixIcon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),

                        // Gender Selector
                        Text(
                          'Gender',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _GenderPill(
                                label: 'Male',
                                icon: Icons.male_rounded,
                                isSelected: _selectedGender == 'Male',
                                onTap: () =>
                                    setState(() => _selectedGender = 'Male'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _GenderPill(
                                label: 'Female',
                                icon: Icons.female_rounded,
                                isSelected: _selectedGender == 'Female',
                                onTap: () =>
                                    setState(() => _selectedGender = 'Female'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Date of birth Field
                        Text(
                          'Date of birth',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClinicQTextField(
                          controller: _dobController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          hintText: '20/01/1990',
                          prefixIcon: Icons.calendar_today_outlined,
                        ),
                        const SizedBox(height: 16),

                        // Phone number Field
                        Text(
                          'Phone number',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClinicQTextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          hintText: 'Enter your phone number',
                          prefixIcon: Icons.phone_outlined,
                        ),
                        const SizedBox(height: 16),

                        // Email Field (Read-only)
                        Text(
                          'Email',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClinicQTextField(
                          controller: _emailController,
                          readOnly: true,
                          enabled: false,
                          hintText: 'Email address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 32),

                        // Save Button
                        ClinicQButton(
                          label: 'Save',
                          onPressed: state.isLoading ? null : _handleSave,
                          isLoading: state.isLoading,
                          height: 54,
                          borderRadius: 27,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GenderPill extends StatelessWidget {
  const _GenderPill({
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? ClinicQColors.primaryTeal.withOpacity(0.08)
              : ClinicQColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? ClinicQColors.primaryTeal
                : ClinicQColors.cardBorder,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? ClinicQColors.primaryTeal
                  : ClinicQColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? ClinicQColors.primaryTeal
                    : ClinicQColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = ClinicQColors.primaryTeal;
    final path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height * 0.75,
    );
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

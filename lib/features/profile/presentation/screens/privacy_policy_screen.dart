import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../profile_providers.dart';

class PrivacyPolicyScreen extends ConsumerWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final policyFuture = ref.read(contentRepositoryProvider).getPrivacyPolicy();

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: ClinicQColors.textPrimary,
          ),
        ),
        backgroundColor: ClinicQColors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ClinicQColors.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: policyFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    6,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SkeletonBox(
                        width: index % 2 == 0 ? double.infinity : 200,
                        height: 16,
                        borderRadius: 4,
                      ),
                    ),
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading policy.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: ClinicQColors.errorText,
                  ),
                ),
              );
            }

            final data = snapshot.data ?? '';
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: ClinicQColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ClinicQColors.cardBorder),
                  boxShadow: [
                    BoxShadow(
                      color: ClinicQColors.cardShadow.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  data,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: ClinicQColors.textPrimary,
                    height: 1.6,
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

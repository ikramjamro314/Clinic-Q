import 'package:clinic_q/features/profile/presentation/screens/faq_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/clinic_q_colors.dart';
import '../../../../core/widgets/feedback/skeleton_box.dart';
import '../profile_providers.dart';
import '../../domain/entities/faq_item.dart';
import '../widgets/profile_menu_item.dart';

class FAQScreen extends ConsumerWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final faqFuture = ref.read(contentRepositoryProvider).getFaqList();

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        title: Text(
          'Frequently Asked Questions',
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
        child: FutureBuilder<List<FaqItem>>(
          future: faqFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SkeletonBox(
                    width: double.infinity,
                    height: 56,
                    borderRadius: 16,
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading FAQs.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: ClinicQColors.errorText,
                  ),
                ),
              );
            }

            final items = snapshot.data ?? [];
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ProfileMenuItem(
                  icon: Icons.help_outline_rounded,
                  title: item.question,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FAQDetailScreen(faqItem: item),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

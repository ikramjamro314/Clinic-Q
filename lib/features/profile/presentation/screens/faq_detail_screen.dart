import 'package:flutter/material.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../../domain/entities/faq_item.dart';

class FAQDetailScreen extends StatelessWidget {
  const FAQDetailScreen({super.key, required this.faqItem});

  final FaqItem faqItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ClinicQColors.appBackground,
      appBar: AppBar(
        title: Text(
          'FAQ Detail',
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Question Card
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: ClinicQColors.gradientPrimary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: ClinicQColors.primaryTeal.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.help_center_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        faqItem.question,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Answer Card
              Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Answer:',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: ClinicQColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      faqItem.answer,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: ClinicQColors.textPrimary,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/clinic_q_colors.dart';
import '../ratings_providers.dart';
import '../widgets/review_card.dart';

class AllReviewsScreen extends ConsumerWidget {
  final String doctorId;

  const AllReviewsScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final reviewsState = ref.watch(reviewsViewModelProvider(doctorId));

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
          'All reviews',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: ClinicQColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: reviewsState.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: ClinicQColors.primaryTeal,
                ),
              )
            : reviewsState.errorMessage != null
            ? Center(child: Text(reviewsState.errorMessage!))
            : reviewsState.reviews.isEmpty
            ? const Center(child: Text('No reviews found.'))
            : ListView.builder(
                padding: const EdgeInsets.all(24.0),
                itemCount: reviewsState.reviews.length,
                itemBuilder: (context, index) {
                  return ReviewCard(review: reviewsState.reviews[index]);
                },
              ),
      ),
    );
  }
}

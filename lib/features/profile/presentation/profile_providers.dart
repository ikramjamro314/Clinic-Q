import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/local/interest_local_data_source.dart';
import '../data/repositories/content_repository_impl.dart';
import '../domain/repositories/content_repository.dart';
import 'viewmodels/profile_view_model.dart';
import 'viewmodels/interest_list_view_model.dart';

export 'viewmodels/profile_view_model.dart';
export 'viewmodels/interest_list_view_model.dart';
export '../data/local/interest_local_data_source.dart'
    show isInterestedProvider, interestLocalDataSourceProvider;
export '../data/repositories/content_repository_impl.dart'
    show contentRepositoryProvider;

// ViewModels
final profileViewModelProvider =
    NotifierProvider<ProfileViewModel, ProfileState>(
      ProfileViewModel.new,
    );

final interestListViewModelProvider =
    NotifierProvider.autoDispose<InterestListViewModel, InterestListState>(
      InterestListViewModel.new,
    );

// Sources & Repositories
final profileInterestLocalDataSourceProvider =
    Provider<InterestLocalDataSource>((ref) {
      return ref.watch(interestLocalDataSourceProvider);
    });

final profileContentRepositoryProvider = Provider<ContentRepository>((ref) {
  return ref.watch(contentRepositoryProvider);
});

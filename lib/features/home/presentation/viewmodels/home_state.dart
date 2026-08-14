import 'package:flutter/foundation.dart';

@immutable
class DoctorItem {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final String? avatarUrl;
  final bool isAvailable;

  const DoctorItem({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    this.avatarUrl,
    this.isAvailable = true,
  });
}

@immutable
class ClinicItem {
  final String id;
  final String name;
  final String address;
  final String? imageUrl;
  final double rating;

  const ClinicItem({
    required this.id,
    required this.name,
    required this.address,
    this.imageUrl,
    this.rating = 4.8,
  });
}

@immutable
class HomeBannerData {
  final String badgeText;
  final String title;
  final String patientCountText;

  const HomeBannerData({
    required this.badgeText,
    required this.title,
    required this.patientCountText,
  });
}

@immutable
class HomeState {
  final bool isLoading;
  final String? errorMessage;
  final String userName;
  final HomeBannerData? bannerData;
  final List<DoctorItem> doctors;
  final List<ClinicItem> clinics;
  final int selectedNavIndex;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.userName = '',
    this.bannerData,
    this.doctors = const [],
    this.clinics = const [],
    this.selectedNavIndex = 2, // 2 is Home tab
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? userName,
    HomeBannerData? bannerData,
    List<DoctorItem>? doctors,
    List<ClinicItem>? clinics,
    int? selectedNavIndex,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      userName: userName ?? this.userName,
      bannerData: bannerData ?? this.bannerData,
      doctors: doctors ?? this.doctors,
      clinics: clinics ?? this.clinics,
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
    );
  }
}

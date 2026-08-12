import 'package:flutter/foundation.dart';

@immutable
class ClinicEntity {
  final String id;
  final String name;
  final String? imageUrl;
  final String specialtyTag;
  final double rating;
  final int reviewCount;
  final String openingHours;
  final String address;
  final int doctorCount;
  final String phone;
  final String patientCount;
  final String specialistCount;
  final String yearsExperience;
  final bool isOpen;

  const ClinicEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.specialtyTag,
    required this.rating,
    required this.reviewCount,
    required this.openingHours,
    required this.address,
    required this.doctorCount,
    required this.phone,
    required this.patientCount,
    required this.specialistCount,
    required this.yearsExperience,
    this.isOpen = true,
  });

  ClinicEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? specialtyTag,
    double? rating,
    int? reviewCount,
    String? openingHours,
    String? address,
    int? doctorCount,
    String? phone,
    String? patientCount,
    String? specialistCount,
    String? yearsExperience,
    bool? isOpen,
  }) {
    return ClinicEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      specialtyTag: specialtyTag ?? this.specialtyTag,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      openingHours: openingHours ?? this.openingHours,
      address: address ?? this.address,
      doctorCount: doctorCount ?? this.doctorCount,
      phone: phone ?? this.phone,
      patientCount: patientCount ?? this.patientCount,
      specialistCount: specialistCount ?? this.specialistCount,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}

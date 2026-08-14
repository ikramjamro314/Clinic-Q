import 'package:flutter/foundation.dart';

@immutable
class ClinicEntity {
  final String id;
  final String name; // maps to clinicName
  final String? imageUrl;
  final String specialtyTag; // first of specialties or default
  final double rating;
  final int reviewCount;
  final String openingHours; // constructed from openTime/closeTime/workingDays
  final String address;
  final int doctorCount;
  final String phone;
  final String patientCount;
  final String specialistCount;
  final String yearsExperience;
  final bool isOpen;

  // Real API fields
  final String? ownerId;
  final String? clinicName;
  final String? tagline;
  final String? description;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? email;
  final String? website;
  final String? openTime;
  final String? closeTime;
  final List<String> workingDays;
  final List<String> specialties;
  final List<String> facilities;
  final bool emergencyServices;
  final String? createdAt;
  final String? updatedAt;

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
    this.ownerId,
    this.clinicName,
    this.tagline,
    this.description,
    this.city,
    this.state,
    this.zipCode,
    this.email,
    this.website,
    this.openTime,
    this.closeTime,
    this.workingDays = const [],
    this.specialties = const [],
    this.facilities = const [],
    this.emergencyServices = false,
    this.createdAt,
    this.updatedAt,
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
    String? ownerId,
    String? clinicName,
    String? tagline,
    String? description,
    String? city,
    String? state,
    String? zipCode,
    String? email,
    String? website,
    String? openTime,
    String? closeTime,
    List<String>? workingDays,
    List<String>? specialties,
    List<String>? facilities,
    bool? emergencyServices,
    String? createdAt,
    String? updatedAt,
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
      ownerId: ownerId ?? this.ownerId,
      clinicName: clinicName ?? this.clinicName,
      tagline: tagline ?? this.tagline,
      description: description ?? this.description,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      email: email ?? this.email,
      website: website ?? this.website,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      workingDays: workingDays ?? this.workingDays,
      specialties: specialties ?? this.specialties,
      facilities: facilities ?? this.facilities,
      emergencyServices: emergencyServices ?? this.emergencyServices,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}


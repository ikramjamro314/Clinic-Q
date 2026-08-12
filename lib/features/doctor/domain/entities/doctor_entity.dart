import 'package:flutter/foundation.dart';

@immutable
class DoctorEntity {
  final String id;
  final String name;
  final String specialty;
  final String clinicName;
  final String? photoUrl;
  final double rating;
  final int reviewCount;
  final double price;
  final int durationMinutes;
  final bool isInterested;
  final bool isAvailable;
  final String? about;
  final String? location;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.specialty,
    required this.clinicName,
    this.photoUrl,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.durationMinutes,
    this.isInterested = false,
    this.isAvailable = true,
    this.about,
    this.location,
  });

  DoctorEntity copyWith({
    String? id,
    String? name,
    String? specialty,
    String? clinicName,
    String? photoUrl,
    double? rating,
    int? reviewCount,
    double? price,
    int? durationMinutes,
    bool? isInterested,
    bool? isAvailable,
    String? about,
    String? location,
  }) {
    return DoctorEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      clinicName: clinicName ?? this.clinicName,
      photoUrl: photoUrl ?? this.photoUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      price: price ?? this.price,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      isInterested: isInterested ?? this.isInterested,
      isAvailable: isAvailable ?? this.isAvailable,
      about: about ?? this.about,
      location: location ?? this.location,
    );
  }
}

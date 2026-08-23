import 'package:flutter/foundation.dart';

@immutable
class DoctorEntity {
  final String id;
  final String name;
  final String specialty; // maps to specialization
  final String clinicName; // maps to clinicId or fallback
  final String? photoUrl; // maps to image
  final double rating;
  final int reviewCount;
  final double price; // maps to consultationFee
  final int durationMinutes; // maps to avgServiceDuration
  final bool isInterested;
  final bool isAvailable;
  final String? about; // maps to qualification or fallback
  final String? location;

  // API fields
  final String? clinicId;
  final String? qualification;
  final int? experience;
  final List<String> workingDays;
  final String? startTime;
  final String? endTime;
  final int? maxTokensPerDay;

  // Cache-aside status fields
  final bool isFromCache;
  final String? cacheError;

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
    this.clinicId,
    this.qualification,
    this.experience,
    this.workingDays = const [],
    this.startTime,
    this.endTime,
    this.maxTokensPerDay,
    this.isFromCache = false,
    this.cacheError,
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
    String? clinicId,
    String? qualification,
    int? experience,
    List<String>? workingDays,
    String? startTime,
    String? endTime,
    int? maxTokensPerDay,
    bool? isFromCache,
    String? cacheError,
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
      clinicId: clinicId ?? this.clinicId,
      qualification: qualification ?? this.qualification,
      experience: experience ?? this.experience,
      workingDays: workingDays ?? this.workingDays,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      maxTokensPerDay: maxTokensPerDay ?? this.maxTokensPerDay,
      isFromCache: isFromCache ?? this.isFromCache,
      cacheError: cacheError ?? this.cacheError,
    );
  }
}


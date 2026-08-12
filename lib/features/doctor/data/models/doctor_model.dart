import '../../domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  const DoctorModel({
    required super.id,
    required super.name,
    required super.specialty,
    required super.clinicName,
    super.photoUrl,
    required super.rating,
    required super.reviewCount,
    required super.price,
    required super.durationMinutes,
    super.isInterested = false,
    super.isAvailable = true,
    super.about,
    super.location,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      specialty: json['specialty'] as String? ?? '',
      clinicName: json['clinic_name'] as String? ?? '',
      photoUrl: json['photo_url'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 15,
      isInterested: json['is_interested'] as bool? ?? false,
      isAvailable: json['is_available'] as bool? ?? true,
      about: json['about'] as String?,
      location: json['location'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'clinic_name': clinicName,
      'photo_url': photoUrl,
      'rating': rating,
      'review_count': reviewCount,
      'price': price,
      'duration_minutes': durationMinutes,
      'is_interested': isInterested,
      'is_available': isAvailable,
      'about': about,
      'location': location,
    };
  }

  factory DoctorModel.fromEntity(DoctorEntity entity) {
    return DoctorModel(
      id: entity.id,
      name: entity.name,
      specialty: entity.specialty,
      clinicName: entity.clinicName,
      photoUrl: entity.photoUrl,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      price: entity.price,
      durationMinutes: entity.durationMinutes,
      isInterested: entity.isInterested,
      isAvailable: entity.isAvailable,
      about: entity.about,
      location: entity.location,
    );
  }
}

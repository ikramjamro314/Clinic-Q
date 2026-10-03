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
    super.clinicId,
    super.qualification,
    super.experience,
    super.workingDays,
    super.startTime,
    super.endTime,
    super.maxTokensPerDay,
  });

  static List<String> _parseList(dynamic field) {
    if (field is List) {
      return List<String>.from(field.map((e) => e.toString()));
    } else if (field is String) {
      if (field.trim().isEmpty) return const [];
      return field.split(',').map((e) => e.trim()).toList();
    }
    return const [];
  }

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    final rawWorkingDays = json['workingDays'] is List
        ? List<String>.from(json['workingDays'] as List)
        : const <String>[];
    final clinicIdVal = json['clinicId'] as String?;

    return DoctorModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      specialty: json['specialization'] as String? ?? 'General',
      clinicName: clinicIdVal != null
          ? 'Clinic ${clinicIdVal.substring(0, 4)}'
          : 'Clinic',
      photoUrl: json['image'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.9,
      reviewCount: 80,
      price: (json['consultationFee'] as num?)?.toDouble() ?? 2500.0,
      durationMinutes: (json['avgServiceDuration'] as num?)?.toInt() ?? 20,
      isInterested: false,
      isAvailable: true,
      about: json['qualification'] as String? ?? 'Specialist Physician',
      location: 'Pakistan',
      clinicId: clinicIdVal,
      qualification: json['qualification'] as String?,
      experience: (json['experience'] as num?)?.toInt(),
      workingDays: rawWorkingDays,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      maxTokensPerDay: (json['maxTokensPerDay'] as num?)?.toInt() ?? 30,
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
      'clinicId': clinicId,
      'qualification': qualification,
      'experience': experience,
      'workingDays': workingDays,
      'startTime': startTime,
      'endTime': endTime,
      'maxTokensPerDay': maxTokensPerDay,
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
      clinicId: entity.clinicId,
      qualification: entity.qualification,
      experience: entity.experience,
      workingDays: entity.workingDays,
      startTime: entity.startTime,
      endTime: entity.endTime,
      maxTokensPerDay: entity.maxTokensPerDay,
    );
  }
}

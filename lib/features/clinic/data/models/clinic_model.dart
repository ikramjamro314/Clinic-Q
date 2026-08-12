import '../../domain/entities/clinic_entity.dart';

class ClinicModel extends ClinicEntity {
  const ClinicModel({
    required super.id,
    required super.name,
    super.imageUrl,
    required super.specialtyTag,
    required super.rating,
    required super.reviewCount,
    required super.openingHours,
    required super.address,
    required super.doctorCount,
    required super.phone,
    required super.patientCount,
    required super.specialistCount,
    required super.yearsExperience,
    super.isOpen = true,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
      specialtyTag: json['specialty_tag'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 0,
      openingHours: json['opening_hours'] as String? ?? '',
      address: json['address'] as String? ?? '',
      doctorCount: (json['doctor_count'] as num?)?.toInt() ?? 0,
      phone: json['phone'] as String? ?? '',
      patientCount: json['patient_count'] as String? ?? '',
      specialistCount: json['specialist_count'] as String? ?? '',
      yearsExperience: json['years_experience'] as String? ?? '',
      isOpen: json['is_open'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'specialty_tag': specialtyTag,
      'rating': rating,
      'review_count': reviewCount,
      'opening_hours': openingHours,
      'address': address,
      'doctor_count': doctorCount,
      'phone': phone,
      'patient_count': patientCount,
      'specialist_count': specialistCount,
      'years_experience': yearsExperience,
      'is_open': isOpen,
    };
  }

  factory ClinicModel.fromEntity(ClinicEntity entity) {
    return ClinicModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      specialtyTag: entity.specialtyTag,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      openingHours: entity.openingHours,
      address: entity.address,
      doctorCount: entity.doctorCount,
      phone: entity.phone,
      patientCount: entity.patientCount,
      specialistCount: entity.specialistCount,
      yearsExperience: entity.yearsExperience,
      isOpen: entity.isOpen,
    );
  }
}

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
    super.ownerId,
    super.clinicName,
    super.tagline,
    super.description,
    super.city,
    super.state,
    super.zipCode,
    super.email,
    super.website,
    super.openTime,
    super.closeTime,
    super.workingDays,
    super.specialties,
    super.facilities,
    super.emergencyServices,
    super.createdAt,
    super.updatedAt,
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

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    final rawSpecialties = _parseList(json['specialties']);
    final rawWorkingDays = _parseList(json['workingDays']);
    final rawFacilities = _parseList(json['facilities']);

    final open = json['openTime'] as String? ?? '';
    final close = json['closeTime'] as String? ?? '';

    final computedOpeningHours = (open.isNotEmpty && close.isNotEmpty)
        ? '${rawWorkingDays.isNotEmpty ? rawWorkingDays.join(', ') : 'Daily'}: $open - $close'
        : (json['opening_hours'] as String? ?? 'Mon-Fri: 9:00 AM - 8:00 PM');

    final computedSpecialtyTag = rawSpecialties.isNotEmpty
        ? rawSpecialties.first
        : (json['specialty_tag'] as String? ?? 'General');

    return ClinicModel(
      id: json['id'] as String? ?? json['_id'] as String? ?? '',
      name: json['clinicName'] as String? ?? json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? json['image_url'] as String?,
      specialtyTag: computedSpecialtyTag,
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      reviewCount: (json['review_count'] as num?)?.toInt() ?? 120,
      openingHours: computedOpeningHours,
      address: json['address'] as String? ?? '',
      doctorCount: (json['doctor_count'] as num?)?.toInt() ?? 3,
      phone: json['phone'] as String? ?? '',
      patientCount: json['patient_count'] as String? ?? '100+',
      specialistCount: json['specialist_count'] as String? ?? '5+',
      yearsExperience: json['years_experience'] as String? ?? '5Yrs+',
      isOpen: json['is_open'] as bool? ?? true,
      ownerId: json['ownerId'] as String?,
      clinicName: json['clinicName'] as String?,
      tagline: json['tagline'] as String?,
      description: json['description'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      openTime: json['openTime'] as String?,
      closeTime: json['closeTime'] as String?,
      workingDays: rawWorkingDays,
      specialties: rawSpecialties,
      facilities: rawFacilities,
      emergencyServices: json['emergencyServices'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'specialtyTag': specialtyTag,
      'rating': rating,
      'reviewCount': reviewCount,
      'openingHours': openingHours,
      'address': address,
      'doctorCount': doctorCount,
      'phone': phone,
      'patientCount': patientCount,
      'specialistCount': specialistCount,
      'yearsExperience': yearsExperience,
      'isOpen': isOpen,
      'ownerId': ownerId,
      'clinicName': clinicName,
      'tagline': tagline,
      'description': description,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'email': email,
      'website': website,
      'openTime': openTime,
      'closeTime': closeTime,
      'workingDays': workingDays,
      'specialties': specialties,
      'facilities': facilities,
      'emergencyServices': emergencyServices,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
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
      ownerId: entity.ownerId,
      clinicName: entity.clinicName,
      tagline: entity.tagline,
      description: entity.description,
      city: entity.city,
      state: entity.state,
      zipCode: entity.zipCode,
      email: entity.email,
      website: entity.website,
      openTime: entity.openTime,
      closeTime: entity.closeTime,
      workingDays: entity.workingDays,
      specialties: entity.specialties,
      facilities: entity.facilities,
      emergencyServices: entity.emergencyServices,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

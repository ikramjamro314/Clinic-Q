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
    final rawSpecialties = json['specialties'] is List
        ? List<String>.from(json['specialties'] as List)
        : const <String>[];
    final rawWorkingDays = json['workingDays'] is List
        ? List<String>.from(json['workingDays'] as List)
        : const <String>[];
    final rawFacilities = json['facilities'] is List
        ? List<String>.from(json['facilities'] as List)
        : const <String>[];

    final open = json['openTime'] as String? ?? '';
    final close = json['closeTime'] as String? ?? '';
    final computedOpeningHours = (open.isNotEmpty && close.isNotEmpty)
        ? '${rawWorkingDays.isNotEmpty ? rawWorkingDays.join(', ') : 'Daily'}: $open - $close'
        : '09:00 - 21:00';

    final clinicTitle = json['clinicName'] as String? ?? '';

    return ClinicModel(
      id: json['id'] as String? ?? '',
      name: clinicTitle,
      imageUrl: null,
      specialtyTag: rawSpecialties.isNotEmpty ? rawSpecialties.first : 'General',
      rating: 4.8,
      reviewCount: 120,
      openingHours: computedOpeningHours,
      address: json['address'] as String? ?? '',
      doctorCount: 3,
      phone: json['phone'] as String? ?? '',
      patientCount: '100+',
      specialistCount: '${rawSpecialties.length}+',
      yearsExperience: '5Yrs+',
      isOpen: true,
      ownerId: json['ownerId'] as String?,
      clinicName: clinicTitle,
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

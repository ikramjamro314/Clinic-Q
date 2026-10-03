import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.name,
    required super.role,
    required super.email,
    super.phone,
    required super.isAccountVerified,
    super.clinicId,
    super.createdAt,
    super.updatedAt,
    super.gender,
    super.dateOfBirth,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      isAccountVerified: json['isAccountVerified'] as bool? ?? false,
      clinicId: json['clinicId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      gender: json['gender'] as String?,
      dateOfBirth: json['dob'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'email': email,
      'phone': phone,
      'isAccountVerified': isAccountVerified,
      'clinicId': clinicId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }
}

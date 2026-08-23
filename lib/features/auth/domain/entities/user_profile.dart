import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String role;
  final String email;
  final String? phone;
  final bool isAccountVerified;
  final String? clinicId;
  final String? createdAt;
  final String? updatedAt;

  final String? gender;
  final String? dateOfBirth;

  // Cache-aside status fields
  final bool isFromCache;
  final String? cacheError;

  const UserProfile({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    this.phone,
    required this.isAccountVerified,
    this.clinicId,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.dateOfBirth,
    this.isFromCache = false,
    this.cacheError,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? role,
    String? email,
    String? phone,
    bool? isAccountVerified,
    String? clinicId,
    String? createdAt,
    String? updatedAt,
    String? gender,
    String? dateOfBirth,
    bool? isFromCache,
    String? cacheError,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isAccountVerified: isAccountVerified ?? this.isAccountVerified,
      clinicId: clinicId ?? this.clinicId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isFromCache: isFromCache ?? this.isFromCache,
      cacheError: cacheError ?? this.cacheError,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        role,
        email,
        phone,
        isAccountVerified,
        clinicId,
        createdAt,
        updatedAt,
        gender,
        dateOfBirth,
        isFromCache,
        cacheError,
      ];
}

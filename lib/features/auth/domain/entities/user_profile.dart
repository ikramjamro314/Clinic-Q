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
  });

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
      ];
}

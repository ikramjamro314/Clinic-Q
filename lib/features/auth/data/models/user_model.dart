import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.firstName,
    super.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final metadata = json['user_metadata'] as Map<String, dynamic>? ?? {};
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String? ?? '',
      firstName: metadata['first_name'] as String?,
      lastName: metadata['last_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'user_metadata': {'first_name': firstName, 'last_name': lastName},
    };
  }
}

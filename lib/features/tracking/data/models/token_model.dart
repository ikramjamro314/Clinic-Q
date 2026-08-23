import '../../domain/entities/token.dart';

class TokenModel extends Token {
  const TokenModel({
    required super.id,
    required super.doctorId,
    required super.clinicId,
    required super.userId,
    super.notes,
    required super.status,
    super.tokenNumber,
    super.createdAt,
    super.isFromCache = false,
    super.cacheError,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      id: json['id'] as String? ?? json['_id'] as String? ?? json['tokenId'] as String? ?? '',
      doctorId: json['doctorId'] as String? ?? json['doctor_id'] as String? ?? '',
      clinicId: json['clinicId'] as String? ?? json['clinic_id'] as String? ?? '',
      userId: json['userId'] as String? ?? json['user_id'] as String? ?? '',
      notes: json['notes'] as String?,
      status: json['status'] as String? ?? 'waiting',
      tokenNumber: json['tokenNumber'] as int? ?? json['token_number'] as int? ?? (json['tokenNumber'] != null ? int.tryParse(json['tokenNumber'].toString()) : null),
      createdAt: json['createdAt'] as String? ?? json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'clinicId': clinicId,
      'userId': userId,
      'notes': notes,
      'status': status,
      'tokenNumber': tokenNumber,
      'createdAt': createdAt,
    };
  }
}

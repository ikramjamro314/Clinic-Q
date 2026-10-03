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
    String parsedUserId = json['userId'] as String? ??
        json['user_id'] as String? ??
        json['patientId'] as String? ??
        json['patient_id'] as String? ??
        '';

    if (parsedUserId.isEmpty) {
      if (json['user'] is Map) {
        parsedUserId = (json['user']['id'] ?? json['user']['_id'] ?? '')?.toString() ?? '';
      } else if (json['patient'] is Map) {
        parsedUserId = (json['patient']['id'] ?? json['patient']['_id'] ?? '')?.toString() ?? '';
      }
    }

    String parsedDoctorId = json['doctorId'] as String? ??
        json['doctor_id'] as String? ??
        '';
    if (parsedDoctorId.isEmpty && json['doctor'] is Map) {
      parsedDoctorId = (json['doctor']['id'] ?? json['doctor']['_id'] ?? '')?.toString() ?? '';
    }

    String parsedClinicId = json['clinicId'] as String? ??
        json['clinic_id'] as String? ??
        '';
    if (parsedClinicId.isEmpty && json['clinic'] is Map) {
      parsedClinicId = (json['clinic']['id'] ?? json['clinic']['_id'] ?? '')?.toString() ?? '';
    }

    return TokenModel(
      id: json['id'] as String? ?? json['_id'] as String? ?? json['tokenId'] as String? ?? '',
      doctorId: parsedDoctorId,
      clinicId: parsedClinicId,
      userId: parsedUserId,
      notes: json['notes'] as String?,
      status: json['status'] as String? ?? 'waiting',
      tokenNumber: json['tokenNumber'] as int? ??
          json['token_number'] as int? ??
          (json['tokenNumber'] != null ? int.tryParse(json['tokenNumber'].toString()) : null) ??
          (json['token_number'] != null ? int.tryParse(json['token_number'].toString()) : null),
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

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
    super.patientName,
    super.doctorName,
    super.clinicName,
    super.specialization,
    super.queueStatus,
    super.tokensAhead,
    super.estimatedTime,
    super.estimatedWaitMinutes,
    super.appointmentDate,
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

    String? parsedPatientName = json['patientName'] as String? ??
        json['patient_name'] as String? ??
        json['name'] as String?;
    if (parsedPatientName == null || parsedPatientName.isEmpty) {
      if (json['user'] is Map && json['user']['name'] != null) {
        parsedPatientName = json['user']['name'] as String?;
      } else if (json['patient'] is Map && json['patient']['name'] != null) {
        parsedPatientName = json['patient']['name'] as String?;
      }
    }

    String? parsedDoctorName = json['doctorName'] as String? ??
        json['doctor_name'] as String?;
    if (parsedDoctorName == null && json['doctor'] is Map && json['doctor']['name'] != null) {
      parsedDoctorName = json['doctor']['name'] as String?;
    }

    String? parsedClinicName = json['clinicName'] as String? ??
        json['clinic_name'] as String?;
    if (parsedClinicName == null && json['clinic'] is Map && json['clinic']['name'] != null) {
      parsedClinicName = json['clinic']['name'] as String?;
    }

    String? parsedSpecialization = json['specialization'] as String? ??
        json['specialty'] as String?;

    String? parsedQueueStatus = json['queueStatus'] as String? ??
        json['queue_status'] as String?;

    int? parsedTokensAhead = json['tokensAhead'] as int? ??
        json['tokens_ahead'] as int? ??
        json['patientsAheadCount'] as int? ??
        json['patients_ahead_count'] as int?;

    String? parsedEstimatedTime = json['estimatedTime'] as String? ??
        json['estimated_time'] as String?;

    int? parsedEstimatedWaitMinutes = json['estimatedWaitMinutes'] as int? ??
        json['estimated_wait_minutes'] as int? ??
        json['estimatedWait'] as int?;

    String? parsedAppointmentDate = json['appointmentDate'] as String? ??
        json['appointment_date'] as String? ??
        json['date'] as String?;

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
      patientName: parsedPatientName,
      doctorName: parsedDoctorName,
      clinicName: parsedClinicName,
      specialization: parsedSpecialization,
      queueStatus: parsedQueueStatus,
      tokensAhead: parsedTokensAhead,
      estimatedTime: parsedEstimatedTime,
      estimatedWaitMinutes: parsedEstimatedWaitMinutes,
      appointmentDate: parsedAppointmentDate,
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
      'patientName': patientName,
      'doctorName': doctorName,
      'clinicName': clinicName,
      'specialization': specialization,
      'queueStatus': queueStatus,
      'tokensAhead': tokensAhead,
      'estimatedTime': estimatedTime,
      'estimatedWaitMinutes': estimatedWaitMinutes,
      'appointmentDate': appointmentDate,
    };
  }
}

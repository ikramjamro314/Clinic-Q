import 'package:flutter/foundation.dart';

@immutable
class Token {
  final String id;
  final String doctorId;
  final String clinicId;
  final String userId;
  final String? notes;
  final String status;
  final int? tokenNumber;
  final String? createdAt;
  final String? patientName;

  // New Booking & Live Queue response fields
  final String? doctorName;
  final String? clinicName;
  final String? specialization;
  final String? queueStatus;
  final int? tokensAhead;
  final String? estimatedTime;
  final int? estimatedWaitMinutes;
  final String? appointmentDate;

  // Cache-aside status fields
  final bool isFromCache;
  final String? cacheError;

  const Token({
    required this.id,
    required this.doctorId,
    required this.clinicId,
    required this.userId,
    this.notes,
    required this.status,
    this.tokenNumber,
    this.createdAt,
    this.patientName,
    this.doctorName,
    this.clinicName,
    this.specialization,
    this.queueStatus,
    this.tokensAhead,
    this.estimatedTime,
    this.estimatedWaitMinutes,
    this.appointmentDate,
    this.isFromCache = false,
    this.cacheError,
  });

  Token copyWith({
    String? id,
    String? doctorId,
    String? clinicId,
    String? userId,
    String? notes,
    String? status,
    int? tokenNumber,
    String? createdAt,
    String? patientName,
    String? doctorName,
    String? clinicName,
    String? specialization,
    String? queueStatus,
    int? tokensAhead,
    String? estimatedTime,
    int? estimatedWaitMinutes,
    String? appointmentDate,
    bool? isFromCache,
    String? cacheError,
  }) {
    return Token(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      clinicId: clinicId ?? this.clinicId,
      userId: userId ?? this.userId,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      tokenNumber: tokenNumber ?? this.tokenNumber,
      createdAt: createdAt ?? this.createdAt,
      patientName: patientName ?? this.patientName,
      doctorName: doctorName ?? this.doctorName,
      clinicName: clinicName ?? this.clinicName,
      specialization: specialization ?? this.specialization,
      queueStatus: queueStatus ?? this.queueStatus,
      tokensAhead: tokensAhead ?? this.tokensAhead,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      estimatedWaitMinutes: estimatedWaitMinutes ?? this.estimatedWaitMinutes,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      isFromCache: isFromCache ?? this.isFromCache,
      cacheError: cacheError ?? this.cacheError,
    );
  }
}

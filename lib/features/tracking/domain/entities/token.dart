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
      isFromCache: isFromCache ?? this.isFromCache,
      cacheError: cacheError ?? this.cacheError,
    );
  }
}

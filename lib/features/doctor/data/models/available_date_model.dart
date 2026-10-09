import '../../domain/entities/available_date_entity.dart';

class AvailableDateModel extends AvailableDateEntity {
  const AvailableDateModel({
    required super.date,
    required super.dayName,
    required super.tokensRemaining,
    required super.dailyTokenCap,
    required super.nextTokenNumber,
  });

  factory AvailableDateModel.fromJson(Map<String, dynamic> json) {
    return AvailableDateModel(
      date: json['date'] as String? ?? '',
      dayName: json['dayName'] as String? ?? json['day_name'] as String? ?? '',
      tokensRemaining: (json['tokensRemaining'] as num?)?.toInt() ??
          (json['tokens_remaining'] as num?)?.toInt() ??
          0,
      dailyTokenCap: (json['dailyTokenCap'] as num?)?.toInt() ??
          (json['daily_token_cap'] as num?)?.toInt() ??
          (json['maxTokensPerDay'] as num?)?.toInt() ??
          30,
      nextTokenNumber: (json['nextTokenNumber'] as num?)?.toInt() ??
          (json['next_token_number'] as num?)?.toInt() ??
          1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'dayName': dayName,
      'tokensRemaining': tokensRemaining,
      'dailyTokenCap': dailyTokenCap,
      'nextTokenNumber': nextTokenNumber,
    };
  }

  factory AvailableDateModel.fromEntity(AvailableDateEntity entity) {
    return AvailableDateModel(
      date: entity.date,
      dayName: entity.dayName,
      tokensRemaining: entity.tokensRemaining,
      dailyTokenCap: entity.dailyTokenCap,
      nextTokenNumber: entity.nextTokenNumber,
    );
  }
}

/// Utility for converting and formatting times to 12-hour AM/PM throughout ClinicQ.
class TimeUtils {
  TimeUtils._();

  /// Converts a 24-hour time string (e.g. "20:30", "09:00", "14:00:00")
  /// or already formatted string to a clean 12-hour format with AM/PM.
  ///
  /// Examples:
  /// - "20:30" -> "8:30 PM"
  /// - "09:00" -> "9:00 AM"
  /// - "00:15" -> "12:15 AM"
  /// - "12:00" -> "12:00 PM"
  /// - "14:00:00" -> "2:00 PM"
  /// - "9:00 AM" -> "9:00 AM"
  static String formatTo12Hour(String? timeStr, {bool padZero = false}) {
    if (timeStr == null || timeStr.trim().isEmpty) {
      return '--';
    }

    final trimmed = timeStr.trim();

    // If it already ends with AM/PM (case-insensitive), normalize and return
    final amPmRegex = RegExp(r'^(\d{1,2}):(\d{2})(?::\d{2})?\s*(AM|PM|am|pm)$');
    final amPmMatch = amPmRegex.firstMatch(trimmed);
    if (amPmMatch != null) {
      int hour = int.tryParse(amPmMatch.group(1)!) ?? 0;
      final minute = amPmMatch.group(2)!;
      final period = amPmMatch.group(3)!.toUpperCase();
      if (hour == 0) hour = 12;
      final hourStr = padZero ? hour.toString().padLeft(2, '0') : hour.toString();
      return '$hourStr:$minute $period';
    }

    // Try parsing 24-hour format "HH:mm" or "HH:mm:ss"
    final time24Regex = RegExp(r'^(\d{1,2}):(\d{2})(?::(\d{2}))?');
    final match = time24Regex.firstMatch(trimmed);
    if (match != null) {
      final hour24 = int.tryParse(match.group(1)!) ?? 0;
      final minute = match.group(2)!.padLeft(2, '0');

      final period = hour24 >= 12 ? 'PM' : 'AM';
      var hour12 = hour24 % 12;
      if (hour12 == 0) hour12 = 12;

      final hourStr = padZero ? hour12.toString().padLeft(2, '0') : hour12.toString();
      return '$hourStr:$minute $period';
    }

    // Try parsing as ISO DateTime
    try {
      final dt = DateTime.parse(trimmed).toLocal();
      return formatDateTimeTo12Hour(dt, padZero: padZero);
    } catch (_) {}

    return trimmed;
  }

  /// Formats a time range into 12-hour AM/PM string.
  ///
  /// Examples:
  /// - formatTimeRange("09:00", "14:00") -> "9:00 AM – 2:00 PM"
  /// - formatTimeRange("20:30", "23:00") -> "8:30 PM – 11:00 PM"
  static String formatTimeRange(
    String? startTime,
    String? endTime, {
    String separator = ' – ',
    bool padZero = false,
  }) {
    if ((startTime == null || startTime.isEmpty) && (endTime == null || endTime.isEmpty)) {
      return '--';
    }
    final startFormatted = formatTo12Hour(startTime ?? '09:00', padZero: padZero);
    final endFormatted = formatTo12Hour(endTime ?? '14:00', padZero: padZero);
    return '$startFormatted$separator$endFormatted';
  }

  /// Formats a [DateTime] into a 12-hour time string with AM/PM.
  ///
  /// Example:
  /// - DateTime(2026, 10, 8, 20, 30, 15) -> "8:30 PM" (or "8:30:15 PM" if includeSeconds=true)
  static String formatDateTimeTo12Hour(
    DateTime? dateTime, {
    bool includeSeconds = false,
    bool padZero = false,
  }) {
    if (dateTime == null) return '--';

    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    var hour12 = dateTime.hour % 12;
    if (hour12 == 0) hour12 = 12;

    final hourStr = padZero ? hour12.toString().padLeft(2, '0') : hour12.toString();
    final minuteStr = dateTime.minute.toString().padLeft(2, '0');

    if (includeSeconds) {
      final secondStr = dateTime.second.toString().padLeft(2, '0');
      return '$hourStr:$minuteStr:$secondStr $period';
    }

    return '$hourStr:$minuteStr $period';
  }

  /// Formats a "Starts at HH:mm" string in 12-hour AM/PM.
  ///
  /// Example:
  /// - "20:30" -> "Starts at 8:30 PM"
  /// - "09:00" -> "Starts at 9:00 AM"
  static String formatStartsAt(String? timeStr) {
    final formatted = formatTo12Hour(timeStr ?? '09:00');
    return 'Starts at $formatted';
  }
}

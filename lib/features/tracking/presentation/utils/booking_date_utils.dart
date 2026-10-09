import 'package:clinic_q/features/doctor/domain/entities/doctor_entity.dart';
import '../../../../core/utils/time_utils.dart';

class BookingDayItem {
  final DateTime date;
  final String dayLabel; // e.g. "Tomorrow", "Saturday"
  final String shortWeekday; // e.g. "FRI", "SAT"
  final int dayNumber; // e.g. 9, 10
  final bool isWorking;
  final String
  statusText; // e.g. "22 of 30 tokens left" or "Doctor is not seeing patients"
  final int tokensLeft;
  final int totalTokens;

  const BookingDayItem({
    required this.date,
    required this.dayLabel,
    required this.shortWeekday,
    required this.dayNumber,
    required this.isWorking,
    required this.statusText,
    this.tokensLeft = 30,
    this.totalTokens = 30,
  });
}

class BookingDateUtils {
  BookingDateUtils._();

  static const List<String> weekdayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> shortWeekdayNames = [
    'MON',
    'TUE',
    'WED',
    'THU',
    'FRI',
    'SAT',
    'SUN',
  ];

  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> shortMonthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  /// Checks if the doctor is working on a specific date based on their workingDays.
  static bool isDoctorWorkingOn(DoctorEntity doctor, DateTime date) {
    if (doctor.workingDays.isEmpty) {
      // If not specified, default to working Monday to Friday (weekdays 1-5)
      return date.weekday <= 5;
    }

    final currentWeekdayName = weekdayNames[date.weekday - 1].toLowerCase();
    final currentShortWeekday = shortWeekdayNames[date.weekday - 1]
        .toLowerCase();

    for (final day in doctor.workingDays) {
      final normalized = day.trim().toLowerCase();
      if (normalized == currentWeekdayName ||
          normalized == currentShortWeekday ||
          normalized.startsWith(currentShortWeekday)) {
        return true;
      }
      // Check numeric day representations (1=Mon..7=Sun)
      if (normalized == date.weekday.toString()) {
        return true;
      }
    }
    return false;
  }

  /// Formats date for top of Today screen: "Today, Thursday 8 Oct"
  static String formatTodayHeader(DateTime date) {
    final weekday = weekdayNames[date.weekday - 1];
    final month = shortMonthNames[date.month - 1];
    return 'Today, $weekday ${date.day} $month';
  }

  /// Formats date for confirm / tracking screens: "Saturday, 10 October"
  static String formatFullDate(
    DateTime date, {
    bool includeTodayPrefix = false,
  }) {
    final now = DateTime.now();
    final isToday =
        now.year == date.year && now.month == date.month && now.day == date.day;
    final weekday = weekdayNames[date.weekday - 1];
    final month = monthNames[date.month - 1];

    if (isToday && includeTodayPrefix) {
      return 'Today, $weekday ${date.day} ${shortMonthNames[date.month - 1]}';
    }
    return '$weekday, ${date.day} $month';
  }

  /// Formats date with timing: "Thursday, 8 October · 9:00 AM – 2:00 PM"
  static String formatFullDateWithTiming(
    DateTime date,
    String? startTime,
    String? endTime,
  ) {
    final dateStr = formatFullDate(date);
    if (startTime != null && endTime != null) {
      final range = TimeUtils.formatTimeRange(startTime, endTime);
      return '$dateStr · $range';
    }
    return dateStr;
  }

  /// Generates the upcoming days list according to the user specification:
  /// Day logic: start from tomorrow. Show the next three dates on which the doctor works,
  /// skipping days they are off. If tomorrow is off, include it styled as off, and continue
  /// finding the next 3 working dates without duplicate weekdays.
  static List<BookingDayItem> getUpcomingDays(
    DoctorEntity doctor, {
    int targetWorkingDaysCount = 3,
  }) {
    final now = DateTime.now();
    final tomorrow = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(const Duration(days: 1));
    final items = <BookingDayItem>[];
    final seenWeekdays = <int>{};

    int workingDaysFound = 0;
    int dayOffset = 1; // start from tomorrow (dayOffset = 1)
    const maxSearchDays = 21;

    final maxTokens = doctor.maxTokensPerDay ?? 30;

    while (workingDaysFound < targetWorkingDaysCount &&
        dayOffset <= maxSearchDays) {
      final candidateDate = DateTime(
        now.year,
        now.month,
        now.day,
      ).add(Duration(days: dayOffset));
      final isWorking = isDoctorWorkingOn(doctor, candidateDate);
      final weekdayIndex = candidateDate.weekday; // 1..7

      final isTomorrow =
          candidateDate.year == tomorrow.year &&
          candidateDate.month == tomorrow.month &&
          candidateDate.day == tomorrow.day;

      final dayLabel = isTomorrow ? 'Tomorrow' : weekdayNames[weekdayIndex - 1];
      final shortWd = shortWeekdayNames[weekdayIndex - 1];
      final dayNum = candidateDate.day;

      if (isWorking) {
        // Only add if we haven't seen this weekday already in the 3-day set
        if (!seenWeekdays.contains(weekdayIndex)) {
          seenWeekdays.add(weekdayIndex);
          // TODO: Connect to backend for real per-day available token capacity
          final availableTokens = (maxTokens * 0.75).round();
          items.add(
            BookingDayItem(
              date: candidateDate,
              dayLabel: dayLabel,
              shortWeekday: shortWd,
              dayNumber: dayNum,
              isWorking: true,
              statusText: '$availableTokens of $maxTokens tokens left',
              tokensLeft: availableTokens,
              totalTokens: maxTokens,
            ),
          );
          workingDaysFound++;
        }
      } else {
        // If tomorrow or an immediate off day is encountered before finding the working days,
        // show it as off if it's the next day
        if (isTomorrow && !seenWeekdays.contains(weekdayIndex)) {
          seenWeekdays.add(weekdayIndex);
          items.add(
            BookingDayItem(
              date: candidateDate,
              dayLabel: dayLabel,
              shortWeekday: shortWd,
              dayNumber: dayNum,
              isWorking: false,
              statusText: 'Doctor is not seeing patients',
              tokensLeft: 0,
              totalTokens: maxTokens,
            ),
          );
        }
      }

      dayOffset++;
    }

    return items;
  }
}

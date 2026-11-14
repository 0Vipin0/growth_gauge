import 'package:flutter/material.dart';

class HeatMapColor() {
  /// Default background color of every block.
  static const Color defaultColor = Color(0xFFF8F9FA);
}

enum ColorMode() {
  opacity,
  color,
}

/// Filtering [datasets] where the key is on the same month of [referenceDate].
Map<DateTime, int> filterMonth(
  Map<DateTime, int>? datasets,
  DateTime referenceDate,
) {
  return Map.from(datasets ?? {})..removeWhere(
    (date, value) =>
        !(date.isAfter(startDayOfMonth(referenceDate)) &&
                date.isBefore(endDayOfMonth(referenceDate)) ||
            date == endDayOfMonth(referenceDate) ||
            date == startDayOfMonth(referenceDate)),
  );
}

/// Get maximum value of [datasets].
int getMaxValue(Map<DateTime, int>? datasets) {
  int result = 0;

  datasets?.forEach((date, value) {
    if (value > result) {
      result = value;
    }
  });

  return result;
}

/// Get color from [colorsets] using [dataValue].
Color? getColor(Map<int, Color>? colorsets, int? dataValue) {
  int result = 0;

  colorsets?.forEach((key, value) {
    if (key <= (dataValue ?? 0)) result = key;
  });

  return colorsets?[result];
}

const int daysInWeek = 7;

const List<String> monthLabel = [
  '',
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

const List<String> shortMonthLabel = [
  '',
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

const List<String> weekLabel = [
  '',
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

/// Get start day of month.
DateTime startDayOfMonth(DateTime referenceDate) =>
    DateTime(referenceDate.year, referenceDate.month);

/// Get last day of month.
DateTime endDayOfMonth(DateTime referenceDate) =>
    DateTime(referenceDate.year, referenceDate.month + 1, 0);

/// Get exactly one year before of [referenceDate].
DateTime oneYearBefore(DateTime referenceDate) =>
    DateTime(referenceDate.year - 1, referenceDate.month, referenceDate.day);

/// Separate [referenceDate]'s month to List of every weeks.
List<Map<DateTime, DateTime>> separatedMonth(DateTime referenceDate) {
  DateTime startDate = startDayOfMonth(referenceDate);
  DateTime endDate = DateTime(
    startDate.year,
    startDate.month,
    startDate.day + daysInWeek - startDate.weekday % daysInWeek - 1,
  );
  final DateTime finalDate = endDayOfMonth(referenceDate);
  final List<Map<DateTime, DateTime>> savedMonth = [];

  while (startDate.isBefore(finalDate) || startDate == finalDate) {
    savedMonth.add({startDate: endDate});
    startDate = changeDay(endDate, 1);
    endDate = changeDay(
      endDate,
      endDayOfMonth(endDate).day - startDate.day >= daysInWeek
          ? daysInWeek
          : endDayOfMonth(endDate).day - startDate.day + 1,
    );
  }
  return savedMonth;
}

/// Change day of [referenceDate].
DateTime changeDay(DateTime referenceDate, int dayCount) => DateTime(
  referenceDate.year,
  referenceDate.month,
  referenceDate.day + dayCount,
);

/// Change month of [referenceDate].
DateTime changeMonth(DateTime referenceDate, int monthCount) => DateTime(
  referenceDate.year,
  referenceDate.month + monthCount,
  referenceDate.day,
);

/// Make [HeatMapContainer] flexible size if [isFlexible] is true.
Widget flexibleContainer(bool isFlexible, bool isSquare, Widget child) {
  return isFlexible
      ? Expanded(
          child: isSquare ? AspectRatio(aspectRatio: 1, child: child) : child,
        )
      : child;
}

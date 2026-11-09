import 'package:flutter/material.dart';

class HeatMapColor() {
  /// Default background color of every block.
  static const Color defaultColor = Color(0xFFF8F9FA);
}

enum ColorMode() {
  opacity,
  color,
}

class DatasetsUtil() {
  /// Filtering [datasets] where the key is on the same month of [referenceDate].
  static Map<DateTime, int> filterMonth(
    Map<DateTime, int>? datasets,
    DateTime referenceDate,
  ) {
    return Map.from(datasets ?? {})..removeWhere(
      (date, value) =>
          !(date.isAfter(DateUtil.startDayOfMonth(referenceDate)) &&
                  date.isBefore(DateUtil.endDayOfMonth(referenceDate)) ||
              date == DateUtil.endDayOfMonth(referenceDate) ||
              date == DateUtil.startDayOfMonth(referenceDate)),
    );
  }

  /// Get maximum value of [datasets].
  static int getMaxValue(Map<DateTime, int>? datasets) {
    int result = 0;

    datasets?.forEach((date, value) {
      if (value > result) {
        result = value;
      }
    });

    return result;
  }

  /// Get color from [colorsets] using [dataValue].
  static Color? getColor(Map<int, Color>? colorsets, int? dataValue) {
    int result = 0;

    colorsets?.forEach((key, value) {
      if (key <= (dataValue ?? 0)) result = key;
    });

    return colorsets?[result];
  }
}

class DateUtil() {
  static const int DAYS_IN_WEEK = 7;

  static const List<String> MONTH_LABEL = [
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

  static const List<String> SHORT_MONTH_LABEL = [
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

  static const List<String> WEEK_LABEL = [
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
  static DateTime startDayOfMonth(DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month);

  /// Get last day of month.
  static DateTime endDayOfMonth(DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month + 1, 0);

  /// Get exactly one year before of [referenceDate].
  static DateTime oneYearBefore(DateTime referenceDate) =>
      DateTime(referenceDate.year - 1, referenceDate.month, referenceDate.day);

  /// Separate [referenceDate]'s month to List of every weeks.
  static List<Map<DateTime, DateTime>> separatedMonth(DateTime referenceDate) {
    DateTime startDate = startDayOfMonth(referenceDate);
    DateTime endDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day + DAYS_IN_WEEK - startDate.weekday % DAYS_IN_WEEK - 1,
    );
    final DateTime finalDate = endDayOfMonth(referenceDate);
    final List<Map<DateTime, DateTime>> savedMonth = [];

    while (startDate.isBefore(finalDate) || startDate == finalDate) {
      savedMonth.add({startDate: endDate});
      startDate = changeDay(endDate, 1);
      endDate = changeDay(
        endDate,
        endDayOfMonth(endDate).day - startDate.day >= DAYS_IN_WEEK
            ? DAYS_IN_WEEK
            : endDayOfMonth(endDate).day - startDate.day + 1,
      );
    }
    return savedMonth;
  }

  /// Change day of [referenceDate].
  static DateTime changeDay(DateTime referenceDate, int dayCount) => DateTime(
    referenceDate.year,
    referenceDate.month,
    referenceDate.day + dayCount,
  );

  /// Change month of [referenceDate].
  static DateTime changeMonth(DateTime referenceDate, int monthCount) =>
      DateTime(
        referenceDate.year,
        referenceDate.month + monthCount,
        referenceDate.day,
      );
}

class WidgetUtil() {
  /// Make [HeatMapContainer] flexible size if [isFlexible] is true.
  static Widget flexibleContainer(
    bool isFlexible,
    bool isSquare,
    Widget child,
  ) {
    return isFlexible
        ? Expanded(
            child: isSquare ? AspectRatio(aspectRatio: 1, child: child) : child,
          )
        : child;
  }
}

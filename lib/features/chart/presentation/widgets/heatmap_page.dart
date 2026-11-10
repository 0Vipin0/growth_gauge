import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/heatmap_utils.dart';
import 'heatmap_column.dart';
import 'heatmap_month_text.dart';
import 'heatmap_week_text.dart';

class const HeatMapPage({
  super.key,

  /// ColorMode changes the color mode of blocks.
  ///
  /// [ColorMode.opacity] requires just one colorsets value and changes color
  /// dynamically based on hightest value of [datasets].
  /// [ColorMode.color] changes colors based on [colorsets] thresholds key value.
  required final ColorMode colorMode,

  /// The Date value of start day of heatmap.
  ///
  /// HeatMap shows the start day of [startDate]'s week.
  ///
  /// Default value is 1 year before the [endDate].
  /// And if [endDate] is null, then set 1 year before the [DateTime.now]
  required final DateTime startDate,

  /// The Date value of end day of heatmap.
  ///
  /// Default value is [DateTime.now]
  required final DateTime endDate,

  /// The double value of every block's width and height.
  final double? size,

  /// The double value of every block's fontSize.
  final double? fontSize,

  /// The datasets which fill blocks based on its value.
  final Map<DateTime, int>? datasets,

  /// The default background color value of every blocks.
  final Color? defaultColor,

  /// The text color value of every blocks.
  final Color? textColor,

  /// The colorsets which give the color value for its thresholds key value.
  ///
  /// Be aware that first Color is the maximum value if [ColorMode] is [ColorMode.opacity].
  final Map<int, Color>? colorsets,

  /// The double value of every block's borderRadius.
  final double? borderRadius,

  /// Function that will be called when a block is clicked.
  ///
  /// Paratmeter gives clicked [DateTime] value.
  final Function(DateTime)? onClick,

  /// The margin value for every block.
  final EdgeInsets? margin,
  final bool? showText,
}) extends StatelessWidget {
  /// List value of every sunday's month information.
  ///
  /// From 1: January to 12: December.
  final List<int> _firstDayInfos = [];

  /// The number of days between [startDate] and [endDate].
  final int _dateDifferent = endDate.difference(startDate).inDays;

  /// The integer value of the maximum value for the [datasets].
  ///
  /// Get highest key value of filtered datasets using [DatasetsUtil.getMaxValue].
  final int? maxValue = DatasetsUtil.getMaxValue(datasets);

  /// Get [HeatMapColumn] from [startDate] to [endDate].
  List<Widget> _heatmapColumnList() {
    // Create empty list.
    final List<Widget> columns = [];

    // Set cursor(position) to first day of weeks
    // until cursor reaches the final week.
    for (
      int datePos = 0 - (startDate.weekday % 7);
      datePos <= _dateDifferent;
      datePos += 7
    ) {
      // Get first day of week by adding cursor's value to startDate.
      final DateTime firstDay = DateUtil.changeDay(startDate, datePos);

      columns.add(
        HeatMapColumn(
          // If last day is not saturday, week also includes future Date.
          // So we have to make future day on last column blanck.
          //
          // To make empty space to future day, we have to pass this HeatMapPage's
          // endDate to HeatMapColumn's endDate.
          startDate: firstDay,
          endDate: datePos <= _dateDifferent - 7
              ? DateUtil.changeDay(startDate, datePos + 6)
              : endDate,
          colorMode: colorMode,
          numDays: min(endDate.difference(firstDay).inDays + 1, 7),
          size: size,
          fontSize: fontSize,
          defaultColor: defaultColor,
          colorsets: colorsets,
          textColor: textColor,
          borderRadius: borderRadius,
          margin: margin,
          maxValue: maxValue,
          onClick: onClick,
          datasets: datasets,
          showText: showText,
        ),
      );

      // also add first day's month information to _firstDayInfos list.
      _firstDayInfos.add(firstDay.month);
    }

    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Show week labels to left side of heatmap.
            HeatMapWeekText(
              margin: margin,
              fontSize: fontSize,
              size: size,
              fontColor: textColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show month labels to top of heatmap.
                HeatMapMonthText(
                  firstDayInfos: _firstDayInfos,
                  margin: margin,
                  fontSize: fontSize,
                  fontColor: textColor,
                  size: size,
                ),

                // Heatmap itself.
                Row(children: <Widget>[..._heatmapColumnList()]),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

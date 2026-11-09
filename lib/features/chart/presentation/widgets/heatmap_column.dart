import 'package:flutter/material.dart';

import 'heatmap_container.dart';
import 'heatmap_utils.dart';

class HeatMapColumn({
  super.key,

  /// The date value of first day of given week.
  required final DateTime startDate,

  /// The date value of last day of given week.
  required final DateTime endDate,

  /// ColorMode changes the color mode of blocks.
  ///
  /// [ColorMode.opacity] requires just one colorsets value and changes color
  /// dynamically based on hightest value of [datasets].
  /// [ColorMode.color] changes colors based on [colorsets] thresholdsc key value.
  required final ColorMode colorMode,
  required final int numDays,

  /// The double value of every [HeatMapContainer]'s width and height.
  final double? size,

  /// The double value of every [HeatMapContainer]'s fontSize.
  final double? fontSize,

  /// The default background color value of [HeatMapContainer].
  final Color? defaultColor,

  /// The datasets which fill blocks based on its value.
  ///
  /// datasets keys have to greater or equal to [startDate] and
  /// smaller or equal to [endDate].
  final Map<DateTime, int>? datasets,

  /// The text color value of [HeatMapContainer].
  final Color? textColor,

  /// The double value of [HeatMapContainer]'s borderRadius.
  final double? borderRadius,

  /// The margin value for every block.
  final EdgeInsets? margin,

  /// The colorsets which give the color value for its thresholds key value.
  ///
  /// Be aware that first Color is the maximum value if [ColorMode] is [ColorMode.opacity].
  final Map<int, Color>? colorsets,

  /// Function that will be called when a block is clicked.
  ///
  /// Paratmeter gives clicked [DateTime] value.
  final Function(DateTime)? onClick,

  /// The integer value of the maximum value for the highest value of the month.
  final int? maxValue,

  /// Show day text in every blocks if the value is true.
  final bool? showText,
}) extends StatelessWidget {
  /// The List widgets of [HeatMapContainer].
  ///
  /// It includes every days of the week and
  /// if one week doesn't have 7 days, it will be filled with empty [Container].
  final List<Widget> dayContainers = List.generate(
    numDays,
    (i) => HeatMapContainer(
      date: DateUtil.changeDay(startDate, i),
      backgroundColor: defaultColor,
      size: size,
      fontSize: fontSize,
      textColor: textColor,
      borderRadius: borderRadius,
      margin: margin,
      onClick: onClick,
      showText: showText,
      // If datasets has DateTime key which is equal to this HeatMapContainer's date,
      // we have to color the matched HeatMapContainer.
      //
      // If datasets is null or doesn't contains the equal DateTime value, send null.
      selectedColor:
          datasets?.keys.contains(
                DateTime(
                  startDate.year,
                  startDate.month,
                  startDate.day - startDate.weekday % 7 + i,
                ),
              ) ??
              false
          // If colorMode is ColorMode.opacity,
          ? colorMode == ColorMode.opacity
                // Color the container with first value of colorsets
                // and set opacity value to current day's datasets key
                // devided by maxValue which is the maximum value of the month.
                ? colorsets?.values.first.withValues(
                    alpha:
                        (datasets?[DateTime(
                              startDate.year,
                              startDate.month,
                              startDate.day + i - (startDate.weekday % 7),
                            )] ??
                            1) /
                        (maxValue ?? 1),
                  )
                // Else if colorMode is ColorMode.Color.
                //
                // Get color value from colorsets which is filtered with DateTime value
                // Using DatasetsUtil.getColor()
                : DatasetsUtil.getColor(
                    colorsets,
                    datasets?[DateTime(
                      startDate.year,
                      startDate.month,
                      startDate.day + i - (startDate.weekday % 7),
                    )],
                  )
          : null,
    ),
  );

  /// The List widgets of empty [Container].
  ///
  /// It only processes when given week's length is not 7.
  final List<Widget> emptySpace = (numDays != 7)
      ? List.generate(
          7 - numDays,
          (i) => Container(
            margin: margin ?? const EdgeInsets.all(2),
            width: size ?? 42,
            height: size ?? 42,
          ),
        )
      : [];

  // The number of day blocks to draw. This should be seven for all but the
  // current week.

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[...dayContainers, ...emptySpace]);
  }
}

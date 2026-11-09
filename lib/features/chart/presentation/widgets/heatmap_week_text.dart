import 'package:flutter/material.dart';

import 'heatmap_utils.dart';

class const HeatMapWeekText({
  super.key,

  /// The margin value for correctly space between labels.
  final EdgeInsets? margin,

  /// The double value of label's font size.
  final double? fontSize,

  /// The double value of every block's size to fit the height.
  final double? size,

  /// The color value of every font's color.
  final Color? fontColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final String label in DateUtil.WEEK_LABEL)
          Container(
            height: size ?? 20,
            margin: margin ?? const EdgeInsets.all(2.0),
            child: Text(
              label,
              style: TextStyle(fontSize: fontSize ?? 12, color: fontColor),
            ),
          ),
      ],
    );
  }
}

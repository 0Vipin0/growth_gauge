import 'dart:collection';

import 'package:flutter/material.dart';

import '../utils/heatmap_utils.dart';

class const HeatMapColorTip({
  super.key,

  /// ColorMode changes the color mode of blocks.
  /// ColorMode changes the color mode of blocks.
  ///
  /// [ColorMode.opacity] requires just one colorsets value and changes color
  /// [ColorMode.color] changes colors based on [colorsets] thresholds key value.
  required final ColorMode colorMode,

  /// The colorsets which give the color value for its thresholds key value.
  ///
  /// Be aware that first Color is the maximum value if [ColorMode] is [ColorMode.opacity].
  this.colorsets,

  /// The widget which shows left side of [HeatMapColorTip].
  ///
  /// If the value is null then show default 'less' [Text].
  this.leftWidget,

  /// The widget which shows right side of [HeatMapColorTip].
  ///
  /// If the value is null then show default 'more' [Text].
  this.rightWidget,

  /// The integer value of color tip containers count.
  this.containerCount,

  /// The double value of tip container's size.
  this.size,
}) extends StatelessWidget {
  /// The colorsets which give the color value for its thresholds key value.
  final Map<int, Color>? colorsets;

  /// The widget which shows left side of [HeatMapColorTip].
  final Widget? leftWidget;

  /// The widget which shows right side of [HeatMapColorTip].
  final Widget? rightWidget;

  /// The integer value of color tip containers count.
  final int? containerCount;

  /// The double value of tip container's size.
  final double? size;

  /// Default length of [containerCount].
  static const int _defaultLength = 7;

  /// It returns the List of tip container.
  ///
  /// If [ColorMode.color], call [_heatmapListColor]
  /// If [ColorMode.opacity], call [_heatmapListOpacity]
  List<Widget> _heatmapList() => colorMode == ColorMode.color
      ? _heatmapListColor()
      : _heatmapListOpacity();

  /// Evenly show every colors from lowest to highest.
  List<Widget> _heatmapListColor() {
    final List<Widget> children = [];
    final SplayTreeMap<int, Color> sortedColorset =
        SplayTreeMap<int, Color>.from(
          colorsets ?? {},
          (a, b) => a > b ? 1 : -1,
        );

    for (int i = 0; i < (containerCount ?? _defaultLength); i++) {
      children.add(
        _tipContainer(
          sortedColorset.values.elementAt(
            (sortedColorset.length / (containerCount ?? _defaultLength) * i)
                .floor(),
          ),
        ),
      );
    }

    return children;
  }

  /// Evenly show every colors from transparent to non-transparent.
  List<Widget> _heatmapListOpacity() {
    final List<Widget> children = [];

    for (int i = 0; i < (containerCount ?? _defaultLength); i++) {
      children.add(
        _tipContainer(
          colorsets?.values.first.withValues(
                alpha: i / (containerCount ?? _defaultLength),
              ) ??
              Colors.white,
        ),
      );
    }
    return children;
  }

  /// Container which is colored by [color].
  Widget _tipContainer(Color color) {
    return ColoredBox(
      color: HeatMapColor.defaultColor,
      child: Container(width: size ?? 10, height: size ?? 10, color: color),
    );
  }

  /// Default text widget.
  Widget _defaultText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: size ?? 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          leftWidget ?? _defaultText('less'),
          ..._heatmapList(),
          rightWidget ?? _defaultText('more'),
        ],
      ),
    );
  }
}

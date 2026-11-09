import 'package:flutter/material.dart';

import 'heatmap_utils.dart';

class const HeatMapContainer({
  super.key,
  required final DateTime date,
  final EdgeInsets? margin,
  final double? size,
  final double? fontSize,
  final double? borderRadius,
  final Color? backgroundColor,
  final Color? selectedColor,
  final Color? textColor,
  final Function(DateTime dateTime)? onClick,
  final bool? showText,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? HeatMapColor.defaultColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutQuad,
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedColor,
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius ?? 5),
              ),
            ),
            child: (showText ?? true)
                ? Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: textColor ?? const Color(0xFF8A8A8A),
                      fontSize: fontSize,
                    ),
                  )
                : null,
          ),
        ),
        onTap: () {
          onClick != null ? onClick!(date) : null;
        },
      ),
    );
  }
}

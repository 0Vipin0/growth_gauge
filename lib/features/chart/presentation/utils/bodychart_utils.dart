import 'package:flutter/material.dart';

extension HexColor on Color {
  String toHex({bool leadingHashSign = true, bool withAlpha = false}) {
    final buffer = StringBuffer();
    if (leadingHashSign) buffer.write('#');

    if (withAlpha) {
      final alphaValue = (a * 255.0).round().clamp(0, 255);
      buffer.write(alphaValue.toRadixString(16).padLeft(2, '0'));
    }

    final redValue = (r * 255.0).round().clamp(0, 255);
    final greenValue = (g * 255.0).round().clamp(0, 255);
    final blueValue = (b * 255.0).round().clamp(0, 255);

    buffer
      ..write(redValue.toRadixString(16).padLeft(2, '0'))
      ..write(greenValue.toRadixString(16).padLeft(2, '0'))
      ..write(blueValue.toRadixString(16).padLeft(2, '0'));

    return buffer.toString().toUpperCase();
  }
}

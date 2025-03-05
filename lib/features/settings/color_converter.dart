import 'package:flutter/painting.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter extends JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) {
    // Convert hex color string to Color object
    return Color(int.parse(json, radix: 16)).withOpacity(1.0);
  }

  @override
  String toJson(Color object) {
    // Convert Color object to hex color string
    return object.value.toRadixString(16).padLeft(8, '0');
  }
}

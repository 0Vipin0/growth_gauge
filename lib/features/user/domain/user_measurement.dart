import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_enums.dart';

part 'user_measurement.freezed.dart';
part 'user_measurement.g.dart';

/// Immutable time-series physical body measurement record.
///
/// Measurements are append-only historical facts stored in canonical metric units
/// (kg for weight, cm for circumferences, percentage for body fat).
@freezed
abstract class UserMeasurement with _$UserMeasurement {
  const factory({
    required String id,
    required String userId,
    required MeasurementType type,
    required double value,
    required String unit,
    required DateTime recordedAt,
    @Default('manual') String source,
    String? notes,
  }) = _UserMeasurement;

  factory fromJson(Map<String, dynamic> json) =>
      _$UserMeasurementFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/units/unit_types.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// User identity and presentation preferences.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory({
    required String userId,
    @Default('Athlete') String displayName,
    @Default('') String firstName,
    @Default('') String lastName,
    DateTime? dateOfBirth,
    String? profileImageId,
    @Default('UTC') String timezone,
    @Default('en') String locale,
    @Default(WeightUnit.kilograms) WeightUnit weightUnit,
    @Default(DistanceUnit.kilometers) DistanceUnit distanceUnit,
    @Default(HeightUnit.centimeters) HeightUnit heightUnit,
    @Default(TemperatureUnit.celsius) TemperatureUnit temperatureUnit,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserProfile;

  factory fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

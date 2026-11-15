// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => _UserProfile(
  userId: json['userId'] as String,
  displayName: json['displayName'] as String? ?? 'Athlete',
  firstName: json['firstName'] as String? ?? '',
  lastName: json['lastName'] as String? ?? '',
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
  profileImageId: json['profileImageId'] as String?,
  timezone: json['timezone'] as String? ?? 'UTC',
  locale: json['locale'] as String? ?? 'en',
  weightUnit:
      $enumDecodeNullable(_$WeightUnitEnumMap, json['weightUnit']) ??
      WeightUnit.kilograms,
  distanceUnit:
      $enumDecodeNullable(_$DistanceUnitEnumMap, json['distanceUnit']) ??
      DistanceUnit.kilometers,
  heightUnit:
      $enumDecodeNullable(_$HeightUnitEnumMap, json['heightUnit']) ??
      HeightUnit.centimeters,
  temperatureUnit:
      $enumDecodeNullable(_$TemperatureUnitEnumMap, json['temperatureUnit']) ??
      TemperatureUnit.celsius,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserProfileToJson(_UserProfile instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'displayName': instance.displayName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'profileImageId': instance.profileImageId,
      'timezone': instance.timezone,
      'locale': instance.locale,
      'weightUnit': _$WeightUnitEnumMap[instance.weightUnit]!,
      'distanceUnit': _$DistanceUnitEnumMap[instance.distanceUnit]!,
      'heightUnit': _$HeightUnitEnumMap[instance.heightUnit]!,
      'temperatureUnit': _$TemperatureUnitEnumMap[instance.temperatureUnit]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$WeightUnitEnumMap = {
  WeightUnit.kilograms: 'kilograms',
  WeightUnit.pounds: 'pounds',
};

const _$DistanceUnitEnumMap = {
  DistanceUnit.meters: 'meters',
  DistanceUnit.kilometers: 'kilometers',
  DistanceUnit.miles: 'miles',
};

const _$HeightUnitEnumMap = {
  HeightUnit.centimeters: 'centimeters',
  HeightUnit.feetAndInches: 'feetAndInches',
};

const _$TemperatureUnitEnumMap = {
  TemperatureUnit.celsius: 'celsius',
  TemperatureUnit.fahrenheit: 'fahrenheit',
};

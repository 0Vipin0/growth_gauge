// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfile {

 String get userId; String get displayName; String get firstName; String get lastName; DateTime? get dateOfBirth; String? get profileImageId; String get timezone; String get locale; WeightUnit get weightUnit; DistanceUnit get distanceUnit; HeightUnit get heightUnit; TemperatureUnit get temperatureUnit; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileCopyWith<UserProfile> get copyWith => _$UserProfileCopyWithImpl<UserProfile>(this as UserProfile, _$identity);

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfile&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.dateOfBirth, _this.dateOfBirth) || other.dateOfBirth == _this.dateOfBirth)&&(identical(other.profileImageId, _this.profileImageId) || other.profileImageId == _this.profileImageId)&&(identical(other.timezone, _this.timezone) || other.timezone == _this.timezone)&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.weightUnit, _this.weightUnit) || other.weightUnit == _this.weightUnit)&&(identical(other.distanceUnit, _this.distanceUnit) || other.distanceUnit == _this.distanceUnit)&&(identical(other.heightUnit, _this.heightUnit) || other.heightUnit == _this.heightUnit)&&(identical(other.temperatureUnit, _this.temperatureUnit) || other.temperatureUnit == _this.temperatureUnit)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserProfile;
  return Object.hash(runtimeType,_this.userId,_this.displayName,_this.firstName,_this.lastName,_this.dateOfBirth,_this.profileImageId,_this.timezone,_this.locale,_this.weightUnit,_this.distanceUnit,_this.heightUnit,_this.temperatureUnit,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as UserProfile;
  return 'UserProfile(userId: ${_this.userId}, displayName: ${_this.displayName}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, dateOfBirth: ${_this.dateOfBirth}, profileImageId: ${_this.profileImageId}, timezone: ${_this.timezone}, locale: ${_this.locale}, weightUnit: ${_this.weightUnit}, distanceUnit: ${_this.distanceUnit}, heightUnit: ${_this.heightUnit}, temperatureUnit: ${_this.temperatureUnit}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $UserProfileCopyWith<$Res>  {
  factory $UserProfileCopyWith(UserProfile value, $Res Function(UserProfile) _then) = _$UserProfileCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String firstName, String lastName, DateTime? dateOfBirth, String? profileImageId, String timezone, String locale, WeightUnit weightUnit, DistanceUnit distanceUnit, HeightUnit heightUnit, TemperatureUnit temperatureUnit, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$UserProfileCopyWithImpl<$Res>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._self, this._then);

  final UserProfile _self;
  final $Res Function(UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? firstName = null,Object? lastName = null,Object? dateOfBirth = freezed,Object? profileImageId = freezed,Object? timezone = null,Object? locale = null,Object? weightUnit = null,Object? distanceUnit = null,Object? heightUnit = null,Object? temperatureUnit = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(UserProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,profileImageId: freezed == profileImageId ? _self.profileImageId : profileImageId // ignore: cast_nullable_to_non_nullable
as String?,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,weightUnit: null == weightUnit ? _self.weightUnit : weightUnit // ignore: cast_nullable_to_non_nullable
as WeightUnit,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as DistanceUnit,heightUnit: null == heightUnit ? _self.heightUnit : heightUnit // ignore: cast_nullable_to_non_nullable
as HeightUnit,temperatureUnit: null == temperatureUnit ? _self.temperatureUnit : temperatureUnit // ignore: cast_nullable_to_non_nullable
as TemperatureUnit,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfile].
extension UserProfilePatterns on UserProfile {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfile value)  $default,){
final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfile value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String firstName,  String lastName,  DateTime? dateOfBirth,  String? profileImageId,  String timezone,  String locale,  WeightUnit weightUnit,  DistanceUnit distanceUnit,  HeightUnit heightUnit,  TemperatureUnit temperatureUnit,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.firstName,_that.lastName,_that.dateOfBirth,_that.profileImageId,_that.timezone,_that.locale,_that.weightUnit,_that.distanceUnit,_that.heightUnit,_that.temperatureUnit,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String firstName,  String lastName,  DateTime? dateOfBirth,  String? profileImageId,  String timezone,  String locale,  WeightUnit weightUnit,  DistanceUnit distanceUnit,  HeightUnit heightUnit,  TemperatureUnit temperatureUnit,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfile():
return $default(_that.userId,_that.displayName,_that.firstName,_that.lastName,_that.dateOfBirth,_that.profileImageId,_that.timezone,_that.locale,_that.weightUnit,_that.distanceUnit,_that.heightUnit,_that.temperatureUnit,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String firstName,  String lastName,  DateTime? dateOfBirth,  String? profileImageId,  String timezone,  String locale,  WeightUnit weightUnit,  DistanceUnit distanceUnit,  HeightUnit heightUnit,  TemperatureUnit temperatureUnit,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfile() when $default != null:
return $default(_that.userId,_that.displayName,_that.firstName,_that.lastName,_that.dateOfBirth,_that.profileImageId,_that.timezone,_that.locale,_that.weightUnit,_that.distanceUnit,_that.heightUnit,_that.temperatureUnit,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfile implements UserProfile {
  const _UserProfile({required this.userId, this.displayName = 'Athlete', this.firstName = '', this.lastName = '', this.dateOfBirth, this.profileImageId, this.timezone = 'UTC', this.locale = 'en', this.weightUnit = WeightUnit.kilograms, this.distanceUnit = DistanceUnit.kilometers, this.heightUnit = HeightUnit.centimeters, this.temperatureUnit = TemperatureUnit.celsius, required this.createdAt, required this.updatedAt});
  factory _UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

@override final  String userId;
@override@JsonKey() final  String displayName;
@override@JsonKey() final  String firstName;
@override@JsonKey() final  String lastName;
@override final  DateTime? dateOfBirth;
@override final  String? profileImageId;
@override@JsonKey() final  String timezone;
@override@JsonKey() final  String locale;
@override@JsonKey() final  WeightUnit weightUnit;
@override@JsonKey() final  DistanceUnit distanceUnit;
@override@JsonKey() final  HeightUnit heightUnit;
@override@JsonKey() final  TemperatureUnit temperatureUnit;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileCopyWith<_UserProfile> get copyWith => __$UserProfileCopyWithImpl<_UserProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfile&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.profileImageId, profileImageId) || other.profileImageId == profileImageId)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.weightUnit, weightUnit) || other.weightUnit == weightUnit)&&(identical(other.distanceUnit, distanceUnit) || other.distanceUnit == distanceUnit)&&(identical(other.heightUnit, heightUnit) || other.heightUnit == heightUnit)&&(identical(other.temperatureUnit, temperatureUnit) || other.temperatureUnit == temperatureUnit)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,displayName,firstName,lastName,dateOfBirth,profileImageId,timezone,locale,weightUnit,distanceUnit,heightUnit,temperatureUnit,createdAt,updatedAt);
}

@override
String toString() {
    return 'UserProfile(userId: $userId, displayName: $displayName, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, profileImageId: $profileImageId, timezone: $timezone, locale: $locale, weightUnit: $weightUnit, distanceUnit: $distanceUnit, heightUnit: $heightUnit, temperatureUnit: $temperatureUnit, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileCopyWith<$Res> implements $UserProfileCopyWith<$Res> {
  factory _$UserProfileCopyWith(_UserProfile value, $Res Function(_UserProfile) _then) = __$UserProfileCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String firstName, String lastName, DateTime? dateOfBirth, String? profileImageId, String timezone, String locale, WeightUnit weightUnit, DistanceUnit distanceUnit, HeightUnit heightUnit, TemperatureUnit temperatureUnit, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$UserProfileCopyWithImpl<$Res>
    implements _$UserProfileCopyWith<$Res> {
  __$UserProfileCopyWithImpl(this._self, this._then);

  final _UserProfile _self;
  final $Res Function(_UserProfile) _then;

/// Create a copy of UserProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? firstName = null,Object? lastName = null,Object? dateOfBirth = freezed,Object? profileImageId = freezed,Object? timezone = null,Object? locale = null,Object? weightUnit = null,Object? distanceUnit = null,Object? heightUnit = null,Object? temperatureUnit = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_UserProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,profileImageId: freezed == profileImageId ? _self.profileImageId : profileImageId // ignore: cast_nullable_to_non_nullable
as String?,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,weightUnit: null == weightUnit ? _self.weightUnit : weightUnit // ignore: cast_nullable_to_non_nullable
as WeightUnit,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as DistanceUnit,heightUnit: null == heightUnit ? _self.heightUnit : heightUnit // ignore: cast_nullable_to_non_nullable
as HeightUnit,temperatureUnit: null == temperatureUnit ? _self.temperatureUnit : temperatureUnit // ignore: cast_nullable_to_non_nullable
as TemperatureUnit,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

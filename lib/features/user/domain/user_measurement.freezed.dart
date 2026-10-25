// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_measurement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserMeasurement {

 String get id; String get userId; MeasurementType get type; double get value; String get unit; DateTime get recordedAt; String get source; String? get notes;
/// Create a copy of UserMeasurement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMeasurementCopyWith<UserMeasurement> get copyWith => _$UserMeasurementCopyWithImpl<UserMeasurement>(this as UserMeasurement, _$identity);

  /// Serializes this UserMeasurement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserMeasurement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMeasurement&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.value, _this.value) || other.value == _this.value)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.recordedAt, _this.recordedAt) || other.recordedAt == _this.recordedAt)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserMeasurement;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.type,_this.value,_this.unit,_this.recordedAt,_this.source,_this.notes);
}

@override
String toString() {
  final _this = this as UserMeasurement;
  return 'UserMeasurement(id: ${_this.id}, userId: ${_this.userId}, type: ${_this.type}, value: ${_this.value}, unit: ${_this.unit}, recordedAt: ${_this.recordedAt}, source: ${_this.source}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $UserMeasurementCopyWith<$Res>  {
  factory $UserMeasurementCopyWith(UserMeasurement value, $Res Function(UserMeasurement) _then) = _$UserMeasurementCopyWithImpl;
@useResult
$Res call({
 String id, String userId, MeasurementType type, double value, String unit, DateTime recordedAt, String source, String? notes
});




}
/// @nodoc
class _$UserMeasurementCopyWithImpl<$Res>
    implements $UserMeasurementCopyWith<$Res> {
  _$UserMeasurementCopyWithImpl(this._self, this._then);

  final UserMeasurement _self;
  final $Res Function(UserMeasurement) _then;

/// Create a copy of UserMeasurement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? value = null,Object? unit = null,Object? recordedAt = null,Object? source = null,Object? notes = freezed,}) {
  return _then(UserMeasurement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MeasurementType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserMeasurement].
extension UserMeasurementPatterns on UserMeasurement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMeasurement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMeasurement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMeasurement value)  $default,){
final _that = this;
switch (_that) {
case _UserMeasurement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMeasurement value)?  $default,){
final _that = this;
switch (_that) {
case _UserMeasurement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  MeasurementType type,  double value,  String unit,  DateTime recordedAt,  String source,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMeasurement() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.value,_that.unit,_that.recordedAt,_that.source,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  MeasurementType type,  double value,  String unit,  DateTime recordedAt,  String source,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _UserMeasurement():
return $default(_that.id,_that.userId,_that.type,_that.value,_that.unit,_that.recordedAt,_that.source,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  MeasurementType type,  double value,  String unit,  DateTime recordedAt,  String source,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _UserMeasurement() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.value,_that.unit,_that.recordedAt,_that.source,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserMeasurement implements UserMeasurement {
  const _UserMeasurement({required this.id, required this.userId, required this.type, required this.value, required this.unit, required this.recordedAt, this.source = 'manual', this.notes});
  factory _UserMeasurement.fromJson(Map<String, dynamic> json) => _$UserMeasurementFromJson(json);

@override final  String id;
@override final  String userId;
@override final  MeasurementType type;
@override final  double value;
@override final  String unit;
@override final  DateTime recordedAt;
@override@JsonKey() final  String source;
@override final  String? notes;

/// Create a copy of UserMeasurement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMeasurementCopyWith<_UserMeasurement> get copyWith => __$UserMeasurementCopyWithImpl<_UserMeasurement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMeasurementToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMeasurement&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.recordedAt, recordedAt) || other.recordedAt == recordedAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,type,value,unit,recordedAt,source,notes);
}

@override
String toString() {
    return 'UserMeasurement(id: $id, userId: $userId, type: $type, value: $value, unit: $unit, recordedAt: $recordedAt, source: $source, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$UserMeasurementCopyWith<$Res> implements $UserMeasurementCopyWith<$Res> {
  factory _$UserMeasurementCopyWith(_UserMeasurement value, $Res Function(_UserMeasurement) _then) = __$UserMeasurementCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, MeasurementType type, double value, String unit, DateTime recordedAt, String source, String? notes
});




}
/// @nodoc
class __$UserMeasurementCopyWithImpl<$Res>
    implements _$UserMeasurementCopyWith<$Res> {
  __$UserMeasurementCopyWithImpl(this._self, this._then);

  final _UserMeasurement _self;
  final $Res Function(_UserMeasurement) _then;

/// Create a copy of UserMeasurement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? value = null,Object? unit = null,Object? recordedAt = null,Object? source = null,Object? notes = freezed,}) {
  return _then(_UserMeasurement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MeasurementType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,recordedAt: null == recordedAt ? _self.recordedAt : recordedAt // ignore: cast_nullable_to_non_nullable
as DateTime,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

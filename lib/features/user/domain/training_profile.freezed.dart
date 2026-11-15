// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingProfile {

 String get userId; TrainingExperience get trainingExperience; String get primaryTrainingStyle; int get preferredSessionDurationMinutes; List<int> get preferredTrainingDays; String get notes; DateTime get updatedAt;
/// Create a copy of TrainingProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingProfileCopyWith<TrainingProfile> get copyWith => _$TrainingProfileCopyWithImpl<TrainingProfile>(this as TrainingProfile, _$identity);

  /// Serializes this TrainingProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TrainingProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingProfile&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.trainingExperience, _this.trainingExperience) || other.trainingExperience == _this.trainingExperience)&&(identical(other.primaryTrainingStyle, _this.primaryTrainingStyle) || other.primaryTrainingStyle == _this.primaryTrainingStyle)&&(identical(other.preferredSessionDurationMinutes, _this.preferredSessionDurationMinutes) || other.preferredSessionDurationMinutes == _this.preferredSessionDurationMinutes)&&const DeepCollectionEquality().equals(other.preferredTrainingDays, _this.preferredTrainingDays)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TrainingProfile;
  return Object.hash(runtimeType,_this.userId,_this.trainingExperience,_this.primaryTrainingStyle,_this.preferredSessionDurationMinutes,const DeepCollectionEquality().hash(_this.preferredTrainingDays),_this.notes,_this.updatedAt);
}

@override
String toString() {
  final _this = this as TrainingProfile;
  return 'TrainingProfile(userId: ${_this.userId}, trainingExperience: ${_this.trainingExperience}, primaryTrainingStyle: ${_this.primaryTrainingStyle}, preferredSessionDurationMinutes: ${_this.preferredSessionDurationMinutes}, preferredTrainingDays: ${_this.preferredTrainingDays}, notes: ${_this.notes}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $TrainingProfileCopyWith<$Res>  {
  factory $TrainingProfileCopyWith(TrainingProfile value, $Res Function(TrainingProfile) _then) = _$TrainingProfileCopyWithImpl;
@useResult
$Res call({
 String userId, TrainingExperience trainingExperience, String primaryTrainingStyle, int preferredSessionDurationMinutes, List<int> preferredTrainingDays, String notes, DateTime updatedAt
});




}
/// @nodoc
class _$TrainingProfileCopyWithImpl<$Res>
    implements $TrainingProfileCopyWith<$Res> {
  _$TrainingProfileCopyWithImpl(this._self, this._then);

  final TrainingProfile _self;
  final $Res Function(TrainingProfile) _then;

/// Create a copy of TrainingProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? trainingExperience = null,Object? primaryTrainingStyle = null,Object? preferredSessionDurationMinutes = null,Object? preferredTrainingDays = null,Object? notes = null,Object? updatedAt = null,}) {
  return _then(TrainingProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,trainingExperience: null == trainingExperience ? _self.trainingExperience : trainingExperience // ignore: cast_nullable_to_non_nullable
as TrainingExperience,primaryTrainingStyle: null == primaryTrainingStyle ? _self.primaryTrainingStyle : primaryTrainingStyle // ignore: cast_nullable_to_non_nullable
as String,preferredSessionDurationMinutes: null == preferredSessionDurationMinutes ? _self.preferredSessionDurationMinutes : preferredSessionDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,preferredTrainingDays: null == preferredTrainingDays ? _self.preferredTrainingDays : preferredTrainingDays // ignore: cast_nullable_to_non_nullable
as List<int>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingProfile].
extension TrainingProfilePatterns on TrainingProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingProfile value)  $default,){
final _that = this;
switch (_that) {
case _TrainingProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingProfile value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  TrainingExperience trainingExperience,  String primaryTrainingStyle,  int preferredSessionDurationMinutes,  List<int> preferredTrainingDays,  String notes,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingProfile() when $default != null:
return $default(_that.userId,_that.trainingExperience,_that.primaryTrainingStyle,_that.preferredSessionDurationMinutes,_that.preferredTrainingDays,_that.notes,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  TrainingExperience trainingExperience,  String primaryTrainingStyle,  int preferredSessionDurationMinutes,  List<int> preferredTrainingDays,  String notes,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TrainingProfile():
return $default(_that.userId,_that.trainingExperience,_that.primaryTrainingStyle,_that.preferredSessionDurationMinutes,_that.preferredTrainingDays,_that.notes,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  TrainingExperience trainingExperience,  String primaryTrainingStyle,  int preferredSessionDurationMinutes,  List<int> preferredTrainingDays,  String notes,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TrainingProfile() when $default != null:
return $default(_that.userId,_that.trainingExperience,_that.primaryTrainingStyle,_that.preferredSessionDurationMinutes,_that.preferredTrainingDays,_that.notes,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingProfile implements TrainingProfile {
  const _TrainingProfile({required this.userId, this.trainingExperience = TrainingExperience.intermediate, this.primaryTrainingStyle = 'General Strength', this.preferredSessionDurationMinutes = 60,  List<int> preferredTrainingDays = const [1, 3, 5], this.notes = '', required this.updatedAt}): _preferredTrainingDays = preferredTrainingDays;
  factory _TrainingProfile.fromJson(Map<String, dynamic> json) => _$TrainingProfileFromJson(json);

@override final  String userId;
@override@JsonKey() final  TrainingExperience trainingExperience;
@override@JsonKey() final  String primaryTrainingStyle;
@override@JsonKey() final  int preferredSessionDurationMinutes;
 final  List<int> _preferredTrainingDays;
@override@JsonKey() List<int> get preferredTrainingDays {
  if (_preferredTrainingDays is EqualUnmodifiableListView) return _preferredTrainingDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preferredTrainingDays);
}

@override@JsonKey() final  String notes;
@override final  DateTime updatedAt;

/// Create a copy of TrainingProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingProfileCopyWith<_TrainingProfile> get copyWith => __$TrainingProfileCopyWithImpl<_TrainingProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingProfile&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.trainingExperience, trainingExperience) || other.trainingExperience == trainingExperience)&&(identical(other.primaryTrainingStyle, primaryTrainingStyle) || other.primaryTrainingStyle == primaryTrainingStyle)&&(identical(other.preferredSessionDurationMinutes, preferredSessionDurationMinutes) || other.preferredSessionDurationMinutes == preferredSessionDurationMinutes)&&const DeepCollectionEquality().equals(other.preferredTrainingDays, _preferredTrainingDays)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,trainingExperience,primaryTrainingStyle,preferredSessionDurationMinutes,const DeepCollectionEquality().hash(_preferredTrainingDays),notes,updatedAt);
}

@override
String toString() {
    return 'TrainingProfile(userId: $userId, trainingExperience: $trainingExperience, primaryTrainingStyle: $primaryTrainingStyle, preferredSessionDurationMinutes: $preferredSessionDurationMinutes, preferredTrainingDays: $preferredTrainingDays, notes: $notes, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TrainingProfileCopyWith<$Res> implements $TrainingProfileCopyWith<$Res> {
  factory _$TrainingProfileCopyWith(_TrainingProfile value, $Res Function(_TrainingProfile) _then) = __$TrainingProfileCopyWithImpl;
@override @useResult
$Res call({
 String userId, TrainingExperience trainingExperience, String primaryTrainingStyle, int preferredSessionDurationMinutes, List<int> preferredTrainingDays, String notes, DateTime updatedAt
});




}
/// @nodoc
class __$TrainingProfileCopyWithImpl<$Res>
    implements _$TrainingProfileCopyWith<$Res> {
  __$TrainingProfileCopyWithImpl(this._self, this._then);

  final _TrainingProfile _self;
  final $Res Function(_TrainingProfile) _then;

/// Create a copy of TrainingProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? trainingExperience = null,Object? primaryTrainingStyle = null,Object? preferredSessionDurationMinutes = null,Object? preferredTrainingDays = null,Object? notes = null,Object? updatedAt = null,}) {
  return _then(_TrainingProfile(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,trainingExperience: null == trainingExperience ? _self.trainingExperience : trainingExperience // ignore: cast_nullable_to_non_nullable
as TrainingExperience,primaryTrainingStyle: null == primaryTrainingStyle ? _self.primaryTrainingStyle : primaryTrainingStyle // ignore: cast_nullable_to_non_nullable
as String,preferredSessionDurationMinutes: null == preferredSessionDurationMinutes ? _self.preferredSessionDurationMinutes : preferredSessionDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,preferredTrainingDays: null == preferredTrainingDays ? _self._preferredTrainingDays : preferredTrainingDays // ignore: cast_nullable_to_non_nullable
as List<int>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

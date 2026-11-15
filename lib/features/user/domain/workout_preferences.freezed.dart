// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutPreferences {

 String get userId; int get defaultRestSeconds; bool get defaultWarmupEnabled; bool get defaultCooldownEnabled; bool get autoStartRestTimer; bool get soundEnabled; bool get vibrationEnabled; bool get keepScreenAwake; bool get showRpe; bool get showRir; int get defaultSessionDurationMinutes;
/// Create a copy of WorkoutPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkoutPreferencesCopyWith<WorkoutPreferences> get copyWith => _$WorkoutPreferencesCopyWithImpl<WorkoutPreferences>(this as WorkoutPreferences, _$identity);

  /// Serializes this WorkoutPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkoutPreferences;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkoutPreferences&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.defaultRestSeconds, _this.defaultRestSeconds) || other.defaultRestSeconds == _this.defaultRestSeconds)&&(identical(other.defaultWarmupEnabled, _this.defaultWarmupEnabled) || other.defaultWarmupEnabled == _this.defaultWarmupEnabled)&&(identical(other.defaultCooldownEnabled, _this.defaultCooldownEnabled) || other.defaultCooldownEnabled == _this.defaultCooldownEnabled)&&(identical(other.autoStartRestTimer, _this.autoStartRestTimer) || other.autoStartRestTimer == _this.autoStartRestTimer)&&(identical(other.soundEnabled, _this.soundEnabled) || other.soundEnabled == _this.soundEnabled)&&(identical(other.vibrationEnabled, _this.vibrationEnabled) || other.vibrationEnabled == _this.vibrationEnabled)&&(identical(other.keepScreenAwake, _this.keepScreenAwake) || other.keepScreenAwake == _this.keepScreenAwake)&&(identical(other.showRpe, _this.showRpe) || other.showRpe == _this.showRpe)&&(identical(other.showRir, _this.showRir) || other.showRir == _this.showRir)&&(identical(other.defaultSessionDurationMinutes, _this.defaultSessionDurationMinutes) || other.defaultSessionDurationMinutes == _this.defaultSessionDurationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkoutPreferences;
  return Object.hash(runtimeType,_this.userId,_this.defaultRestSeconds,_this.defaultWarmupEnabled,_this.defaultCooldownEnabled,_this.autoStartRestTimer,_this.soundEnabled,_this.vibrationEnabled,_this.keepScreenAwake,_this.showRpe,_this.showRir,_this.defaultSessionDurationMinutes);
}

@override
String toString() {
  final _this = this as WorkoutPreferences;
  return 'WorkoutPreferences(userId: ${_this.userId}, defaultRestSeconds: ${_this.defaultRestSeconds}, defaultWarmupEnabled: ${_this.defaultWarmupEnabled}, defaultCooldownEnabled: ${_this.defaultCooldownEnabled}, autoStartRestTimer: ${_this.autoStartRestTimer}, soundEnabled: ${_this.soundEnabled}, vibrationEnabled: ${_this.vibrationEnabled}, keepScreenAwake: ${_this.keepScreenAwake}, showRpe: ${_this.showRpe}, showRir: ${_this.showRir}, defaultSessionDurationMinutes: ${_this.defaultSessionDurationMinutes})';
}


}

/// @nodoc
abstract mixin class $WorkoutPreferencesCopyWith<$Res>  {
  factory $WorkoutPreferencesCopyWith(WorkoutPreferences value, $Res Function(WorkoutPreferences) _then) = _$WorkoutPreferencesCopyWithImpl;
@useResult
$Res call({
 String userId, int defaultRestSeconds, bool defaultWarmupEnabled, bool defaultCooldownEnabled, bool autoStartRestTimer, bool soundEnabled, bool vibrationEnabled, bool keepScreenAwake, bool showRpe, bool showRir, int defaultSessionDurationMinutes
});




}
/// @nodoc
class _$WorkoutPreferencesCopyWithImpl<$Res>
    implements $WorkoutPreferencesCopyWith<$Res> {
  _$WorkoutPreferencesCopyWithImpl(this._self, this._then);

  final WorkoutPreferences _self;
  final $Res Function(WorkoutPreferences) _then;

/// Create a copy of WorkoutPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? defaultRestSeconds = null,Object? defaultWarmupEnabled = null,Object? defaultCooldownEnabled = null,Object? autoStartRestTimer = null,Object? soundEnabled = null,Object? vibrationEnabled = null,Object? keepScreenAwake = null,Object? showRpe = null,Object? showRir = null,Object? defaultSessionDurationMinutes = null,}) {
  return _then(WorkoutPreferences(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,defaultRestSeconds: null == defaultRestSeconds ? _self.defaultRestSeconds : defaultRestSeconds // ignore: cast_nullable_to_non_nullable
as int,defaultWarmupEnabled: null == defaultWarmupEnabled ? _self.defaultWarmupEnabled : defaultWarmupEnabled // ignore: cast_nullable_to_non_nullable
as bool,defaultCooldownEnabled: null == defaultCooldownEnabled ? _self.defaultCooldownEnabled : defaultCooldownEnabled // ignore: cast_nullable_to_non_nullable
as bool,autoStartRestTimer: null == autoStartRestTimer ? _self.autoStartRestTimer : autoStartRestTimer // ignore: cast_nullable_to_non_nullable
as bool,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,vibrationEnabled: null == vibrationEnabled ? _self.vibrationEnabled : vibrationEnabled // ignore: cast_nullable_to_non_nullable
as bool,keepScreenAwake: null == keepScreenAwake ? _self.keepScreenAwake : keepScreenAwake // ignore: cast_nullable_to_non_nullable
as bool,showRpe: null == showRpe ? _self.showRpe : showRpe // ignore: cast_nullable_to_non_nullable
as bool,showRir: null == showRir ? _self.showRir : showRir // ignore: cast_nullable_to_non_nullable
as bool,defaultSessionDurationMinutes: null == defaultSessionDurationMinutes ? _self.defaultSessionDurationMinutes : defaultSessionDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkoutPreferences].
extension WorkoutPreferencesPatterns on WorkoutPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkoutPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkoutPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkoutPreferences value)  $default,){
final _that = this;
switch (_that) {
case _WorkoutPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkoutPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _WorkoutPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int defaultRestSeconds,  bool defaultWarmupEnabled,  bool defaultCooldownEnabled,  bool autoStartRestTimer,  bool soundEnabled,  bool vibrationEnabled,  bool keepScreenAwake,  bool showRpe,  bool showRir,  int defaultSessionDurationMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkoutPreferences() when $default != null:
return $default(_that.userId,_that.defaultRestSeconds,_that.defaultWarmupEnabled,_that.defaultCooldownEnabled,_that.autoStartRestTimer,_that.soundEnabled,_that.vibrationEnabled,_that.keepScreenAwake,_that.showRpe,_that.showRir,_that.defaultSessionDurationMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int defaultRestSeconds,  bool defaultWarmupEnabled,  bool defaultCooldownEnabled,  bool autoStartRestTimer,  bool soundEnabled,  bool vibrationEnabled,  bool keepScreenAwake,  bool showRpe,  bool showRir,  int defaultSessionDurationMinutes)  $default,) {final _that = this;
switch (_that) {
case _WorkoutPreferences():
return $default(_that.userId,_that.defaultRestSeconds,_that.defaultWarmupEnabled,_that.defaultCooldownEnabled,_that.autoStartRestTimer,_that.soundEnabled,_that.vibrationEnabled,_that.keepScreenAwake,_that.showRpe,_that.showRir,_that.defaultSessionDurationMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int defaultRestSeconds,  bool defaultWarmupEnabled,  bool defaultCooldownEnabled,  bool autoStartRestTimer,  bool soundEnabled,  bool vibrationEnabled,  bool keepScreenAwake,  bool showRpe,  bool showRir,  int defaultSessionDurationMinutes)?  $default,) {final _that = this;
switch (_that) {
case _WorkoutPreferences() when $default != null:
return $default(_that.userId,_that.defaultRestSeconds,_that.defaultWarmupEnabled,_that.defaultCooldownEnabled,_that.autoStartRestTimer,_that.soundEnabled,_that.vibrationEnabled,_that.keepScreenAwake,_that.showRpe,_that.showRir,_that.defaultSessionDurationMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkoutPreferences implements WorkoutPreferences {
  const _WorkoutPreferences({required this.userId, this.defaultRestSeconds = 90, this.defaultWarmupEnabled = true, this.defaultCooldownEnabled = false, this.autoStartRestTimer = true, this.soundEnabled = true, this.vibrationEnabled = true, this.keepScreenAwake = true, this.showRpe = true, this.showRir = false, this.defaultSessionDurationMinutes = 60});
  factory _WorkoutPreferences.fromJson(Map<String, dynamic> json) => _$WorkoutPreferencesFromJson(json);

@override final  String userId;
@override@JsonKey() final  int defaultRestSeconds;
@override@JsonKey() final  bool defaultWarmupEnabled;
@override@JsonKey() final  bool defaultCooldownEnabled;
@override@JsonKey() final  bool autoStartRestTimer;
@override@JsonKey() final  bool soundEnabled;
@override@JsonKey() final  bool vibrationEnabled;
@override@JsonKey() final  bool keepScreenAwake;
@override@JsonKey() final  bool showRpe;
@override@JsonKey() final  bool showRir;
@override@JsonKey() final  int defaultSessionDurationMinutes;

/// Create a copy of WorkoutPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkoutPreferencesCopyWith<_WorkoutPreferences> get copyWith => __$WorkoutPreferencesCopyWithImpl<_WorkoutPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkoutPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkoutPreferences&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.defaultRestSeconds, defaultRestSeconds) || other.defaultRestSeconds == defaultRestSeconds)&&(identical(other.defaultWarmupEnabled, defaultWarmupEnabled) || other.defaultWarmupEnabled == defaultWarmupEnabled)&&(identical(other.defaultCooldownEnabled, defaultCooldownEnabled) || other.defaultCooldownEnabled == defaultCooldownEnabled)&&(identical(other.autoStartRestTimer, autoStartRestTimer) || other.autoStartRestTimer == autoStartRestTimer)&&(identical(other.soundEnabled, soundEnabled) || other.soundEnabled == soundEnabled)&&(identical(other.vibrationEnabled, vibrationEnabled) || other.vibrationEnabled == vibrationEnabled)&&(identical(other.keepScreenAwake, keepScreenAwake) || other.keepScreenAwake == keepScreenAwake)&&(identical(other.showRpe, showRpe) || other.showRpe == showRpe)&&(identical(other.showRir, showRir) || other.showRir == showRir)&&(identical(other.defaultSessionDurationMinutes, defaultSessionDurationMinutes) || other.defaultSessionDurationMinutes == defaultSessionDurationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,defaultRestSeconds,defaultWarmupEnabled,defaultCooldownEnabled,autoStartRestTimer,soundEnabled,vibrationEnabled,keepScreenAwake,showRpe,showRir,defaultSessionDurationMinutes);
}

@override
String toString() {
    return 'WorkoutPreferences(userId: $userId, defaultRestSeconds: $defaultRestSeconds, defaultWarmupEnabled: $defaultWarmupEnabled, defaultCooldownEnabled: $defaultCooldownEnabled, autoStartRestTimer: $autoStartRestTimer, soundEnabled: $soundEnabled, vibrationEnabled: $vibrationEnabled, keepScreenAwake: $keepScreenAwake, showRpe: $showRpe, showRir: $showRir, defaultSessionDurationMinutes: $defaultSessionDurationMinutes)';
}


}

/// @nodoc
abstract mixin class _$WorkoutPreferencesCopyWith<$Res> implements $WorkoutPreferencesCopyWith<$Res> {
  factory _$WorkoutPreferencesCopyWith(_WorkoutPreferences value, $Res Function(_WorkoutPreferences) _then) = __$WorkoutPreferencesCopyWithImpl;
@override @useResult
$Res call({
 String userId, int defaultRestSeconds, bool defaultWarmupEnabled, bool defaultCooldownEnabled, bool autoStartRestTimer, bool soundEnabled, bool vibrationEnabled, bool keepScreenAwake, bool showRpe, bool showRir, int defaultSessionDurationMinutes
});




}
/// @nodoc
class __$WorkoutPreferencesCopyWithImpl<$Res>
    implements _$WorkoutPreferencesCopyWith<$Res> {
  __$WorkoutPreferencesCopyWithImpl(this._self, this._then);

  final _WorkoutPreferences _self;
  final $Res Function(_WorkoutPreferences) _then;

/// Create a copy of WorkoutPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? defaultRestSeconds = null,Object? defaultWarmupEnabled = null,Object? defaultCooldownEnabled = null,Object? autoStartRestTimer = null,Object? soundEnabled = null,Object? vibrationEnabled = null,Object? keepScreenAwake = null,Object? showRpe = null,Object? showRir = null,Object? defaultSessionDurationMinutes = null,}) {
  return _then(_WorkoutPreferences(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,defaultRestSeconds: null == defaultRestSeconds ? _self.defaultRestSeconds : defaultRestSeconds // ignore: cast_nullable_to_non_nullable
as int,defaultWarmupEnabled: null == defaultWarmupEnabled ? _self.defaultWarmupEnabled : defaultWarmupEnabled // ignore: cast_nullable_to_non_nullable
as bool,defaultCooldownEnabled: null == defaultCooldownEnabled ? _self.defaultCooldownEnabled : defaultCooldownEnabled // ignore: cast_nullable_to_non_nullable
as bool,autoStartRestTimer: null == autoStartRestTimer ? _self.autoStartRestTimer : autoStartRestTimer // ignore: cast_nullable_to_non_nullable
as bool,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,vibrationEnabled: null == vibrationEnabled ? _self.vibrationEnabled : vibrationEnabled // ignore: cast_nullable_to_non_nullable
as bool,keepScreenAwake: null == keepScreenAwake ? _self.keepScreenAwake : keepScreenAwake // ignore: cast_nullable_to_non_nullable
as bool,showRpe: null == showRpe ? _self.showRpe : showRpe // ignore: cast_nullable_to_non_nullable
as bool,showRir: null == showRir ? _self.showRir : showRir // ignore: cast_nullable_to_non_nullable
as bool,defaultSessionDurationMinutes: null == defaultSessionDurationMinutes ? _self.defaultSessionDurationMinutes : defaultSessionDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

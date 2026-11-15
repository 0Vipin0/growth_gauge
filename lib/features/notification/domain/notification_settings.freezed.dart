// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationSettings {

 bool get notificationsEnabled; bool get soundEnabled; bool get vibrationEnabled; bool get dailyReminderEnabled;@TimeOfDayConverter() TimeOfDay? get notificationTime;
/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsCopyWith<NotificationSettings> get copyWith => _$NotificationSettingsCopyWithImpl<NotificationSettings>(this as NotificationSettings, _$identity);

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettings&&(identical(other.notificationsEnabled, _this.notificationsEnabled) || other.notificationsEnabled == _this.notificationsEnabled)&&(identical(other.soundEnabled, _this.soundEnabled) || other.soundEnabled == _this.soundEnabled)&&(identical(other.vibrationEnabled, _this.vibrationEnabled) || other.vibrationEnabled == _this.vibrationEnabled)&&(identical(other.dailyReminderEnabled, _this.dailyReminderEnabled) || other.dailyReminderEnabled == _this.dailyReminderEnabled)&&(identical(other.notificationTime, _this.notificationTime) || other.notificationTime == _this.notificationTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationSettings;
  return Object.hash(runtimeType,_this.notificationsEnabled,_this.soundEnabled,_this.vibrationEnabled,_this.dailyReminderEnabled,_this.notificationTime);
}

@override
String toString() {
  final _this = this as NotificationSettings;
  return 'NotificationSettings(notificationsEnabled: ${_this.notificationsEnabled}, soundEnabled: ${_this.soundEnabled}, vibrationEnabled: ${_this.vibrationEnabled}, dailyReminderEnabled: ${_this.dailyReminderEnabled}, notificationTime: ${_this.notificationTime})';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsCopyWith<$Res>  {
  factory $NotificationSettingsCopyWith(NotificationSettings value, $Res Function(NotificationSettings) _then) = _$NotificationSettingsCopyWithImpl;
@useResult
$Res call({
 bool notificationsEnabled, bool soundEnabled, bool vibrationEnabled, bool dailyReminderEnabled,@TimeOfDayConverter() TimeOfDay? notificationTime
});




}
/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._self, this._then);

  final NotificationSettings _self;
  final $Res Function(NotificationSettings) _then;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationsEnabled = null,Object? soundEnabled = null,Object? vibrationEnabled = null,Object? dailyReminderEnabled = null,Object? notificationTime = freezed,}) {
  return _then(NotificationSettings(
notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,vibrationEnabled: null == vibrationEnabled ? _self.vibrationEnabled : vibrationEnabled // ignore: cast_nullable_to_non_nullable
as bool,dailyReminderEnabled: null == dailyReminderEnabled ? _self.dailyReminderEnabled : dailyReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTime: freezed == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSettings].
extension NotificationSettingsPatterns on NotificationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettings value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool notificationsEnabled,  bool soundEnabled,  bool vibrationEnabled,  bool dailyReminderEnabled, @TimeOfDayConverter()  TimeOfDay? notificationTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
return $default(_that.notificationsEnabled,_that.soundEnabled,_that.vibrationEnabled,_that.dailyReminderEnabled,_that.notificationTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool notificationsEnabled,  bool soundEnabled,  bool vibrationEnabled,  bool dailyReminderEnabled, @TimeOfDayConverter()  TimeOfDay? notificationTime)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettings():
return $default(_that.notificationsEnabled,_that.soundEnabled,_that.vibrationEnabled,_that.dailyReminderEnabled,_that.notificationTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool notificationsEnabled,  bool soundEnabled,  bool vibrationEnabled,  bool dailyReminderEnabled, @TimeOfDayConverter()  TimeOfDay? notificationTime)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettings() when $default != null:
return $default(_that.notificationsEnabled,_that.soundEnabled,_that.vibrationEnabled,_that.dailyReminderEnabled,_that.notificationTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSettings implements NotificationSettings {
  const _NotificationSettings({this.notificationsEnabled = true, this.soundEnabled = true, this.vibrationEnabled = true, this.dailyReminderEnabled = true, @TimeOfDayConverter() this.notificationTime = null});
  factory _NotificationSettings.fromJson(Map<String, dynamic> json) => _$NotificationSettingsFromJson(json);

@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  bool soundEnabled;
@override@JsonKey() final  bool vibrationEnabled;
@override@JsonKey() final  bool dailyReminderEnabled;
@override@JsonKey()@TimeOfDayConverter() final  TimeOfDay? notificationTime;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsCopyWith<_NotificationSettings> get copyWith => __$NotificationSettingsCopyWithImpl<_NotificationSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettings&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.soundEnabled, soundEnabled) || other.soundEnabled == soundEnabled)&&(identical(other.vibrationEnabled, vibrationEnabled) || other.vibrationEnabled == vibrationEnabled)&&(identical(other.dailyReminderEnabled, dailyReminderEnabled) || other.dailyReminderEnabled == dailyReminderEnabled)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,notificationsEnabled,soundEnabled,vibrationEnabled,dailyReminderEnabled,notificationTime);
}

@override
String toString() {
    return 'NotificationSettings(notificationsEnabled: $notificationsEnabled, soundEnabled: $soundEnabled, vibrationEnabled: $vibrationEnabled, dailyReminderEnabled: $dailyReminderEnabled, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsCopyWith<$Res> implements $NotificationSettingsCopyWith<$Res> {
  factory _$NotificationSettingsCopyWith(_NotificationSettings value, $Res Function(_NotificationSettings) _then) = __$NotificationSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool notificationsEnabled, bool soundEnabled, bool vibrationEnabled, bool dailyReminderEnabled,@TimeOfDayConverter() TimeOfDay? notificationTime
});




}
/// @nodoc
class __$NotificationSettingsCopyWithImpl<$Res>
    implements _$NotificationSettingsCopyWith<$Res> {
  __$NotificationSettingsCopyWithImpl(this._self, this._then);

  final _NotificationSettings _self;
  final $Res Function(_NotificationSettings) _then;

/// Create a copy of NotificationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationsEnabled = null,Object? soundEnabled = null,Object? vibrationEnabled = null,Object? dailyReminderEnabled = null,Object? notificationTime = freezed,}) {
  return _then(_NotificationSettings(
notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,vibrationEnabled: null == vibrationEnabled ? _self.vibrationEnabled : vibrationEnabled // ignore: cast_nullable_to_non_nullable
as bool,dailyReminderEnabled: null == dailyReminderEnabled ? _self.dailyReminderEnabled : dailyReminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,notificationTime: freezed == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsModel {

 AppThemeName get themeName; ThemeMode get themeMode; AppContrastVariant get contrastVariant; AppFontSize get fontSize; AppFontFamilyChoice get fontFamilyChoice; ExportFormat get exportFormat; AuthenticationType get authenticationType;@TimeOfDayConverter() TimeOfDay? get notificationTime;
/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsModelCopyWith<SettingsModel> get copyWith => _$SettingsModelCopyWithImpl<SettingsModel>(this as SettingsModel, _$identity);

  /// Serializes this SettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SettingsModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsModel&&(identical(other.themeName, _this.themeName) || other.themeName == _this.themeName)&&(identical(other.themeMode, _this.themeMode) || other.themeMode == _this.themeMode)&&(identical(other.contrastVariant, _this.contrastVariant) || other.contrastVariant == _this.contrastVariant)&&(identical(other.fontSize, _this.fontSize) || other.fontSize == _this.fontSize)&&(identical(other.fontFamilyChoice, _this.fontFamilyChoice) || other.fontFamilyChoice == _this.fontFamilyChoice)&&(identical(other.exportFormat, _this.exportFormat) || other.exportFormat == _this.exportFormat)&&(identical(other.authenticationType, _this.authenticationType) || other.authenticationType == _this.authenticationType)&&(identical(other.notificationTime, _this.notificationTime) || other.notificationTime == _this.notificationTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SettingsModel;
  return Object.hash(runtimeType,_this.themeName,_this.themeMode,_this.contrastVariant,_this.fontSize,_this.fontFamilyChoice,_this.exportFormat,_this.authenticationType,_this.notificationTime);
}

@override
String toString() {
  final _this = this as SettingsModel;
  return 'SettingsModel(themeName: ${_this.themeName}, themeMode: ${_this.themeMode}, contrastVariant: ${_this.contrastVariant}, fontSize: ${_this.fontSize}, fontFamilyChoice: ${_this.fontFamilyChoice}, exportFormat: ${_this.exportFormat}, authenticationType: ${_this.authenticationType}, notificationTime: ${_this.notificationTime})';
}


}

/// @nodoc
abstract mixin class $SettingsModelCopyWith<$Res>  {
  factory $SettingsModelCopyWith(SettingsModel value, $Res Function(SettingsModel) _then) = _$SettingsModelCopyWithImpl;
@useResult
$Res call({
 AppThemeName themeName, ThemeMode themeMode, AppContrastVariant contrastVariant, AppFontSize fontSize, AppFontFamilyChoice fontFamilyChoice, ExportFormat exportFormat, AuthenticationType authenticationType,@TimeOfDayConverter() TimeOfDay? notificationTime
});




}
/// @nodoc
class _$SettingsModelCopyWithImpl<$Res>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._self, this._then);

  final SettingsModel _self;
  final $Res Function(SettingsModel) _then;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeName = null,Object? themeMode = null,Object? contrastVariant = null,Object? fontSize = null,Object? fontFamilyChoice = null,Object? exportFormat = null,Object? authenticationType = null,Object? notificationTime = freezed,}) {
  return _then(SettingsModel(
themeName: null == themeName ? _self.themeName : themeName // ignore: cast_nullable_to_non_nullable
as AppThemeName,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,contrastVariant: null == contrastVariant ? _self.contrastVariant : contrastVariant // ignore: cast_nullable_to_non_nullable
as AppContrastVariant,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as AppFontSize,fontFamilyChoice: null == fontFamilyChoice ? _self.fontFamilyChoice : fontFamilyChoice // ignore: cast_nullable_to_non_nullable
as AppFontFamilyChoice,exportFormat: null == exportFormat ? _self.exportFormat : exportFormat // ignore: cast_nullable_to_non_nullable
as ExportFormat,authenticationType: null == authenticationType ? _self.authenticationType : authenticationType // ignore: cast_nullable_to_non_nullable
as AuthenticationType,notificationTime: freezed == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsModel].
extension SettingsModelPatterns on SettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _SettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppThemeName themeName,  ThemeMode themeMode,  AppContrastVariant contrastVariant,  AppFontSize fontSize,  AppFontFamilyChoice fontFamilyChoice,  ExportFormat exportFormat,  AuthenticationType authenticationType, @TimeOfDayConverter()  TimeOfDay? notificationTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
return $default(_that.themeName,_that.themeMode,_that.contrastVariant,_that.fontSize,_that.fontFamilyChoice,_that.exportFormat,_that.authenticationType,_that.notificationTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppThemeName themeName,  ThemeMode themeMode,  AppContrastVariant contrastVariant,  AppFontSize fontSize,  AppFontFamilyChoice fontFamilyChoice,  ExportFormat exportFormat,  AuthenticationType authenticationType, @TimeOfDayConverter()  TimeOfDay? notificationTime)  $default,) {final _that = this;
switch (_that) {
case _SettingsModel():
return $default(_that.themeName,_that.themeMode,_that.contrastVariant,_that.fontSize,_that.fontFamilyChoice,_that.exportFormat,_that.authenticationType,_that.notificationTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppThemeName themeName,  ThemeMode themeMode,  AppContrastVariant contrastVariant,  AppFontSize fontSize,  AppFontFamilyChoice fontFamilyChoice,  ExportFormat exportFormat,  AuthenticationType authenticationType, @TimeOfDayConverter()  TimeOfDay? notificationTime)?  $default,) {final _that = this;
switch (_that) {
case _SettingsModel() when $default != null:
return $default(_that.themeName,_that.themeMode,_that.contrastVariant,_that.fontSize,_that.fontFamilyChoice,_that.exportFormat,_that.authenticationType,_that.notificationTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsModel implements SettingsModel {
  const _SettingsModel({this.themeName = AppThemeName.forest, this.themeMode = ThemeMode.system, this.contrastVariant = AppContrastVariant.standard, this.fontSize = AppFontSize.medium, this.fontFamilyChoice = AppFontFamilyChoice.manrope, this.exportFormat = ExportFormat.json, this.authenticationType = AuthenticationType.none, @TimeOfDayConverter() this.notificationTime = null});
  factory _SettingsModel.fromJson(Map<String, dynamic> json) => _$SettingsModelFromJson(json);

@override@JsonKey() final  AppThemeName themeName;
@override@JsonKey() final  ThemeMode themeMode;
@override@JsonKey() final  AppContrastVariant contrastVariant;
@override@JsonKey() final  AppFontSize fontSize;
@override@JsonKey() final  AppFontFamilyChoice fontFamilyChoice;
@override@JsonKey() final  ExportFormat exportFormat;
@override@JsonKey() final  AuthenticationType authenticationType;
@override@JsonKey()@TimeOfDayConverter() final  TimeOfDay? notificationTime;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsModelCopyWith<_SettingsModel> get copyWith => __$SettingsModelCopyWithImpl<_SettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsModel&&(identical(other.themeName, themeName) || other.themeName == themeName)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.contrastVariant, contrastVariant) || other.contrastVariant == contrastVariant)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.fontFamilyChoice, fontFamilyChoice) || other.fontFamilyChoice == fontFamilyChoice)&&(identical(other.exportFormat, exportFormat) || other.exportFormat == exportFormat)&&(identical(other.authenticationType, authenticationType) || other.authenticationType == authenticationType)&&(identical(other.notificationTime, notificationTime) || other.notificationTime == notificationTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,themeName,themeMode,contrastVariant,fontSize,fontFamilyChoice,exportFormat,authenticationType,notificationTime);
}

@override
String toString() {
    return 'SettingsModel(themeName: $themeName, themeMode: $themeMode, contrastVariant: $contrastVariant, fontSize: $fontSize, fontFamilyChoice: $fontFamilyChoice, exportFormat: $exportFormat, authenticationType: $authenticationType, notificationTime: $notificationTime)';
}


}

/// @nodoc
abstract mixin class _$SettingsModelCopyWith<$Res> implements $SettingsModelCopyWith<$Res> {
  factory _$SettingsModelCopyWith(_SettingsModel value, $Res Function(_SettingsModel) _then) = __$SettingsModelCopyWithImpl;
@override @useResult
$Res call({
 AppThemeName themeName, ThemeMode themeMode, AppContrastVariant contrastVariant, AppFontSize fontSize, AppFontFamilyChoice fontFamilyChoice, ExportFormat exportFormat, AuthenticationType authenticationType,@TimeOfDayConverter() TimeOfDay? notificationTime
});




}
/// @nodoc
class __$SettingsModelCopyWithImpl<$Res>
    implements _$SettingsModelCopyWith<$Res> {
  __$SettingsModelCopyWithImpl(this._self, this._then);

  final _SettingsModel _self;
  final $Res Function(_SettingsModel) _then;

/// Create a copy of SettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeName = null,Object? themeMode = null,Object? contrastVariant = null,Object? fontSize = null,Object? fontFamilyChoice = null,Object? exportFormat = null,Object? authenticationType = null,Object? notificationTime = freezed,}) {
  return _then(_SettingsModel(
themeName: null == themeName ? _self.themeName : themeName // ignore: cast_nullable_to_non_nullable
as AppThemeName,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,contrastVariant: null == contrastVariant ? _self.contrastVariant : contrastVariant // ignore: cast_nullable_to_non_nullable
as AppContrastVariant,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as AppFontSize,fontFamilyChoice: null == fontFamilyChoice ? _self.fontFamilyChoice : fontFamilyChoice // ignore: cast_nullable_to_non_nullable
as AppFontFamilyChoice,exportFormat: null == exportFormat ? _self.exportFormat : exportFormat // ignore: cast_nullable_to_non_nullable
as ExportFormat,authenticationType: null == authenticationType ? _self.authenticationType : authenticationType // ignore: cast_nullable_to_non_nullable
as AuthenticationType,notificationTime: freezed == notificationTime ? _self.notificationTime : notificationTime // ignore: cast_nullable_to_non_nullable
as TimeOfDay?,
  ));
}


}

// dart format on

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) {
  return _SettingsModel.fromJson(json);
}

/// @nodoc
mixin _$SettingsModel {
  AppThemeName get themeName => throw _privateConstructorUsedError;
  AppFontSize get fontSize => throw _privateConstructorUsedError;
  AppFontFamily get fontFamily => throw _privateConstructorUsedError;
  ExportFormat get exportFormat => throw _privateConstructorUsedError;
  AuthenticationType get authenticationType =>
      throw _privateConstructorUsedError;
  @TimeOfDayConverter()
  TimeOfDay? get notificationTime => throw _privateConstructorUsedError;

  /// Serializes this SettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsModelCopyWith<SettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsModelCopyWith<$Res> {
  factory $SettingsModelCopyWith(
          SettingsModel value, $Res Function(SettingsModel) then) =
      _$SettingsModelCopyWithImpl<$Res, SettingsModel>;
  @useResult
  $Res call(
      {AppThemeName themeName,
      AppFontSize fontSize,
      AppFontFamily fontFamily,
      ExportFormat exportFormat,
      AuthenticationType authenticationType,
      @TimeOfDayConverter() TimeOfDay? notificationTime});
}

/// @nodoc
class _$SettingsModelCopyWithImpl<$Res, $Val extends SettingsModel>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeName = null,
    Object? fontSize = null,
    Object? fontFamily = null,
    Object? exportFormat = null,
    Object? authenticationType = null,
    Object? notificationTime = freezed,
  }) {
    return _then(_value.copyWith(
      themeName: null == themeName
          ? _value.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as AppThemeName,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as AppFontSize,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as AppFontFamily,
      exportFormat: null == exportFormat
          ? _value.exportFormat
          : exportFormat // ignore: cast_nullable_to_non_nullable
              as ExportFormat,
      authenticationType: null == authenticationType
          ? _value.authenticationType
          : authenticationType // ignore: cast_nullable_to_non_nullable
              as AuthenticationType,
      notificationTime: freezed == notificationTime
          ? _value.notificationTime
          : notificationTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsModelImplCopyWith<$Res>
    implements $SettingsModelCopyWith<$Res> {
  factory _$$SettingsModelImplCopyWith(
          _$SettingsModelImpl value, $Res Function(_$SettingsModelImpl) then) =
      __$$SettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppThemeName themeName,
      AppFontSize fontSize,
      AppFontFamily fontFamily,
      ExportFormat exportFormat,
      AuthenticationType authenticationType,
      @TimeOfDayConverter() TimeOfDay? notificationTime});
}

/// @nodoc
class __$$SettingsModelImplCopyWithImpl<$Res>
    extends _$SettingsModelCopyWithImpl<$Res, _$SettingsModelImpl>
    implements _$$SettingsModelImplCopyWith<$Res> {
  __$$SettingsModelImplCopyWithImpl(
      _$SettingsModelImpl _value, $Res Function(_$SettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeName = null,
    Object? fontSize = null,
    Object? fontFamily = null,
    Object? exportFormat = null,
    Object? authenticationType = null,
    Object? notificationTime = freezed,
  }) {
    return _then(_$SettingsModelImpl(
      themeName: null == themeName
          ? _value.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as AppThemeName,
      fontSize: null == fontSize
          ? _value.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as AppFontSize,
      fontFamily: null == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as AppFontFamily,
      exportFormat: null == exportFormat
          ? _value.exportFormat
          : exportFormat // ignore: cast_nullable_to_non_nullable
              as ExportFormat,
      authenticationType: null == authenticationType
          ? _value.authenticationType
          : authenticationType // ignore: cast_nullable_to_non_nullable
              as AuthenticationType,
      notificationTime: freezed == notificationTime
          ? _value.notificationTime
          : notificationTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsModelImpl implements _SettingsModel {
  const _$SettingsModelImpl(
      {required this.themeName,
      this.fontSize = AppFontSize.medium,
      this.fontFamily = AppFontFamily.roboto,
      this.exportFormat = ExportFormat.json,
      this.authenticationType = AuthenticationType.none,
      @TimeOfDayConverter() this.notificationTime = null});

  factory _$SettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsModelImplFromJson(json);

  @override
  final AppThemeName themeName;
  @override
  @JsonKey()
  final AppFontSize fontSize;
  @override
  @JsonKey()
  final AppFontFamily fontFamily;
  @override
  @JsonKey()
  final ExportFormat exportFormat;
  @override
  @JsonKey()
  final AuthenticationType authenticationType;
  @override
  @JsonKey()
  @TimeOfDayConverter()
  final TimeOfDay? notificationTime;

  @override
  String toString() {
    return 'SettingsModel(themeName: $themeName, fontSize: $fontSize, fontFamily: $fontFamily, exportFormat: $exportFormat, authenticationType: $authenticationType, notificationTime: $notificationTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsModelImpl &&
            (identical(other.themeName, themeName) ||
                other.themeName == themeName) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.exportFormat, exportFormat) ||
                other.exportFormat == exportFormat) &&
            (identical(other.authenticationType, authenticationType) ||
                other.authenticationType == authenticationType) &&
            (identical(other.notificationTime, notificationTime) ||
                other.notificationTime == notificationTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeName, fontSize, fontFamily,
      exportFormat, authenticationType, notificationTime);

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsModelImplCopyWith<_$SettingsModelImpl> get copyWith =>
      __$$SettingsModelImplCopyWithImpl<_$SettingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsModelImplToJson(
      this,
    );
  }
}

abstract class _SettingsModel implements SettingsModel {
  const factory _SettingsModel(
          {required final AppThemeName themeName,
          final AppFontSize fontSize,
          final AppFontFamily fontFamily,
          final ExportFormat exportFormat,
          final AuthenticationType authenticationType,
          @TimeOfDayConverter() final TimeOfDay? notificationTime}) =
      _$SettingsModelImpl;

  factory _SettingsModel.fromJson(Map<String, dynamic> json) =
      _$SettingsModelImpl.fromJson;

  @override
  AppThemeName get themeName;
  @override
  AppFontSize get fontSize;
  @override
  AppFontFamily get fontFamily;
  @override
  ExportFormat get exportFormat;
  @override
  AuthenticationType get authenticationType;
  @override
  @TimeOfDayConverter()
  TimeOfDay? get notificationTime;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsModelImplCopyWith<_$SettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

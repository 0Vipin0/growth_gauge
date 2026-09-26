// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsModel {
  AppThemeName get themeName;
  AppFontSize get fontSize;
  AppFontFamily get fontFamily;
  ExportFormat get exportFormat;
  AuthenticationType get authenticationType;
  @TimeOfDayConverter()
  TimeOfDay? get notificationTime;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SettingsModelCopyWith<SettingsModel> get copyWith =>
      _$SettingsModelCopyWithImpl<SettingsModel>(
          this as SettingsModel, _$identity);

  /// Serializes this SettingsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SettingsModel &&
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

  @override
  String toString() {
    return 'SettingsModel(themeName: $themeName, fontSize: $fontSize, fontFamily: $fontFamily, exportFormat: $exportFormat, authenticationType: $authenticationType, notificationTime: $notificationTime)';
  }
}

/// @nodoc
abstract mixin class $SettingsModelCopyWith<$Res> {
  factory $SettingsModelCopyWith(
          SettingsModel value, $Res Function(SettingsModel) _then) =
      _$SettingsModelCopyWithImpl;
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
class _$SettingsModelCopyWithImpl<$Res>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._self, this._then);

  SettingsModel _self;
  final $Res Function(SettingsModel) _then;

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
    return _then(_self.copyWith(
      themeName: null == themeName
          ? _self.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as AppThemeName,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as AppFontSize,
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as AppFontFamily,
      exportFormat: null == exportFormat
          ? _self.exportFormat
          : exportFormat // ignore: cast_nullable_to_non_nullable
              as ExportFormat,
      authenticationType: null == authenticationType
          ? _self.authenticationType
          : authenticationType // ignore: cast_nullable_to_non_nullable
              as AuthenticationType,
      notificationTime: freezed == notificationTime
          ? _self.notificationTime
          : notificationTime // ignore: cast_nullable_to_non_nullable
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_SettingsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsModel() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_SettingsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsModel():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_SettingsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsModel() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            AppThemeName themeName,
            AppFontSize fontSize,
            AppFontFamily fontFamily,
            ExportFormat exportFormat,
            AuthenticationType authenticationType,
            @TimeOfDayConverter() TimeOfDay? notificationTime)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SettingsModel() when $default != null:
        return $default(
            _that.themeName,
            _that.fontSize,
            _that.fontFamily,
            _that.exportFormat,
            _that.authenticationType,
            _that.notificationTime);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            AppThemeName themeName,
            AppFontSize fontSize,
            AppFontFamily fontFamily,
            ExportFormat exportFormat,
            AuthenticationType authenticationType,
            @TimeOfDayConverter() TimeOfDay? notificationTime)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsModel():
        return $default(
            _that.themeName,
            _that.fontSize,
            _that.fontFamily,
            _that.exportFormat,
            _that.authenticationType,
            _that.notificationTime);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            AppThemeName themeName,
            AppFontSize fontSize,
            AppFontFamily fontFamily,
            ExportFormat exportFormat,
            AuthenticationType authenticationType,
            @TimeOfDayConverter() TimeOfDay? notificationTime)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SettingsModel() when $default != null:
        return $default(
            _that.themeName,
            _that.fontSize,
            _that.fontFamily,
            _that.exportFormat,
            _that.authenticationType,
            _that.notificationTime);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SettingsModel implements SettingsModel {
  const _SettingsModel(
      {required this.themeName,
      this.fontSize = AppFontSize.medium,
      this.fontFamily = AppFontFamily.roboto,
      this.exportFormat = ExportFormat.json,
      this.authenticationType = AuthenticationType.none,
      @TimeOfDayConverter() this.notificationTime = null});
  factory _SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

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

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SettingsModelCopyWith<_SettingsModel> get copyWith =>
      __$SettingsModelCopyWithImpl<_SettingsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SettingsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SettingsModel &&
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

  @override
  String toString() {
    return 'SettingsModel(themeName: $themeName, fontSize: $fontSize, fontFamily: $fontFamily, exportFormat: $exportFormat, authenticationType: $authenticationType, notificationTime: $notificationTime)';
  }
}

/// @nodoc
abstract mixin class _$SettingsModelCopyWith<$Res>
    implements $SettingsModelCopyWith<$Res> {
  factory _$SettingsModelCopyWith(
          _SettingsModel value, $Res Function(_SettingsModel) _then) =
      __$SettingsModelCopyWithImpl;
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
class __$SettingsModelCopyWithImpl<$Res>
    implements _$SettingsModelCopyWith<$Res> {
  __$SettingsModelCopyWithImpl(this._self, this._then);

  final _SettingsModel _self;
  final $Res Function(_SettingsModel) _then;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? themeName = null,
    Object? fontSize = null,
    Object? fontFamily = null,
    Object? exportFormat = null,
    Object? authenticationType = null,
    Object? notificationTime = freezed,
  }) {
    return _then(_SettingsModel(
      themeName: null == themeName
          ? _self.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as AppThemeName,
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as AppFontSize,
      fontFamily: null == fontFamily
          ? _self.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as AppFontFamily,
      exportFormat: null == exportFormat
          ? _self.exportFormat
          : exportFormat // ignore: cast_nullable_to_non_nullable
              as ExportFormat,
      authenticationType: null == authenticationType
          ? _self.authenticationType
          : authenticationType // ignore: cast_nullable_to_non_nullable
              as AuthenticationType,
      notificationTime: freezed == notificationTime
          ? _self.notificationTime
          : notificationTime // ignore: cast_nullable_to_non_nullable
              as TimeOfDay?,
    ));
  }
}

// dart format on

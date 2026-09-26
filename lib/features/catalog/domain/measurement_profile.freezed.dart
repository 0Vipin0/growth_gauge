// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseMeasurementProfile {
  MetricType get defaultMetricType;
  List<MetricType> get supportedMetricTypes;
  bool get supportsWeight;
  bool get supportsReps;
  bool get supportsDuration;
  bool get supportsDistance;
  bool get supportsCalories;
  bool get supportsRpe;
  bool get supportsRir;
  bool get supportsTempo;

  /// Create a copy of ExerciseMeasurementProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseMeasurementProfileCopyWith<ExerciseMeasurementProfile>
      get copyWith =>
          _$ExerciseMeasurementProfileCopyWithImpl<ExerciseMeasurementProfile>(
              this as ExerciseMeasurementProfile, _$identity);

  /// Serializes this ExerciseMeasurementProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExerciseMeasurementProfile &&
            (identical(other.defaultMetricType, defaultMetricType) ||
                other.defaultMetricType == defaultMetricType) &&
            const DeepCollectionEquality()
                .equals(other.supportedMetricTypes, supportedMetricTypes) &&
            (identical(other.supportsWeight, supportsWeight) ||
                other.supportsWeight == supportsWeight) &&
            (identical(other.supportsReps, supportsReps) ||
                other.supportsReps == supportsReps) &&
            (identical(other.supportsDuration, supportsDuration) ||
                other.supportsDuration == supportsDuration) &&
            (identical(other.supportsDistance, supportsDistance) ||
                other.supportsDistance == supportsDistance) &&
            (identical(other.supportsCalories, supportsCalories) ||
                other.supportsCalories == supportsCalories) &&
            (identical(other.supportsRpe, supportsRpe) ||
                other.supportsRpe == supportsRpe) &&
            (identical(other.supportsRir, supportsRir) ||
                other.supportsRir == supportsRir) &&
            (identical(other.supportsTempo, supportsTempo) ||
                other.supportsTempo == supportsTempo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultMetricType,
      const DeepCollectionEquality().hash(supportedMetricTypes),
      supportsWeight,
      supportsReps,
      supportsDuration,
      supportsDistance,
      supportsCalories,
      supportsRpe,
      supportsRir,
      supportsTempo);

  @override
  String toString() {
    return 'ExerciseMeasurementProfile(defaultMetricType: $defaultMetricType, supportedMetricTypes: $supportedMetricTypes, supportsWeight: $supportsWeight, supportsReps: $supportsReps, supportsDuration: $supportsDuration, supportsDistance: $supportsDistance, supportsCalories: $supportsCalories, supportsRpe: $supportsRpe, supportsRir: $supportsRir, supportsTempo: $supportsTempo)';
  }
}

/// @nodoc
abstract mixin class $ExerciseMeasurementProfileCopyWith<$Res> {
  factory $ExerciseMeasurementProfileCopyWith(ExerciseMeasurementProfile value,
          $Res Function(ExerciseMeasurementProfile) _then) =
      _$ExerciseMeasurementProfileCopyWithImpl;
  @useResult
  $Res call(
      {MetricType defaultMetricType,
      List<MetricType> supportedMetricTypes,
      bool supportsWeight,
      bool supportsReps,
      bool supportsDuration,
      bool supportsDistance,
      bool supportsCalories,
      bool supportsRpe,
      bool supportsRir,
      bool supportsTempo});
}

/// @nodoc
class _$ExerciseMeasurementProfileCopyWithImpl<$Res>
    implements $ExerciseMeasurementProfileCopyWith<$Res> {
  _$ExerciseMeasurementProfileCopyWithImpl(this._self, this._then);

  final ExerciseMeasurementProfile _self;
  final $Res Function(ExerciseMeasurementProfile) _then;

  /// Create a copy of ExerciseMeasurementProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultMetricType = null,
    Object? supportedMetricTypes = null,
    Object? supportsWeight = null,
    Object? supportsReps = null,
    Object? supportsDuration = null,
    Object? supportsDistance = null,
    Object? supportsCalories = null,
    Object? supportsRpe = null,
    Object? supportsRir = null,
    Object? supportsTempo = null,
  }) {
    return _then(_self.copyWith(
      defaultMetricType: null == defaultMetricType
          ? _self.defaultMetricType
          : defaultMetricType // ignore: cast_nullable_to_non_nullable
              as MetricType,
      supportedMetricTypes: null == supportedMetricTypes
          ? _self.supportedMetricTypes
          : supportedMetricTypes // ignore: cast_nullable_to_non_nullable
              as List<MetricType>,
      supportsWeight: null == supportsWeight
          ? _self.supportsWeight
          : supportsWeight // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsReps: null == supportsReps
          ? _self.supportsReps
          : supportsReps // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsDuration: null == supportsDuration
          ? _self.supportsDuration
          : supportsDuration // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsDistance: null == supportsDistance
          ? _self.supportsDistance
          : supportsDistance // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsCalories: null == supportsCalories
          ? _self.supportsCalories
          : supportsCalories // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsRpe: null == supportsRpe
          ? _self.supportsRpe
          : supportsRpe // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsRir: null == supportsRir
          ? _self.supportsRir
          : supportsRir // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsTempo: null == supportsTempo
          ? _self.supportsTempo
          : supportsTempo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExerciseMeasurementProfile].
extension ExerciseMeasurementProfilePatterns on ExerciseMeasurementProfile {
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
    TResult Function(_ExerciseMeasurementProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseMeasurementProfile() when $default != null:
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
    TResult Function(_ExerciseMeasurementProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseMeasurementProfile():
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
    TResult? Function(_ExerciseMeasurementProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseMeasurementProfile() when $default != null:
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
            MetricType defaultMetricType,
            List<MetricType> supportedMetricTypes,
            bool supportsWeight,
            bool supportsReps,
            bool supportsDuration,
            bool supportsDistance,
            bool supportsCalories,
            bool supportsRpe,
            bool supportsRir,
            bool supportsTempo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseMeasurementProfile() when $default != null:
        return $default(
            _that.defaultMetricType,
            _that.supportedMetricTypes,
            _that.supportsWeight,
            _that.supportsReps,
            _that.supportsDuration,
            _that.supportsDistance,
            _that.supportsCalories,
            _that.supportsRpe,
            _that.supportsRir,
            _that.supportsTempo);
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
            MetricType defaultMetricType,
            List<MetricType> supportedMetricTypes,
            bool supportsWeight,
            bool supportsReps,
            bool supportsDuration,
            bool supportsDistance,
            bool supportsCalories,
            bool supportsRpe,
            bool supportsRir,
            bool supportsTempo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseMeasurementProfile():
        return $default(
            _that.defaultMetricType,
            _that.supportedMetricTypes,
            _that.supportsWeight,
            _that.supportsReps,
            _that.supportsDuration,
            _that.supportsDistance,
            _that.supportsCalories,
            _that.supportsRpe,
            _that.supportsRir,
            _that.supportsTempo);
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
            MetricType defaultMetricType,
            List<MetricType> supportedMetricTypes,
            bool supportsWeight,
            bool supportsReps,
            bool supportsDuration,
            bool supportsDistance,
            bool supportsCalories,
            bool supportsRpe,
            bool supportsRir,
            bool supportsTempo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseMeasurementProfile() when $default != null:
        return $default(
            _that.defaultMetricType,
            _that.supportedMetricTypes,
            _that.supportsWeight,
            _that.supportsReps,
            _that.supportsDuration,
            _that.supportsDistance,
            _that.supportsCalories,
            _that.supportsRpe,
            _that.supportsRir,
            _that.supportsTempo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExerciseMeasurementProfile implements ExerciseMeasurementProfile {
  const _ExerciseMeasurementProfile(
      {this.defaultMetricType = MetricType.weightAndReps,
      final List<MetricType> supportedMetricTypes = const [
        MetricType.weightAndReps
      ],
      this.supportsWeight = true,
      this.supportsReps = true,
      this.supportsDuration = false,
      this.supportsDistance = false,
      this.supportsCalories = false,
      this.supportsRpe = true,
      this.supportsRir = true,
      this.supportsTempo = false})
      : _supportedMetricTypes = supportedMetricTypes;
  factory _ExerciseMeasurementProfile.fromJson(Map<String, dynamic> json) =>
      _$ExerciseMeasurementProfileFromJson(json);

  @override
  @JsonKey()
  final MetricType defaultMetricType;
  final List<MetricType> _supportedMetricTypes;
  @override
  @JsonKey()
  List<MetricType> get supportedMetricTypes {
    if (_supportedMetricTypes is EqualUnmodifiableListView)
      return _supportedMetricTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedMetricTypes);
  }

  @override
  @JsonKey()
  final bool supportsWeight;
  @override
  @JsonKey()
  final bool supportsReps;
  @override
  @JsonKey()
  final bool supportsDuration;
  @override
  @JsonKey()
  final bool supportsDistance;
  @override
  @JsonKey()
  final bool supportsCalories;
  @override
  @JsonKey()
  final bool supportsRpe;
  @override
  @JsonKey()
  final bool supportsRir;
  @override
  @JsonKey()
  final bool supportsTempo;

  /// Create a copy of ExerciseMeasurementProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseMeasurementProfileCopyWith<_ExerciseMeasurementProfile>
      get copyWith => __$ExerciseMeasurementProfileCopyWithImpl<
          _ExerciseMeasurementProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExerciseMeasurementProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExerciseMeasurementProfile &&
            (identical(other.defaultMetricType, defaultMetricType) ||
                other.defaultMetricType == defaultMetricType) &&
            const DeepCollectionEquality()
                .equals(other._supportedMetricTypes, _supportedMetricTypes) &&
            (identical(other.supportsWeight, supportsWeight) ||
                other.supportsWeight == supportsWeight) &&
            (identical(other.supportsReps, supportsReps) ||
                other.supportsReps == supportsReps) &&
            (identical(other.supportsDuration, supportsDuration) ||
                other.supportsDuration == supportsDuration) &&
            (identical(other.supportsDistance, supportsDistance) ||
                other.supportsDistance == supportsDistance) &&
            (identical(other.supportsCalories, supportsCalories) ||
                other.supportsCalories == supportsCalories) &&
            (identical(other.supportsRpe, supportsRpe) ||
                other.supportsRpe == supportsRpe) &&
            (identical(other.supportsRir, supportsRir) ||
                other.supportsRir == supportsRir) &&
            (identical(other.supportsTempo, supportsTempo) ||
                other.supportsTempo == supportsTempo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      defaultMetricType,
      const DeepCollectionEquality().hash(_supportedMetricTypes),
      supportsWeight,
      supportsReps,
      supportsDuration,
      supportsDistance,
      supportsCalories,
      supportsRpe,
      supportsRir,
      supportsTempo);

  @override
  String toString() {
    return 'ExerciseMeasurementProfile(defaultMetricType: $defaultMetricType, supportedMetricTypes: $supportedMetricTypes, supportsWeight: $supportsWeight, supportsReps: $supportsReps, supportsDuration: $supportsDuration, supportsDistance: $supportsDistance, supportsCalories: $supportsCalories, supportsRpe: $supportsRpe, supportsRir: $supportsRir, supportsTempo: $supportsTempo)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseMeasurementProfileCopyWith<$Res>
    implements $ExerciseMeasurementProfileCopyWith<$Res> {
  factory _$ExerciseMeasurementProfileCopyWith(
          _ExerciseMeasurementProfile value,
          $Res Function(_ExerciseMeasurementProfile) _then) =
      __$ExerciseMeasurementProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {MetricType defaultMetricType,
      List<MetricType> supportedMetricTypes,
      bool supportsWeight,
      bool supportsReps,
      bool supportsDuration,
      bool supportsDistance,
      bool supportsCalories,
      bool supportsRpe,
      bool supportsRir,
      bool supportsTempo});
}

/// @nodoc
class __$ExerciseMeasurementProfileCopyWithImpl<$Res>
    implements _$ExerciseMeasurementProfileCopyWith<$Res> {
  __$ExerciseMeasurementProfileCopyWithImpl(this._self, this._then);

  final _ExerciseMeasurementProfile _self;
  final $Res Function(_ExerciseMeasurementProfile) _then;

  /// Create a copy of ExerciseMeasurementProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? defaultMetricType = null,
    Object? supportedMetricTypes = null,
    Object? supportsWeight = null,
    Object? supportsReps = null,
    Object? supportsDuration = null,
    Object? supportsDistance = null,
    Object? supportsCalories = null,
    Object? supportsRpe = null,
    Object? supportsRir = null,
    Object? supportsTempo = null,
  }) {
    return _then(_ExerciseMeasurementProfile(
      defaultMetricType: null == defaultMetricType
          ? _self.defaultMetricType
          : defaultMetricType // ignore: cast_nullable_to_non_nullable
              as MetricType,
      supportedMetricTypes: null == supportedMetricTypes
          ? _self._supportedMetricTypes
          : supportedMetricTypes // ignore: cast_nullable_to_non_nullable
              as List<MetricType>,
      supportsWeight: null == supportsWeight
          ? _self.supportsWeight
          : supportsWeight // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsReps: null == supportsReps
          ? _self.supportsReps
          : supportsReps // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsDuration: null == supportsDuration
          ? _self.supportsDuration
          : supportsDuration // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsDistance: null == supportsDistance
          ? _self.supportsDistance
          : supportsDistance // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsCalories: null == supportsCalories
          ? _self.supportsCalories
          : supportsCalories // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsRpe: null == supportsRpe
          ? _self.supportsRpe
          : supportsRpe // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsRir: null == supportsRir
          ? _self.supportsRir
          : supportsRir // ignore: cast_nullable_to_non_nullable
              as bool,
      supportsTempo: null == supportsTempo
          ? _self.supportsTempo
          : supportsTempo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on

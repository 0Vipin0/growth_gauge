// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_classification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseClassification {
  List<BodyRegion> get bodyRegions;
  List<MuscleGroup> get primaryMuscles;
  List<MuscleGroup> get secondaryMuscles;
  List<MovementPattern> get movementPatterns;
  String get laterality;

  /// Create a copy of ExerciseClassification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseClassificationCopyWith<ExerciseClassification> get copyWith =>
      _$ExerciseClassificationCopyWithImpl<ExerciseClassification>(
          this as ExerciseClassification, _$identity);

  /// Serializes this ExerciseClassification to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExerciseClassification &&
            const DeepCollectionEquality()
                .equals(other.bodyRegions, bodyRegions) &&
            const DeepCollectionEquality()
                .equals(other.primaryMuscles, primaryMuscles) &&
            const DeepCollectionEquality()
                .equals(other.secondaryMuscles, secondaryMuscles) &&
            const DeepCollectionEquality()
                .equals(other.movementPatterns, movementPatterns) &&
            (identical(other.laterality, laterality) ||
                other.laterality == laterality));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(bodyRegions),
      const DeepCollectionEquality().hash(primaryMuscles),
      const DeepCollectionEquality().hash(secondaryMuscles),
      const DeepCollectionEquality().hash(movementPatterns),
      laterality);

  @override
  String toString() {
    return 'ExerciseClassification(bodyRegions: $bodyRegions, primaryMuscles: $primaryMuscles, secondaryMuscles: $secondaryMuscles, movementPatterns: $movementPatterns, laterality: $laterality)';
  }
}

/// @nodoc
abstract mixin class $ExerciseClassificationCopyWith<$Res> {
  factory $ExerciseClassificationCopyWith(ExerciseClassification value,
          $Res Function(ExerciseClassification) _then) =
      _$ExerciseClassificationCopyWithImpl;
  @useResult
  $Res call(
      {List<BodyRegion> bodyRegions,
      List<MuscleGroup> primaryMuscles,
      List<MuscleGroup> secondaryMuscles,
      List<MovementPattern> movementPatterns,
      String laterality});
}

/// @nodoc
class _$ExerciseClassificationCopyWithImpl<$Res>
    implements $ExerciseClassificationCopyWith<$Res> {
  _$ExerciseClassificationCopyWithImpl(this._self, this._then);

  final ExerciseClassification _self;
  final $Res Function(ExerciseClassification) _then;

  /// Create a copy of ExerciseClassification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bodyRegions = null,
    Object? primaryMuscles = null,
    Object? secondaryMuscles = null,
    Object? movementPatterns = null,
    Object? laterality = null,
  }) {
    return _then(_self.copyWith(
      bodyRegions: null == bodyRegions
          ? _self.bodyRegions
          : bodyRegions // ignore: cast_nullable_to_non_nullable
              as List<BodyRegion>,
      primaryMuscles: null == primaryMuscles
          ? _self.primaryMuscles
          : primaryMuscles // ignore: cast_nullable_to_non_nullable
              as List<MuscleGroup>,
      secondaryMuscles: null == secondaryMuscles
          ? _self.secondaryMuscles
          : secondaryMuscles // ignore: cast_nullable_to_non_nullable
              as List<MuscleGroup>,
      movementPatterns: null == movementPatterns
          ? _self.movementPatterns
          : movementPatterns // ignore: cast_nullable_to_non_nullable
              as List<MovementPattern>,
      laterality: null == laterality
          ? _self.laterality
          : laterality // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExerciseClassification].
extension ExerciseClassificationPatterns on ExerciseClassification {
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
    TResult Function(_ExerciseClassification value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseClassification() when $default != null:
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
    TResult Function(_ExerciseClassification value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseClassification():
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
    TResult? Function(_ExerciseClassification value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseClassification() when $default != null:
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
            List<BodyRegion> bodyRegions,
            List<MuscleGroup> primaryMuscles,
            List<MuscleGroup> secondaryMuscles,
            List<MovementPattern> movementPatterns,
            String laterality)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseClassification() when $default != null:
        return $default(_that.bodyRegions, _that.primaryMuscles,
            _that.secondaryMuscles, _that.movementPatterns, _that.laterality);
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
            List<BodyRegion> bodyRegions,
            List<MuscleGroup> primaryMuscles,
            List<MuscleGroup> secondaryMuscles,
            List<MovementPattern> movementPatterns,
            String laterality)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseClassification():
        return $default(_that.bodyRegions, _that.primaryMuscles,
            _that.secondaryMuscles, _that.movementPatterns, _that.laterality);
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
            List<BodyRegion> bodyRegions,
            List<MuscleGroup> primaryMuscles,
            List<MuscleGroup> secondaryMuscles,
            List<MovementPattern> movementPatterns,
            String laterality)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseClassification() when $default != null:
        return $default(_that.bodyRegions, _that.primaryMuscles,
            _that.secondaryMuscles, _that.movementPatterns, _that.laterality);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExerciseClassification implements ExerciseClassification {
  const _ExerciseClassification(
      {final List<BodyRegion> bodyRegions = const [],
      final List<MuscleGroup> primaryMuscles = const [],
      final List<MuscleGroup> secondaryMuscles = const [],
      final List<MovementPattern> movementPatterns = const [],
      this.laterality = 'BILATERAL'})
      : _bodyRegions = bodyRegions,
        _primaryMuscles = primaryMuscles,
        _secondaryMuscles = secondaryMuscles,
        _movementPatterns = movementPatterns;
  factory _ExerciseClassification.fromJson(Map<String, dynamic> json) =>
      _$ExerciseClassificationFromJson(json);

  final List<BodyRegion> _bodyRegions;
  @override
  @JsonKey()
  List<BodyRegion> get bodyRegions {
    if (_bodyRegions is EqualUnmodifiableListView) return _bodyRegions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bodyRegions);
  }

  final List<MuscleGroup> _primaryMuscles;
  @override
  @JsonKey()
  List<MuscleGroup> get primaryMuscles {
    if (_primaryMuscles is EqualUnmodifiableListView) return _primaryMuscles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_primaryMuscles);
  }

  final List<MuscleGroup> _secondaryMuscles;
  @override
  @JsonKey()
  List<MuscleGroup> get secondaryMuscles {
    if (_secondaryMuscles is EqualUnmodifiableListView)
      return _secondaryMuscles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_secondaryMuscles);
  }

  final List<MovementPattern> _movementPatterns;
  @override
  @JsonKey()
  List<MovementPattern> get movementPatterns {
    if (_movementPatterns is EqualUnmodifiableListView)
      return _movementPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movementPatterns);
  }

  @override
  @JsonKey()
  final String laterality;

  /// Create a copy of ExerciseClassification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseClassificationCopyWith<_ExerciseClassification> get copyWith =>
      __$ExerciseClassificationCopyWithImpl<_ExerciseClassification>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExerciseClassificationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExerciseClassification &&
            const DeepCollectionEquality()
                .equals(other._bodyRegions, _bodyRegions) &&
            const DeepCollectionEquality()
                .equals(other._primaryMuscles, _primaryMuscles) &&
            const DeepCollectionEquality()
                .equals(other._secondaryMuscles, _secondaryMuscles) &&
            const DeepCollectionEquality()
                .equals(other._movementPatterns, _movementPatterns) &&
            (identical(other.laterality, laterality) ||
                other.laterality == laterality));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_bodyRegions),
      const DeepCollectionEquality().hash(_primaryMuscles),
      const DeepCollectionEquality().hash(_secondaryMuscles),
      const DeepCollectionEquality().hash(_movementPatterns),
      laterality);

  @override
  String toString() {
    return 'ExerciseClassification(bodyRegions: $bodyRegions, primaryMuscles: $primaryMuscles, secondaryMuscles: $secondaryMuscles, movementPatterns: $movementPatterns, laterality: $laterality)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseClassificationCopyWith<$Res>
    implements $ExerciseClassificationCopyWith<$Res> {
  factory _$ExerciseClassificationCopyWith(_ExerciseClassification value,
          $Res Function(_ExerciseClassification) _then) =
      __$ExerciseClassificationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<BodyRegion> bodyRegions,
      List<MuscleGroup> primaryMuscles,
      List<MuscleGroup> secondaryMuscles,
      List<MovementPattern> movementPatterns,
      String laterality});
}

/// @nodoc
class __$ExerciseClassificationCopyWithImpl<$Res>
    implements _$ExerciseClassificationCopyWith<$Res> {
  __$ExerciseClassificationCopyWithImpl(this._self, this._then);

  final _ExerciseClassification _self;
  final $Res Function(_ExerciseClassification) _then;

  /// Create a copy of ExerciseClassification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? bodyRegions = null,
    Object? primaryMuscles = null,
    Object? secondaryMuscles = null,
    Object? movementPatterns = null,
    Object? laterality = null,
  }) {
    return _then(_ExerciseClassification(
      bodyRegions: null == bodyRegions
          ? _self._bodyRegions
          : bodyRegions // ignore: cast_nullable_to_non_nullable
              as List<BodyRegion>,
      primaryMuscles: null == primaryMuscles
          ? _self._primaryMuscles
          : primaryMuscles // ignore: cast_nullable_to_non_nullable
              as List<MuscleGroup>,
      secondaryMuscles: null == secondaryMuscles
          ? _self._secondaryMuscles
          : secondaryMuscles // ignore: cast_nullable_to_non_nullable
              as List<MuscleGroup>,
      movementPatterns: null == movementPatterns
          ? _self._movementPatterns
          : movementPatterns // ignore: cast_nullable_to_non_nullable
              as List<MovementPattern>,
      laterality: null == laterality
          ? _self.laterality
          : laterality // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on

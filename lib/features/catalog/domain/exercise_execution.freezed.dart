// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_execution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseExecutionProfile {
  List<String> get setupInstructions;
  List<String> get executionInstructions;
  String? get breathingInstructions;
  List<String> get techniqueCues;
  String? get tempo;
  String? get rangeOfMotion;

  /// Create a copy of ExerciseExecutionProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseExecutionProfileCopyWith<ExerciseExecutionProfile> get copyWith =>
      _$ExerciseExecutionProfileCopyWithImpl<ExerciseExecutionProfile>(
          this as ExerciseExecutionProfile, _$identity);

  /// Serializes this ExerciseExecutionProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExerciseExecutionProfile &&
            const DeepCollectionEquality()
                .equals(other.setupInstructions, setupInstructions) &&
            const DeepCollectionEquality()
                .equals(other.executionInstructions, executionInstructions) &&
            (identical(other.breathingInstructions, breathingInstructions) ||
                other.breathingInstructions == breathingInstructions) &&
            const DeepCollectionEquality()
                .equals(other.techniqueCues, techniqueCues) &&
            (identical(other.tempo, tempo) || other.tempo == tempo) &&
            (identical(other.rangeOfMotion, rangeOfMotion) ||
                other.rangeOfMotion == rangeOfMotion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(setupInstructions),
      const DeepCollectionEquality().hash(executionInstructions),
      breathingInstructions,
      const DeepCollectionEquality().hash(techniqueCues),
      tempo,
      rangeOfMotion);

  @override
  String toString() {
    return 'ExerciseExecutionProfile(setupInstructions: $setupInstructions, executionInstructions: $executionInstructions, breathingInstructions: $breathingInstructions, techniqueCues: $techniqueCues, tempo: $tempo, rangeOfMotion: $rangeOfMotion)';
  }
}

/// @nodoc
abstract mixin class $ExerciseExecutionProfileCopyWith<$Res> {
  factory $ExerciseExecutionProfileCopyWith(ExerciseExecutionProfile value,
          $Res Function(ExerciseExecutionProfile) _then) =
      _$ExerciseExecutionProfileCopyWithImpl;
  @useResult
  $Res call(
      {List<String> setupInstructions,
      List<String> executionInstructions,
      String? breathingInstructions,
      List<String> techniqueCues,
      String? tempo,
      String? rangeOfMotion});
}

/// @nodoc
class _$ExerciseExecutionProfileCopyWithImpl<$Res>
    implements $ExerciseExecutionProfileCopyWith<$Res> {
  _$ExerciseExecutionProfileCopyWithImpl(this._self, this._then);

  final ExerciseExecutionProfile _self;
  final $Res Function(ExerciseExecutionProfile) _then;

  /// Create a copy of ExerciseExecutionProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setupInstructions = null,
    Object? executionInstructions = null,
    Object? breathingInstructions = freezed,
    Object? techniqueCues = null,
    Object? tempo = freezed,
    Object? rangeOfMotion = freezed,
  }) {
    return _then(_self.copyWith(
      setupInstructions: null == setupInstructions
          ? _self.setupInstructions
          : setupInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      executionInstructions: null == executionInstructions
          ? _self.executionInstructions
          : executionInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      breathingInstructions: freezed == breathingInstructions
          ? _self.breathingInstructions
          : breathingInstructions // ignore: cast_nullable_to_non_nullable
              as String?,
      techniqueCues: null == techniqueCues
          ? _self.techniqueCues
          : techniqueCues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tempo: freezed == tempo
          ? _self.tempo
          : tempo // ignore: cast_nullable_to_non_nullable
              as String?,
      rangeOfMotion: freezed == rangeOfMotion
          ? _self.rangeOfMotion
          : rangeOfMotion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExerciseExecutionProfile].
extension ExerciseExecutionProfilePatterns on ExerciseExecutionProfile {
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
    TResult Function(_ExerciseExecutionProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseExecutionProfile() when $default != null:
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
    TResult Function(_ExerciseExecutionProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseExecutionProfile():
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
    TResult? Function(_ExerciseExecutionProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseExecutionProfile() when $default != null:
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
            List<String> setupInstructions,
            List<String> executionInstructions,
            String? breathingInstructions,
            List<String> techniqueCues,
            String? tempo,
            String? rangeOfMotion)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseExecutionProfile() when $default != null:
        return $default(
            _that.setupInstructions,
            _that.executionInstructions,
            _that.breathingInstructions,
            _that.techniqueCues,
            _that.tempo,
            _that.rangeOfMotion);
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
            List<String> setupInstructions,
            List<String> executionInstructions,
            String? breathingInstructions,
            List<String> techniqueCues,
            String? tempo,
            String? rangeOfMotion)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseExecutionProfile():
        return $default(
            _that.setupInstructions,
            _that.executionInstructions,
            _that.breathingInstructions,
            _that.techniqueCues,
            _that.tempo,
            _that.rangeOfMotion);
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
            List<String> setupInstructions,
            List<String> executionInstructions,
            String? breathingInstructions,
            List<String> techniqueCues,
            String? tempo,
            String? rangeOfMotion)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseExecutionProfile() when $default != null:
        return $default(
            _that.setupInstructions,
            _that.executionInstructions,
            _that.breathingInstructions,
            _that.techniqueCues,
            _that.tempo,
            _that.rangeOfMotion);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExerciseExecutionProfile implements ExerciseExecutionProfile {
  const _ExerciseExecutionProfile(
      {final List<String> setupInstructions = const [],
      final List<String> executionInstructions = const [],
      this.breathingInstructions,
      final List<String> techniqueCues = const [],
      this.tempo,
      this.rangeOfMotion})
      : _setupInstructions = setupInstructions,
        _executionInstructions = executionInstructions,
        _techniqueCues = techniqueCues;
  factory _ExerciseExecutionProfile.fromJson(Map<String, dynamic> json) =>
      _$ExerciseExecutionProfileFromJson(json);

  final List<String> _setupInstructions;
  @override
  @JsonKey()
  List<String> get setupInstructions {
    if (_setupInstructions is EqualUnmodifiableListView)
      return _setupInstructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_setupInstructions);
  }

  final List<String> _executionInstructions;
  @override
  @JsonKey()
  List<String> get executionInstructions {
    if (_executionInstructions is EqualUnmodifiableListView)
      return _executionInstructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_executionInstructions);
  }

  @override
  final String? breathingInstructions;
  final List<String> _techniqueCues;
  @override
  @JsonKey()
  List<String> get techniqueCues {
    if (_techniqueCues is EqualUnmodifiableListView) return _techniqueCues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techniqueCues);
  }

  @override
  final String? tempo;
  @override
  final String? rangeOfMotion;

  /// Create a copy of ExerciseExecutionProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseExecutionProfileCopyWith<_ExerciseExecutionProfile> get copyWith =>
      __$ExerciseExecutionProfileCopyWithImpl<_ExerciseExecutionProfile>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExerciseExecutionProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExerciseExecutionProfile &&
            const DeepCollectionEquality()
                .equals(other._setupInstructions, _setupInstructions) &&
            const DeepCollectionEquality()
                .equals(other._executionInstructions, _executionInstructions) &&
            (identical(other.breathingInstructions, breathingInstructions) ||
                other.breathingInstructions == breathingInstructions) &&
            const DeepCollectionEquality()
                .equals(other._techniqueCues, _techniqueCues) &&
            (identical(other.tempo, tempo) || other.tempo == tempo) &&
            (identical(other.rangeOfMotion, rangeOfMotion) ||
                other.rangeOfMotion == rangeOfMotion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_setupInstructions),
      const DeepCollectionEquality().hash(_executionInstructions),
      breathingInstructions,
      const DeepCollectionEquality().hash(_techniqueCues),
      tempo,
      rangeOfMotion);

  @override
  String toString() {
    return 'ExerciseExecutionProfile(setupInstructions: $setupInstructions, executionInstructions: $executionInstructions, breathingInstructions: $breathingInstructions, techniqueCues: $techniqueCues, tempo: $tempo, rangeOfMotion: $rangeOfMotion)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseExecutionProfileCopyWith<$Res>
    implements $ExerciseExecutionProfileCopyWith<$Res> {
  factory _$ExerciseExecutionProfileCopyWith(_ExerciseExecutionProfile value,
          $Res Function(_ExerciseExecutionProfile) _then) =
      __$ExerciseExecutionProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<String> setupInstructions,
      List<String> executionInstructions,
      String? breathingInstructions,
      List<String> techniqueCues,
      String? tempo,
      String? rangeOfMotion});
}

/// @nodoc
class __$ExerciseExecutionProfileCopyWithImpl<$Res>
    implements _$ExerciseExecutionProfileCopyWith<$Res> {
  __$ExerciseExecutionProfileCopyWithImpl(this._self, this._then);

  final _ExerciseExecutionProfile _self;
  final $Res Function(_ExerciseExecutionProfile) _then;

  /// Create a copy of ExerciseExecutionProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? setupInstructions = null,
    Object? executionInstructions = null,
    Object? breathingInstructions = freezed,
    Object? techniqueCues = null,
    Object? tempo = freezed,
    Object? rangeOfMotion = freezed,
  }) {
    return _then(_ExerciseExecutionProfile(
      setupInstructions: null == setupInstructions
          ? _self._setupInstructions
          : setupInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      executionInstructions: null == executionInstructions
          ? _self._executionInstructions
          : executionInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      breathingInstructions: freezed == breathingInstructions
          ? _self.breathingInstructions
          : breathingInstructions // ignore: cast_nullable_to_non_nullable
              as String?,
      techniqueCues: null == techniqueCues
          ? _self._techniqueCues
          : techniqueCues // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tempo: freezed == tempo
          ? _self.tempo
          : tempo // ignore: cast_nullable_to_non_nullable
              as String?,
      rangeOfMotion: freezed == rangeOfMotion
          ? _self.rangeOfMotion
          : rangeOfMotion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

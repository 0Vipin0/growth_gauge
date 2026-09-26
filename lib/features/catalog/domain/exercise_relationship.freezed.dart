// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_relationship.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseRelationship {
  String get sourceExerciseId;
  String get targetExerciseId;
  RelationshipType get type;
  String? get reason;

  /// Create a copy of ExerciseRelationship
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseRelationshipCopyWith<ExerciseRelationship> get copyWith =>
      _$ExerciseRelationshipCopyWithImpl<ExerciseRelationship>(
          this as ExerciseRelationship, _$identity);

  /// Serializes this ExerciseRelationship to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExerciseRelationship &&
            (identical(other.sourceExerciseId, sourceExerciseId) ||
                other.sourceExerciseId == sourceExerciseId) &&
            (identical(other.targetExerciseId, targetExerciseId) ||
                other.targetExerciseId == targetExerciseId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sourceExerciseId, targetExerciseId, type, reason);

  @override
  String toString() {
    return 'ExerciseRelationship(sourceExerciseId: $sourceExerciseId, targetExerciseId: $targetExerciseId, type: $type, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class $ExerciseRelationshipCopyWith<$Res> {
  factory $ExerciseRelationshipCopyWith(ExerciseRelationship value,
          $Res Function(ExerciseRelationship) _then) =
      _$ExerciseRelationshipCopyWithImpl;
  @useResult
  $Res call(
      {String sourceExerciseId,
      String targetExerciseId,
      RelationshipType type,
      String? reason});
}

/// @nodoc
class _$ExerciseRelationshipCopyWithImpl<$Res>
    implements $ExerciseRelationshipCopyWith<$Res> {
  _$ExerciseRelationshipCopyWithImpl(this._self, this._then);

  ExerciseRelationship _self;
  final $Res Function(ExerciseRelationship) _then;

  /// Create a copy of ExerciseRelationship
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sourceExerciseId = null,
    Object? targetExerciseId = null,
    Object? type = null,
    Object? reason = freezed,
  }) {
    return _then(_self.copyWith(
      sourceExerciseId: null == sourceExerciseId
          ? _self.sourceExerciseId
          : sourceExerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      targetExerciseId: null == targetExerciseId
          ? _self.targetExerciseId
          : targetExerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as RelationshipType,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExerciseRelationship].
extension ExerciseRelationshipPatterns on ExerciseRelationship {
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
    TResult Function(_ExerciseRelationship value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseRelationship() when $default != null:
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
    TResult Function(_ExerciseRelationship value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseRelationship():
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
    TResult? Function(_ExerciseRelationship value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseRelationship() when $default != null:
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
    TResult Function(String sourceExerciseId, String targetExerciseId,
            RelationshipType type, String? reason)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseRelationship() when $default != null:
        return $default(_that.sourceExerciseId, _that.targetExerciseId,
            _that.type, _that.reason);
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
    TResult Function(String sourceExerciseId, String targetExerciseId,
            RelationshipType type, String? reason)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseRelationship():
        return $default(_that.sourceExerciseId, _that.targetExerciseId,
            _that.type, _that.reason);
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
    TResult? Function(String sourceExerciseId, String targetExerciseId,
            RelationshipType type, String? reason)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseRelationship() when $default != null:
        return $default(_that.sourceExerciseId, _that.targetExerciseId,
            _that.type, _that.reason);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExerciseRelationship implements ExerciseRelationship {
  const _ExerciseRelationship(
      {required this.sourceExerciseId,
      required this.targetExerciseId,
      required this.type,
      this.reason});
  factory _ExerciseRelationship.fromJson(Map<String, dynamic> json) =>
      _$ExerciseRelationshipFromJson(json);

  @override
  final String sourceExerciseId;
  @override
  final String targetExerciseId;
  @override
  final RelationshipType type;
  @override
  final String? reason;

  /// Create a copy of ExerciseRelationship
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseRelationshipCopyWith<_ExerciseRelationship> get copyWith =>
      __$ExerciseRelationshipCopyWithImpl<_ExerciseRelationship>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExerciseRelationshipToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExerciseRelationship &&
            (identical(other.sourceExerciseId, sourceExerciseId) ||
                other.sourceExerciseId == sourceExerciseId) &&
            (identical(other.targetExerciseId, targetExerciseId) ||
                other.targetExerciseId == targetExerciseId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sourceExerciseId, targetExerciseId, type, reason);

  @override
  String toString() {
    return 'ExerciseRelationship(sourceExerciseId: $sourceExerciseId, targetExerciseId: $targetExerciseId, type: $type, reason: $reason)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseRelationshipCopyWith<$Res>
    implements $ExerciseRelationshipCopyWith<$Res> {
  factory _$ExerciseRelationshipCopyWith(_ExerciseRelationship value,
          $Res Function(_ExerciseRelationship) _then) =
      __$ExerciseRelationshipCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String sourceExerciseId,
      String targetExerciseId,
      RelationshipType type,
      String? reason});
}

/// @nodoc
class __$ExerciseRelationshipCopyWithImpl<$Res>
    implements _$ExerciseRelationshipCopyWith<$Res> {
  __$ExerciseRelationshipCopyWithImpl(this._self, this._then);

  final _ExerciseRelationship _self;
  final $Res Function(_ExerciseRelationship) _then;

  /// Create a copy of ExerciseRelationship
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? sourceExerciseId = null,
    Object? targetExerciseId = null,
    Object? type = null,
    Object? reason = freezed,
  }) {
    return _then(_ExerciseRelationship(
      sourceExerciseId: null == sourceExerciseId
          ? _self.sourceExerciseId
          : sourceExerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      targetExerciseId: null == targetExerciseId
          ? _self.targetExerciseId
          : targetExerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as RelationshipType,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TargetSet {
  String get id;
  int get setNumber;
  SetType get setType;
  double? get targetWeight; // Canonical kg
  int? get targetReps;
  int? get targetDurationSeconds;
  double? get targetDistanceMeters;
  int? get targetCalories;
  double? get targetRpe;
  int? get targetRir;
  double? get percentageOf1Rm;
  RestPolicy? get restPolicy;
  String? get notes;

  /// Create a copy of TargetSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TargetSetCopyWith<TargetSet> get copyWith =>
      _$TargetSetCopyWithImpl<TargetSet>(this as TargetSet, _$identity);

  /// Serializes this TargetSet to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TargetSet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.setNumber, setNumber) ||
                other.setNumber == setNumber) &&
            (identical(other.setType, setType) || other.setType == setType) &&
            (identical(other.targetWeight, targetWeight) ||
                other.targetWeight == targetWeight) &&
            (identical(other.targetReps, targetReps) ||
                other.targetReps == targetReps) &&
            (identical(other.targetDurationSeconds, targetDurationSeconds) ||
                other.targetDurationSeconds == targetDurationSeconds) &&
            (identical(other.targetDistanceMeters, targetDistanceMeters) ||
                other.targetDistanceMeters == targetDistanceMeters) &&
            (identical(other.targetCalories, targetCalories) ||
                other.targetCalories == targetCalories) &&
            (identical(other.targetRpe, targetRpe) ||
                other.targetRpe == targetRpe) &&
            (identical(other.targetRir, targetRir) ||
                other.targetRir == targetRir) &&
            (identical(other.percentageOf1Rm, percentageOf1Rm) ||
                other.percentageOf1Rm == percentageOf1Rm) &&
            (identical(other.restPolicy, restPolicy) ||
                other.restPolicy == restPolicy) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      setNumber,
      setType,
      targetWeight,
      targetReps,
      targetDurationSeconds,
      targetDistanceMeters,
      targetCalories,
      targetRpe,
      targetRir,
      percentageOf1Rm,
      restPolicy,
      notes);

  @override
  String toString() {
    return 'TargetSet(id: $id, setNumber: $setNumber, setType: $setType, targetWeight: $targetWeight, targetReps: $targetReps, targetDurationSeconds: $targetDurationSeconds, targetDistanceMeters: $targetDistanceMeters, targetCalories: $targetCalories, targetRpe: $targetRpe, targetRir: $targetRir, percentageOf1Rm: $percentageOf1Rm, restPolicy: $restPolicy, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $TargetSetCopyWith<$Res> {
  factory $TargetSetCopyWith(TargetSet value, $Res Function(TargetSet) _then) =
      _$TargetSetCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      int setNumber,
      SetType setType,
      double? targetWeight,
      int? targetReps,
      int? targetDurationSeconds,
      double? targetDistanceMeters,
      int? targetCalories,
      double? targetRpe,
      int? targetRir,
      double? percentageOf1Rm,
      RestPolicy? restPolicy,
      String? notes});

  $RestPolicyCopyWith<$Res>? get restPolicy;
}

/// @nodoc
class _$TargetSetCopyWithImpl<$Res> implements $TargetSetCopyWith<$Res> {
  _$TargetSetCopyWithImpl(this._self, this._then);

  final TargetSet _self;
  final $Res Function(TargetSet) _then;

  /// Create a copy of TargetSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? setNumber = null,
    Object? setType = null,
    Object? targetWeight = freezed,
    Object? targetReps = freezed,
    Object? targetDurationSeconds = freezed,
    Object? targetDistanceMeters = freezed,
    Object? targetCalories = freezed,
    Object? targetRpe = freezed,
    Object? targetRir = freezed,
    Object? percentageOf1Rm = freezed,
    Object? restPolicy = freezed,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      setNumber: null == setNumber
          ? _self.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      setType: null == setType
          ? _self.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as SetType,
      targetWeight: freezed == targetWeight
          ? _self.targetWeight
          : targetWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      targetReps: freezed == targetReps
          ? _self.targetReps
          : targetReps // ignore: cast_nullable_to_non_nullable
              as int?,
      targetDurationSeconds: freezed == targetDurationSeconds
          ? _self.targetDurationSeconds
          : targetDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      targetDistanceMeters: freezed == targetDistanceMeters
          ? _self.targetDistanceMeters
          : targetDistanceMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      targetCalories: freezed == targetCalories
          ? _self.targetCalories
          : targetCalories // ignore: cast_nullable_to_non_nullable
              as int?,
      targetRpe: freezed == targetRpe
          ? _self.targetRpe
          : targetRpe // ignore: cast_nullable_to_non_nullable
              as double?,
      targetRir: freezed == targetRir
          ? _self.targetRir
          : targetRir // ignore: cast_nullable_to_non_nullable
              as int?,
      percentageOf1Rm: freezed == percentageOf1Rm
          ? _self.percentageOf1Rm
          : percentageOf1Rm // ignore: cast_nullable_to_non_nullable
              as double?,
      restPolicy: freezed == restPolicy
          ? _self.restPolicy
          : restPolicy // ignore: cast_nullable_to_non_nullable
              as RestPolicy?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TargetSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RestPolicyCopyWith<$Res>? get restPolicy {
    if (_self.restPolicy == null) {
      return null;
    }

    return $RestPolicyCopyWith<$Res>(_self.restPolicy!, (value) {
      return _then(_self.copyWith(restPolicy: value));
    });
  }
}

/// Adds pattern-matching-related methods to [TargetSet].
extension TargetSetPatterns on TargetSet {
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
    TResult Function(_TargetSet value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TargetSet() when $default != null:
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
    TResult Function(_TargetSet value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TargetSet():
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
    TResult? Function(_TargetSet value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TargetSet() when $default != null:
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
            String id,
            int setNumber,
            SetType setType,
            double? targetWeight,
            int? targetReps,
            int? targetDurationSeconds,
            double? targetDistanceMeters,
            int? targetCalories,
            double? targetRpe,
            int? targetRir,
            double? percentageOf1Rm,
            RestPolicy? restPolicy,
            String? notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TargetSet() when $default != null:
        return $default(
            _that.id,
            _that.setNumber,
            _that.setType,
            _that.targetWeight,
            _that.targetReps,
            _that.targetDurationSeconds,
            _that.targetDistanceMeters,
            _that.targetCalories,
            _that.targetRpe,
            _that.targetRir,
            _that.percentageOf1Rm,
            _that.restPolicy,
            _that.notes);
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
            String id,
            int setNumber,
            SetType setType,
            double? targetWeight,
            int? targetReps,
            int? targetDurationSeconds,
            double? targetDistanceMeters,
            int? targetCalories,
            double? targetRpe,
            int? targetRir,
            double? percentageOf1Rm,
            RestPolicy? restPolicy,
            String? notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TargetSet():
        return $default(
            _that.id,
            _that.setNumber,
            _that.setType,
            _that.targetWeight,
            _that.targetReps,
            _that.targetDurationSeconds,
            _that.targetDistanceMeters,
            _that.targetCalories,
            _that.targetRpe,
            _that.targetRir,
            _that.percentageOf1Rm,
            _that.restPolicy,
            _that.notes);
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
            String id,
            int setNumber,
            SetType setType,
            double? targetWeight,
            int? targetReps,
            int? targetDurationSeconds,
            double? targetDistanceMeters,
            int? targetCalories,
            double? targetRpe,
            int? targetRir,
            double? percentageOf1Rm,
            RestPolicy? restPolicy,
            String? notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TargetSet() when $default != null:
        return $default(
            _that.id,
            _that.setNumber,
            _that.setType,
            _that.targetWeight,
            _that.targetReps,
            _that.targetDurationSeconds,
            _that.targetDistanceMeters,
            _that.targetCalories,
            _that.targetRpe,
            _that.targetRir,
            _that.percentageOf1Rm,
            _that.restPolicy,
            _that.notes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TargetSet implements TargetSet {
  const _TargetSet(
      {required this.id,
      required this.setNumber,
      this.setType = SetType.working,
      this.targetWeight,
      this.targetReps,
      this.targetDurationSeconds,
      this.targetDistanceMeters,
      this.targetCalories,
      this.targetRpe,
      this.targetRir,
      this.percentageOf1Rm,
      this.restPolicy,
      this.notes});
  factory _TargetSet.fromJson(Map<String, dynamic> json) =>
      _$TargetSetFromJson(json);

  @override
  final String id;
  @override
  final int setNumber;
  @override
  @JsonKey()
  final SetType setType;
  @override
  final double? targetWeight;
// Canonical kg
  @override
  final int? targetReps;
  @override
  final int? targetDurationSeconds;
  @override
  final double? targetDistanceMeters;
  @override
  final int? targetCalories;
  @override
  final double? targetRpe;
  @override
  final int? targetRir;
  @override
  final double? percentageOf1Rm;
  @override
  final RestPolicy? restPolicy;
  @override
  final String? notes;

  /// Create a copy of TargetSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TargetSetCopyWith<_TargetSet> get copyWith =>
      __$TargetSetCopyWithImpl<_TargetSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TargetSetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TargetSet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.setNumber, setNumber) ||
                other.setNumber == setNumber) &&
            (identical(other.setType, setType) || other.setType == setType) &&
            (identical(other.targetWeight, targetWeight) ||
                other.targetWeight == targetWeight) &&
            (identical(other.targetReps, targetReps) ||
                other.targetReps == targetReps) &&
            (identical(other.targetDurationSeconds, targetDurationSeconds) ||
                other.targetDurationSeconds == targetDurationSeconds) &&
            (identical(other.targetDistanceMeters, targetDistanceMeters) ||
                other.targetDistanceMeters == targetDistanceMeters) &&
            (identical(other.targetCalories, targetCalories) ||
                other.targetCalories == targetCalories) &&
            (identical(other.targetRpe, targetRpe) ||
                other.targetRpe == targetRpe) &&
            (identical(other.targetRir, targetRir) ||
                other.targetRir == targetRir) &&
            (identical(other.percentageOf1Rm, percentageOf1Rm) ||
                other.percentageOf1Rm == percentageOf1Rm) &&
            (identical(other.restPolicy, restPolicy) ||
                other.restPolicy == restPolicy) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      setNumber,
      setType,
      targetWeight,
      targetReps,
      targetDurationSeconds,
      targetDistanceMeters,
      targetCalories,
      targetRpe,
      targetRir,
      percentageOf1Rm,
      restPolicy,
      notes);

  @override
  String toString() {
    return 'TargetSet(id: $id, setNumber: $setNumber, setType: $setType, targetWeight: $targetWeight, targetReps: $targetReps, targetDurationSeconds: $targetDurationSeconds, targetDistanceMeters: $targetDistanceMeters, targetCalories: $targetCalories, targetRpe: $targetRpe, targetRir: $targetRir, percentageOf1Rm: $percentageOf1Rm, restPolicy: $restPolicy, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$TargetSetCopyWith<$Res>
    implements $TargetSetCopyWith<$Res> {
  factory _$TargetSetCopyWith(
          _TargetSet value, $Res Function(_TargetSet) _then) =
      __$TargetSetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      int setNumber,
      SetType setType,
      double? targetWeight,
      int? targetReps,
      int? targetDurationSeconds,
      double? targetDistanceMeters,
      int? targetCalories,
      double? targetRpe,
      int? targetRir,
      double? percentageOf1Rm,
      RestPolicy? restPolicy,
      String? notes});

  @override
  $RestPolicyCopyWith<$Res>? get restPolicy;
}

/// @nodoc
class __$TargetSetCopyWithImpl<$Res> implements _$TargetSetCopyWith<$Res> {
  __$TargetSetCopyWithImpl(this._self, this._then);

  final _TargetSet _self;
  final $Res Function(_TargetSet) _then;

  /// Create a copy of TargetSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? setNumber = null,
    Object? setType = null,
    Object? targetWeight = freezed,
    Object? targetReps = freezed,
    Object? targetDurationSeconds = freezed,
    Object? targetDistanceMeters = freezed,
    Object? targetCalories = freezed,
    Object? targetRpe = freezed,
    Object? targetRir = freezed,
    Object? percentageOf1Rm = freezed,
    Object? restPolicy = freezed,
    Object? notes = freezed,
  }) {
    return _then(_TargetSet(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      setNumber: null == setNumber
          ? _self.setNumber
          : setNumber // ignore: cast_nullable_to_non_nullable
              as int,
      setType: null == setType
          ? _self.setType
          : setType // ignore: cast_nullable_to_non_nullable
              as SetType,
      targetWeight: freezed == targetWeight
          ? _self.targetWeight
          : targetWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      targetReps: freezed == targetReps
          ? _self.targetReps
          : targetReps // ignore: cast_nullable_to_non_nullable
              as int?,
      targetDurationSeconds: freezed == targetDurationSeconds
          ? _self.targetDurationSeconds
          : targetDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      targetDistanceMeters: freezed == targetDistanceMeters
          ? _self.targetDistanceMeters
          : targetDistanceMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      targetCalories: freezed == targetCalories
          ? _self.targetCalories
          : targetCalories // ignore: cast_nullable_to_non_nullable
              as int?,
      targetRpe: freezed == targetRpe
          ? _self.targetRpe
          : targetRpe // ignore: cast_nullable_to_non_nullable
              as double?,
      targetRir: freezed == targetRir
          ? _self.targetRir
          : targetRir // ignore: cast_nullable_to_non_nullable
              as int?,
      percentageOf1Rm: freezed == percentageOf1Rm
          ? _self.percentageOf1Rm
          : percentageOf1Rm // ignore: cast_nullable_to_non_nullable
              as double?,
      restPolicy: freezed == restPolicy
          ? _self.restPolicy
          : restPolicy // ignore: cast_nullable_to_non_nullable
              as RestPolicy?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TargetSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RestPolicyCopyWith<$Res>? get restPolicy {
    if (_self.restPolicy == null) {
      return null;
    }

    return $RestPolicyCopyWith<$Res>(_self.restPolicy!, (value) {
      return _then(_self.copyWith(restPolicy: value));
    });
  }
}

// dart format on

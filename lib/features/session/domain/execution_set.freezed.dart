// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'execution_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExecutionSet {
  String get id;
  String? get sourceTemplateSetId;
  int get setNumber;
  SetType get setType;
  double? get targetWeight;
  int? get targetReps;
  int? get targetDurationSeconds;
  double? get targetDistanceMeters;
  int? get targetCalories;
  double? get targetRpe;
  int? get targetRir;
  double? get percentageOf1Rm;
  double? get actualWeight;
  int? get actualReps;
  int? get actualDurationSeconds;
  double? get actualDistanceMeters;
  int? get actualCalories;
  double? get rpe;
  int? get rir;
  DateTime? get startedAt;
  DateTime? get completedAt;
  ExecutionSetStatus get status;
  int get plannedRestSeconds;
  bool get restAutoStart;
  bool get restAllowSkip;
  bool get restAllowExtend;
  int? get restMinimumSeconds;
  int? get restMaximumSeconds;

  /// Sum of recorded actual durations for this set's rest intervals.
  int? get actualRestSeconds;
  String? get notes;

  /// Create a copy of ExecutionSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExecutionSetCopyWith<ExecutionSet> get copyWith =>
      _$ExecutionSetCopyWithImpl<ExecutionSet>(
          this as ExecutionSet, _$identity);

  /// Serializes this ExecutionSet to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExecutionSet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceTemplateSetId, sourceTemplateSetId) ||
                other.sourceTemplateSetId == sourceTemplateSetId) &&
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
            (identical(other.actualWeight, actualWeight) ||
                other.actualWeight == actualWeight) &&
            (identical(other.actualReps, actualReps) ||
                other.actualReps == actualReps) &&
            (identical(other.actualDurationSeconds, actualDurationSeconds) ||
                other.actualDurationSeconds == actualDurationSeconds) &&
            (identical(other.actualDistanceMeters, actualDistanceMeters) ||
                other.actualDistanceMeters == actualDistanceMeters) &&
            (identical(other.actualCalories, actualCalories) ||
                other.actualCalories == actualCalories) &&
            (identical(other.rpe, rpe) || other.rpe == rpe) &&
            (identical(other.rir, rir) || other.rir == rir) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.plannedRestSeconds, plannedRestSeconds) ||
                other.plannedRestSeconds == plannedRestSeconds) &&
            (identical(other.restAutoStart, restAutoStart) ||
                other.restAutoStart == restAutoStart) &&
            (identical(other.restAllowSkip, restAllowSkip) ||
                other.restAllowSkip == restAllowSkip) &&
            (identical(other.restAllowExtend, restAllowExtend) ||
                other.restAllowExtend == restAllowExtend) &&
            (identical(other.restMinimumSeconds, restMinimumSeconds) ||
                other.restMinimumSeconds == restMinimumSeconds) &&
            (identical(other.restMaximumSeconds, restMaximumSeconds) ||
                other.restMaximumSeconds == restMaximumSeconds) &&
            (identical(other.actualRestSeconds, actualRestSeconds) ||
                other.actualRestSeconds == actualRestSeconds) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        sourceTemplateSetId,
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
        actualWeight,
        actualReps,
        actualDurationSeconds,
        actualDistanceMeters,
        actualCalories,
        rpe,
        rir,
        startedAt,
        completedAt,
        status,
        plannedRestSeconds,
        restAutoStart,
        restAllowSkip,
        restAllowExtend,
        restMinimumSeconds,
        restMaximumSeconds,
        actualRestSeconds,
        notes
      ]);

  @override
  String toString() {
    return 'ExecutionSet(id: $id, sourceTemplateSetId: $sourceTemplateSetId, setNumber: $setNumber, setType: $setType, targetWeight: $targetWeight, targetReps: $targetReps, targetDurationSeconds: $targetDurationSeconds, targetDistanceMeters: $targetDistanceMeters, targetCalories: $targetCalories, targetRpe: $targetRpe, targetRir: $targetRir, percentageOf1Rm: $percentageOf1Rm, actualWeight: $actualWeight, actualReps: $actualReps, actualDurationSeconds: $actualDurationSeconds, actualDistanceMeters: $actualDistanceMeters, actualCalories: $actualCalories, rpe: $rpe, rir: $rir, startedAt: $startedAt, completedAt: $completedAt, status: $status, plannedRestSeconds: $plannedRestSeconds, restAutoStart: $restAutoStart, restAllowSkip: $restAllowSkip, restAllowExtend: $restAllowExtend, restMinimumSeconds: $restMinimumSeconds, restMaximumSeconds: $restMaximumSeconds, actualRestSeconds: $actualRestSeconds, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $ExecutionSetCopyWith<$Res> {
  factory $ExecutionSetCopyWith(
          ExecutionSet value, $Res Function(ExecutionSet) _then) =
      _$ExecutionSetCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String? sourceTemplateSetId,
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
      double? actualWeight,
      int? actualReps,
      int? actualDurationSeconds,
      double? actualDistanceMeters,
      int? actualCalories,
      double? rpe,
      int? rir,
      DateTime? startedAt,
      DateTime? completedAt,
      ExecutionSetStatus status,
      int plannedRestSeconds,
      bool restAutoStart,
      bool restAllowSkip,
      bool restAllowExtend,
      int? restMinimumSeconds,
      int? restMaximumSeconds,
      int? actualRestSeconds,
      String? notes});
}

/// @nodoc
class _$ExecutionSetCopyWithImpl<$Res> implements $ExecutionSetCopyWith<$Res> {
  _$ExecutionSetCopyWithImpl(this._self, this._then);

  ExecutionSet _self;
  final $Res Function(ExecutionSet) _then;

  /// Create a copy of ExecutionSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceTemplateSetId = freezed,
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
    Object? actualWeight = freezed,
    Object? actualReps = freezed,
    Object? actualDurationSeconds = freezed,
    Object? actualDistanceMeters = freezed,
    Object? actualCalories = freezed,
    Object? rpe = freezed,
    Object? rir = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? status = null,
    Object? plannedRestSeconds = null,
    Object? restAutoStart = null,
    Object? restAllowSkip = null,
    Object? restAllowExtend = null,
    Object? restMinimumSeconds = freezed,
    Object? restMaximumSeconds = freezed,
    Object? actualRestSeconds = freezed,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceTemplateSetId: freezed == sourceTemplateSetId
          ? _self.sourceTemplateSetId
          : sourceTemplateSetId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      actualWeight: freezed == actualWeight
          ? _self.actualWeight
          : actualWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      actualReps: freezed == actualReps
          ? _self.actualReps
          : actualReps // ignore: cast_nullable_to_non_nullable
              as int?,
      actualDurationSeconds: freezed == actualDurationSeconds
          ? _self.actualDurationSeconds
          : actualDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      actualDistanceMeters: freezed == actualDistanceMeters
          ? _self.actualDistanceMeters
          : actualDistanceMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      actualCalories: freezed == actualCalories
          ? _self.actualCalories
          : actualCalories // ignore: cast_nullable_to_non_nullable
              as int?,
      rpe: freezed == rpe
          ? _self.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as double?,
      rir: freezed == rir
          ? _self.rir
          : rir // ignore: cast_nullable_to_non_nullable
              as int?,
      startedAt: freezed == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExecutionSetStatus,
      plannedRestSeconds: null == plannedRestSeconds
          ? _self.plannedRestSeconds
          : plannedRestSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      restAutoStart: null == restAutoStart
          ? _self.restAutoStart
          : restAutoStart // ignore: cast_nullable_to_non_nullable
              as bool,
      restAllowSkip: null == restAllowSkip
          ? _self.restAllowSkip
          : restAllowSkip // ignore: cast_nullable_to_non_nullable
              as bool,
      restAllowExtend: null == restAllowExtend
          ? _self.restAllowExtend
          : restAllowExtend // ignore: cast_nullable_to_non_nullable
              as bool,
      restMinimumSeconds: freezed == restMinimumSeconds
          ? _self.restMinimumSeconds
          : restMinimumSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      restMaximumSeconds: freezed == restMaximumSeconds
          ? _self.restMaximumSeconds
          : restMaximumSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      actualRestSeconds: freezed == actualRestSeconds
          ? _self.actualRestSeconds
          : actualRestSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExecutionSet].
extension ExecutionSetPatterns on ExecutionSet {
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
    TResult Function(_ExecutionSet value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExecutionSet() when $default != null:
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
    TResult Function(_ExecutionSet value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutionSet():
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
    TResult? Function(_ExecutionSet value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutionSet() when $default != null:
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
            String? sourceTemplateSetId,
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
            double? actualWeight,
            int? actualReps,
            int? actualDurationSeconds,
            double? actualDistanceMeters,
            int? actualCalories,
            double? rpe,
            int? rir,
            DateTime? startedAt,
            DateTime? completedAt,
            ExecutionSetStatus status,
            int plannedRestSeconds,
            bool restAutoStart,
            bool restAllowSkip,
            bool restAllowExtend,
            int? restMinimumSeconds,
            int? restMaximumSeconds,
            int? actualRestSeconds,
            String? notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExecutionSet() when $default != null:
        return $default(
            _that.id,
            _that.sourceTemplateSetId,
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
            _that.actualWeight,
            _that.actualReps,
            _that.actualDurationSeconds,
            _that.actualDistanceMeters,
            _that.actualCalories,
            _that.rpe,
            _that.rir,
            _that.startedAt,
            _that.completedAt,
            _that.status,
            _that.plannedRestSeconds,
            _that.restAutoStart,
            _that.restAllowSkip,
            _that.restAllowExtend,
            _that.restMinimumSeconds,
            _that.restMaximumSeconds,
            _that.actualRestSeconds,
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
            String? sourceTemplateSetId,
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
            double? actualWeight,
            int? actualReps,
            int? actualDurationSeconds,
            double? actualDistanceMeters,
            int? actualCalories,
            double? rpe,
            int? rir,
            DateTime? startedAt,
            DateTime? completedAt,
            ExecutionSetStatus status,
            int plannedRestSeconds,
            bool restAutoStart,
            bool restAllowSkip,
            bool restAllowExtend,
            int? restMinimumSeconds,
            int? restMaximumSeconds,
            int? actualRestSeconds,
            String? notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutionSet():
        return $default(
            _that.id,
            _that.sourceTemplateSetId,
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
            _that.actualWeight,
            _that.actualReps,
            _that.actualDurationSeconds,
            _that.actualDistanceMeters,
            _that.actualCalories,
            _that.rpe,
            _that.rir,
            _that.startedAt,
            _that.completedAt,
            _that.status,
            _that.plannedRestSeconds,
            _that.restAutoStart,
            _that.restAllowSkip,
            _that.restAllowExtend,
            _that.restMinimumSeconds,
            _that.restMaximumSeconds,
            _that.actualRestSeconds,
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
            String? sourceTemplateSetId,
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
            double? actualWeight,
            int? actualReps,
            int? actualDurationSeconds,
            double? actualDistanceMeters,
            int? actualCalories,
            double? rpe,
            int? rir,
            DateTime? startedAt,
            DateTime? completedAt,
            ExecutionSetStatus status,
            int plannedRestSeconds,
            bool restAutoStart,
            bool restAllowSkip,
            bool restAllowExtend,
            int? restMinimumSeconds,
            int? restMaximumSeconds,
            int? actualRestSeconds,
            String? notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutionSet() when $default != null:
        return $default(
            _that.id,
            _that.sourceTemplateSetId,
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
            _that.actualWeight,
            _that.actualReps,
            _that.actualDurationSeconds,
            _that.actualDistanceMeters,
            _that.actualCalories,
            _that.rpe,
            _that.rir,
            _that.startedAt,
            _that.completedAt,
            _that.status,
            _that.plannedRestSeconds,
            _that.restAutoStart,
            _that.restAllowSkip,
            _that.restAllowExtend,
            _that.restMinimumSeconds,
            _that.restMaximumSeconds,
            _that.actualRestSeconds,
            _that.notes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExecutionSet implements ExecutionSet {
  const _ExecutionSet(
      {required this.id,
      this.sourceTemplateSetId,
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
      this.actualWeight,
      this.actualReps,
      this.actualDurationSeconds,
      this.actualDistanceMeters,
      this.actualCalories,
      this.rpe,
      this.rir,
      this.startedAt,
      this.completedAt,
      this.status = ExecutionSetStatus.planned,
      this.plannedRestSeconds = 0,
      this.restAutoStart = false,
      this.restAllowSkip = true,
      this.restAllowExtend = true,
      this.restMinimumSeconds,
      this.restMaximumSeconds,
      this.actualRestSeconds,
      this.notes});
  factory _ExecutionSet.fromJson(Map<String, dynamic> json) =>
      _$ExecutionSetFromJson(json);

  @override
  final String id;
  @override
  final String? sourceTemplateSetId;
  @override
  final int setNumber;
  @override
  @JsonKey()
  final SetType setType;
  @override
  final double? targetWeight;
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
  final double? actualWeight;
  @override
  final int? actualReps;
  @override
  final int? actualDurationSeconds;
  @override
  final double? actualDistanceMeters;
  @override
  final int? actualCalories;
  @override
  final double? rpe;
  @override
  final int? rir;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  @JsonKey()
  final ExecutionSetStatus status;
  @override
  @JsonKey()
  final int plannedRestSeconds;
  @override
  @JsonKey()
  final bool restAutoStart;
  @override
  @JsonKey()
  final bool restAllowSkip;
  @override
  @JsonKey()
  final bool restAllowExtend;
  @override
  final int? restMinimumSeconds;
  @override
  final int? restMaximumSeconds;

  /// Sum of recorded actual durations for this set's rest intervals.
  @override
  final int? actualRestSeconds;
  @override
  final String? notes;

  /// Create a copy of ExecutionSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExecutionSetCopyWith<_ExecutionSet> get copyWith =>
      __$ExecutionSetCopyWithImpl<_ExecutionSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExecutionSetToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExecutionSet &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceTemplateSetId, sourceTemplateSetId) ||
                other.sourceTemplateSetId == sourceTemplateSetId) &&
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
            (identical(other.actualWeight, actualWeight) ||
                other.actualWeight == actualWeight) &&
            (identical(other.actualReps, actualReps) ||
                other.actualReps == actualReps) &&
            (identical(other.actualDurationSeconds, actualDurationSeconds) ||
                other.actualDurationSeconds == actualDurationSeconds) &&
            (identical(other.actualDistanceMeters, actualDistanceMeters) ||
                other.actualDistanceMeters == actualDistanceMeters) &&
            (identical(other.actualCalories, actualCalories) ||
                other.actualCalories == actualCalories) &&
            (identical(other.rpe, rpe) || other.rpe == rpe) &&
            (identical(other.rir, rir) || other.rir == rir) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.plannedRestSeconds, plannedRestSeconds) ||
                other.plannedRestSeconds == plannedRestSeconds) &&
            (identical(other.restAutoStart, restAutoStart) ||
                other.restAutoStart == restAutoStart) &&
            (identical(other.restAllowSkip, restAllowSkip) ||
                other.restAllowSkip == restAllowSkip) &&
            (identical(other.restAllowExtend, restAllowExtend) ||
                other.restAllowExtend == restAllowExtend) &&
            (identical(other.restMinimumSeconds, restMinimumSeconds) ||
                other.restMinimumSeconds == restMinimumSeconds) &&
            (identical(other.restMaximumSeconds, restMaximumSeconds) ||
                other.restMaximumSeconds == restMaximumSeconds) &&
            (identical(other.actualRestSeconds, actualRestSeconds) ||
                other.actualRestSeconds == actualRestSeconds) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        sourceTemplateSetId,
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
        actualWeight,
        actualReps,
        actualDurationSeconds,
        actualDistanceMeters,
        actualCalories,
        rpe,
        rir,
        startedAt,
        completedAt,
        status,
        plannedRestSeconds,
        restAutoStart,
        restAllowSkip,
        restAllowExtend,
        restMinimumSeconds,
        restMaximumSeconds,
        actualRestSeconds,
        notes
      ]);

  @override
  String toString() {
    return 'ExecutionSet(id: $id, sourceTemplateSetId: $sourceTemplateSetId, setNumber: $setNumber, setType: $setType, targetWeight: $targetWeight, targetReps: $targetReps, targetDurationSeconds: $targetDurationSeconds, targetDistanceMeters: $targetDistanceMeters, targetCalories: $targetCalories, targetRpe: $targetRpe, targetRir: $targetRir, percentageOf1Rm: $percentageOf1Rm, actualWeight: $actualWeight, actualReps: $actualReps, actualDurationSeconds: $actualDurationSeconds, actualDistanceMeters: $actualDistanceMeters, actualCalories: $actualCalories, rpe: $rpe, rir: $rir, startedAt: $startedAt, completedAt: $completedAt, status: $status, plannedRestSeconds: $plannedRestSeconds, restAutoStart: $restAutoStart, restAllowSkip: $restAllowSkip, restAllowExtend: $restAllowExtend, restMinimumSeconds: $restMinimumSeconds, restMaximumSeconds: $restMaximumSeconds, actualRestSeconds: $actualRestSeconds, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$ExecutionSetCopyWith<$Res>
    implements $ExecutionSetCopyWith<$Res> {
  factory _$ExecutionSetCopyWith(
          _ExecutionSet value, $Res Function(_ExecutionSet) _then) =
      __$ExecutionSetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String? sourceTemplateSetId,
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
      double? actualWeight,
      int? actualReps,
      int? actualDurationSeconds,
      double? actualDistanceMeters,
      int? actualCalories,
      double? rpe,
      int? rir,
      DateTime? startedAt,
      DateTime? completedAt,
      ExecutionSetStatus status,
      int plannedRestSeconds,
      bool restAutoStart,
      bool restAllowSkip,
      bool restAllowExtend,
      int? restMinimumSeconds,
      int? restMaximumSeconds,
      int? actualRestSeconds,
      String? notes});
}

/// @nodoc
class __$ExecutionSetCopyWithImpl<$Res>
    implements _$ExecutionSetCopyWith<$Res> {
  __$ExecutionSetCopyWithImpl(this._self, this._then);

  final _ExecutionSet _self;
  final $Res Function(_ExecutionSet) _then;

  /// Create a copy of ExecutionSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? sourceTemplateSetId = freezed,
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
    Object? actualWeight = freezed,
    Object? actualReps = freezed,
    Object? actualDurationSeconds = freezed,
    Object? actualDistanceMeters = freezed,
    Object? actualCalories = freezed,
    Object? rpe = freezed,
    Object? rir = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? status = null,
    Object? plannedRestSeconds = null,
    Object? restAutoStart = null,
    Object? restAllowSkip = null,
    Object? restAllowExtend = null,
    Object? restMinimumSeconds = freezed,
    Object? restMaximumSeconds = freezed,
    Object? actualRestSeconds = freezed,
    Object? notes = freezed,
  }) {
    return _then(_ExecutionSet(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceTemplateSetId: freezed == sourceTemplateSetId
          ? _self.sourceTemplateSetId
          : sourceTemplateSetId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      actualWeight: freezed == actualWeight
          ? _self.actualWeight
          : actualWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      actualReps: freezed == actualReps
          ? _self.actualReps
          : actualReps // ignore: cast_nullable_to_non_nullable
              as int?,
      actualDurationSeconds: freezed == actualDurationSeconds
          ? _self.actualDurationSeconds
          : actualDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      actualDistanceMeters: freezed == actualDistanceMeters
          ? _self.actualDistanceMeters
          : actualDistanceMeters // ignore: cast_nullable_to_non_nullable
              as double?,
      actualCalories: freezed == actualCalories
          ? _self.actualCalories
          : actualCalories // ignore: cast_nullable_to_non_nullable
              as int?,
      rpe: freezed == rpe
          ? _self.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as double?,
      rir: freezed == rir
          ? _self.rir
          : rir // ignore: cast_nullable_to_non_nullable
              as int?,
      startedAt: freezed == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExecutionSetStatus,
      plannedRestSeconds: null == plannedRestSeconds
          ? _self.plannedRestSeconds
          : plannedRestSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      restAutoStart: null == restAutoStart
          ? _self.restAutoStart
          : restAutoStart // ignore: cast_nullable_to_non_nullable
              as bool,
      restAllowSkip: null == restAllowSkip
          ? _self.restAllowSkip
          : restAllowSkip // ignore: cast_nullable_to_non_nullable
              as bool,
      restAllowExtend: null == restAllowExtend
          ? _self.restAllowExtend
          : restAllowExtend // ignore: cast_nullable_to_non_nullable
              as bool,
      restMinimumSeconds: freezed == restMinimumSeconds
          ? _self.restMinimumSeconds
          : restMinimumSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      restMaximumSeconds: freezed == restMaximumSeconds
          ? _self.restMaximumSeconds
          : restMaximumSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      actualRestSeconds: freezed == actualRestSeconds
          ? _self.actualRestSeconds
          : actualRestSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

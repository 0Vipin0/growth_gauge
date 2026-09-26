// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rest_interval.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestInterval {
  String get id;
  String get executionSetId;
  DateTime get startedAt;
  DateTime? get endedAt;
  int get plannedDurationSeconds;
  int? get actualDurationSeconds;
  int get minimumDurationSeconds;
  int? get maximumDurationSeconds;
  bool get allowSkip;
  bool get allowExtend;
  bool get skipped;

  /// Create a copy of RestInterval
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RestIntervalCopyWith<RestInterval> get copyWith =>
      _$RestIntervalCopyWithImpl<RestInterval>(
          this as RestInterval, _$identity);

  /// Serializes this RestInterval to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RestInterval &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.executionSetId, executionSetId) ||
                other.executionSetId == executionSetId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.plannedDurationSeconds, plannedDurationSeconds) ||
                other.plannedDurationSeconds == plannedDurationSeconds) &&
            (identical(other.actualDurationSeconds, actualDurationSeconds) ||
                other.actualDurationSeconds == actualDurationSeconds) &&
            (identical(other.minimumDurationSeconds, minimumDurationSeconds) ||
                other.minimumDurationSeconds == minimumDurationSeconds) &&
            (identical(other.maximumDurationSeconds, maximumDurationSeconds) ||
                other.maximumDurationSeconds == maximumDurationSeconds) &&
            (identical(other.allowSkip, allowSkip) ||
                other.allowSkip == allowSkip) &&
            (identical(other.allowExtend, allowExtend) ||
                other.allowExtend == allowExtend) &&
            (identical(other.skipped, skipped) || other.skipped == skipped));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      executionSetId,
      startedAt,
      endedAt,
      plannedDurationSeconds,
      actualDurationSeconds,
      minimumDurationSeconds,
      maximumDurationSeconds,
      allowSkip,
      allowExtend,
      skipped);

  @override
  String toString() {
    return 'RestInterval(id: $id, executionSetId: $executionSetId, startedAt: $startedAt, endedAt: $endedAt, plannedDurationSeconds: $plannedDurationSeconds, actualDurationSeconds: $actualDurationSeconds, minimumDurationSeconds: $minimumDurationSeconds, maximumDurationSeconds: $maximumDurationSeconds, allowSkip: $allowSkip, allowExtend: $allowExtend, skipped: $skipped)';
  }
}

/// @nodoc
abstract mixin class $RestIntervalCopyWith<$Res> {
  factory $RestIntervalCopyWith(
          RestInterval value, $Res Function(RestInterval) _then) =
      _$RestIntervalCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String executionSetId,
      DateTime startedAt,
      DateTime? endedAt,
      int plannedDurationSeconds,
      int? actualDurationSeconds,
      int minimumDurationSeconds,
      int? maximumDurationSeconds,
      bool allowSkip,
      bool allowExtend,
      bool skipped});
}

/// @nodoc
class _$RestIntervalCopyWithImpl<$Res> implements $RestIntervalCopyWith<$Res> {
  _$RestIntervalCopyWithImpl(this._self, this._then);

  final RestInterval _self;
  final $Res Function(RestInterval) _then;

  /// Create a copy of RestInterval
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? executionSetId = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? plannedDurationSeconds = null,
    Object? actualDurationSeconds = freezed,
    Object? minimumDurationSeconds = null,
    Object? maximumDurationSeconds = freezed,
    Object? allowSkip = null,
    Object? allowExtend = null,
    Object? skipped = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      executionSetId: null == executionSetId
          ? _self.executionSetId
          : executionSetId // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      plannedDurationSeconds: null == plannedDurationSeconds
          ? _self.plannedDurationSeconds
          : plannedDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      actualDurationSeconds: freezed == actualDurationSeconds
          ? _self.actualDurationSeconds
          : actualDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      minimumDurationSeconds: null == minimumDurationSeconds
          ? _self.minimumDurationSeconds
          : minimumDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      maximumDurationSeconds: freezed == maximumDurationSeconds
          ? _self.maximumDurationSeconds
          : maximumDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      allowSkip: null == allowSkip
          ? _self.allowSkip
          : allowSkip // ignore: cast_nullable_to_non_nullable
              as bool,
      allowExtend: null == allowExtend
          ? _self.allowExtend
          : allowExtend // ignore: cast_nullable_to_non_nullable
              as bool,
      skipped: null == skipped
          ? _self.skipped
          : skipped // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [RestInterval].
extension RestIntervalPatterns on RestInterval {
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
    TResult Function(_RestInterval value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RestInterval() when $default != null:
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
    TResult Function(_RestInterval value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestInterval():
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
    TResult? Function(_RestInterval value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestInterval() when $default != null:
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
            String executionSetId,
            DateTime startedAt,
            DateTime? endedAt,
            int plannedDurationSeconds,
            int? actualDurationSeconds,
            int minimumDurationSeconds,
            int? maximumDurationSeconds,
            bool allowSkip,
            bool allowExtend,
            bool skipped)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RestInterval() when $default != null:
        return $default(
            _that.id,
            _that.executionSetId,
            _that.startedAt,
            _that.endedAt,
            _that.plannedDurationSeconds,
            _that.actualDurationSeconds,
            _that.minimumDurationSeconds,
            _that.maximumDurationSeconds,
            _that.allowSkip,
            _that.allowExtend,
            _that.skipped);
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
            String executionSetId,
            DateTime startedAt,
            DateTime? endedAt,
            int plannedDurationSeconds,
            int? actualDurationSeconds,
            int minimumDurationSeconds,
            int? maximumDurationSeconds,
            bool allowSkip,
            bool allowExtend,
            bool skipped)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestInterval():
        return $default(
            _that.id,
            _that.executionSetId,
            _that.startedAt,
            _that.endedAt,
            _that.plannedDurationSeconds,
            _that.actualDurationSeconds,
            _that.minimumDurationSeconds,
            _that.maximumDurationSeconds,
            _that.allowSkip,
            _that.allowExtend,
            _that.skipped);
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
            String executionSetId,
            DateTime startedAt,
            DateTime? endedAt,
            int plannedDurationSeconds,
            int? actualDurationSeconds,
            int minimumDurationSeconds,
            int? maximumDurationSeconds,
            bool allowSkip,
            bool allowExtend,
            bool skipped)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestInterval() when $default != null:
        return $default(
            _that.id,
            _that.executionSetId,
            _that.startedAt,
            _that.endedAt,
            _that.plannedDurationSeconds,
            _that.actualDurationSeconds,
            _that.minimumDurationSeconds,
            _that.maximumDurationSeconds,
            _that.allowSkip,
            _that.allowExtend,
            _that.skipped);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RestInterval implements RestInterval {
  const _RestInterval(
      {required this.id,
      required this.executionSetId,
      required this.startedAt,
      this.endedAt,
      required this.plannedDurationSeconds,
      this.actualDurationSeconds,
      this.minimumDurationSeconds = 0,
      this.maximumDurationSeconds,
      this.allowSkip = true,
      this.allowExtend = true,
      this.skipped = false});
  factory _RestInterval.fromJson(Map<String, dynamic> json) =>
      _$RestIntervalFromJson(json);

  @override
  final String id;
  @override
  final String executionSetId;
  @override
  final DateTime startedAt;
  @override
  final DateTime? endedAt;
  @override
  final int plannedDurationSeconds;
  @override
  final int? actualDurationSeconds;
  @override
  @JsonKey()
  final int minimumDurationSeconds;
  @override
  final int? maximumDurationSeconds;
  @override
  @JsonKey()
  final bool allowSkip;
  @override
  @JsonKey()
  final bool allowExtend;
  @override
  @JsonKey()
  final bool skipped;

  /// Create a copy of RestInterval
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RestIntervalCopyWith<_RestInterval> get copyWith =>
      __$RestIntervalCopyWithImpl<_RestInterval>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RestIntervalToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RestInterval &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.executionSetId, executionSetId) ||
                other.executionSetId == executionSetId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.plannedDurationSeconds, plannedDurationSeconds) ||
                other.plannedDurationSeconds == plannedDurationSeconds) &&
            (identical(other.actualDurationSeconds, actualDurationSeconds) ||
                other.actualDurationSeconds == actualDurationSeconds) &&
            (identical(other.minimumDurationSeconds, minimumDurationSeconds) ||
                other.minimumDurationSeconds == minimumDurationSeconds) &&
            (identical(other.maximumDurationSeconds, maximumDurationSeconds) ||
                other.maximumDurationSeconds == maximumDurationSeconds) &&
            (identical(other.allowSkip, allowSkip) ||
                other.allowSkip == allowSkip) &&
            (identical(other.allowExtend, allowExtend) ||
                other.allowExtend == allowExtend) &&
            (identical(other.skipped, skipped) || other.skipped == skipped));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      executionSetId,
      startedAt,
      endedAt,
      plannedDurationSeconds,
      actualDurationSeconds,
      minimumDurationSeconds,
      maximumDurationSeconds,
      allowSkip,
      allowExtend,
      skipped);

  @override
  String toString() {
    return 'RestInterval(id: $id, executionSetId: $executionSetId, startedAt: $startedAt, endedAt: $endedAt, plannedDurationSeconds: $plannedDurationSeconds, actualDurationSeconds: $actualDurationSeconds, minimumDurationSeconds: $minimumDurationSeconds, maximumDurationSeconds: $maximumDurationSeconds, allowSkip: $allowSkip, allowExtend: $allowExtend, skipped: $skipped)';
  }
}

/// @nodoc
abstract mixin class _$RestIntervalCopyWith<$Res>
    implements $RestIntervalCopyWith<$Res> {
  factory _$RestIntervalCopyWith(
          _RestInterval value, $Res Function(_RestInterval) _then) =
      __$RestIntervalCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String executionSetId,
      DateTime startedAt,
      DateTime? endedAt,
      int plannedDurationSeconds,
      int? actualDurationSeconds,
      int minimumDurationSeconds,
      int? maximumDurationSeconds,
      bool allowSkip,
      bool allowExtend,
      bool skipped});
}

/// @nodoc
class __$RestIntervalCopyWithImpl<$Res>
    implements _$RestIntervalCopyWith<$Res> {
  __$RestIntervalCopyWithImpl(this._self, this._then);

  final _RestInterval _self;
  final $Res Function(_RestInterval) _then;

  /// Create a copy of RestInterval
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? executionSetId = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? plannedDurationSeconds = null,
    Object? actualDurationSeconds = freezed,
    Object? minimumDurationSeconds = null,
    Object? maximumDurationSeconds = freezed,
    Object? allowSkip = null,
    Object? allowExtend = null,
    Object? skipped = null,
  }) {
    return _then(_RestInterval(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      executionSetId: null == executionSetId
          ? _self.executionSetId
          : executionSetId // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      plannedDurationSeconds: null == plannedDurationSeconds
          ? _self.plannedDurationSeconds
          : plannedDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      actualDurationSeconds: freezed == actualDurationSeconds
          ? _self.actualDurationSeconds
          : actualDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      minimumDurationSeconds: null == minimumDurationSeconds
          ? _self.minimumDurationSeconds
          : minimumDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      maximumDurationSeconds: freezed == maximumDurationSeconds
          ? _self.maximumDurationSeconds
          : maximumDurationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      allowSkip: null == allowSkip
          ? _self.allowSkip
          : allowSkip // ignore: cast_nullable_to_non_nullable
              as bool,
      allowExtend: null == allowExtend
          ? _self.allowExtend
          : allowExtend // ignore: cast_nullable_to_non_nullable
              as bool,
      skipped: null == skipped
          ? _self.skipped
          : skipped // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on

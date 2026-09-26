// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_interruption.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionInterruption {
  String get id;
  DateTime get startedAt;
  DateTime? get endedAt;
  InterruptionReason get reason;
  bool get userInitiated;

  /// Create a copy of SessionInterruption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SessionInterruptionCopyWith<SessionInterruption> get copyWith =>
      _$SessionInterruptionCopyWithImpl<SessionInterruption>(
          this as SessionInterruption, _$identity);

  /// Serializes this SessionInterruption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionInterruption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.userInitiated, userInitiated) ||
                other.userInitiated == userInitiated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, startedAt, endedAt, reason, userInitiated);

  @override
  String toString() {
    return 'SessionInterruption(id: $id, startedAt: $startedAt, endedAt: $endedAt, reason: $reason, userInitiated: $userInitiated)';
  }
}

/// @nodoc
abstract mixin class $SessionInterruptionCopyWith<$Res> {
  factory $SessionInterruptionCopyWith(
          SessionInterruption value, $Res Function(SessionInterruption) _then) =
      _$SessionInterruptionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime startedAt,
      DateTime? endedAt,
      InterruptionReason reason,
      bool userInitiated});
}

/// @nodoc
class _$SessionInterruptionCopyWithImpl<$Res>
    implements $SessionInterruptionCopyWith<$Res> {
  _$SessionInterruptionCopyWithImpl(this._self, this._then);

  SessionInterruption _self;
  final $Res Function(SessionInterruption) _then;

  /// Create a copy of SessionInterruption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? reason = null,
    Object? userInitiated = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as InterruptionReason,
      userInitiated: null == userInitiated
          ? _self.userInitiated
          : userInitiated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [SessionInterruption].
extension SessionInterruptionPatterns on SessionInterruption {
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
    TResult Function(_SessionInterruption value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SessionInterruption() when $default != null:
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
    TResult Function(_SessionInterruption value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionInterruption():
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
    TResult? Function(_SessionInterruption value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionInterruption() when $default != null:
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
    TResult Function(String id, DateTime startedAt, DateTime? endedAt,
            InterruptionReason reason, bool userInitiated)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SessionInterruption() when $default != null:
        return $default(_that.id, _that.startedAt, _that.endedAt, _that.reason,
            _that.userInitiated);
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
    TResult Function(String id, DateTime startedAt, DateTime? endedAt,
            InterruptionReason reason, bool userInitiated)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionInterruption():
        return $default(_that.id, _that.startedAt, _that.endedAt, _that.reason,
            _that.userInitiated);
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
    TResult? Function(String id, DateTime startedAt, DateTime? endedAt,
            InterruptionReason reason, bool userInitiated)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionInterruption() when $default != null:
        return $default(_that.id, _that.startedAt, _that.endedAt, _that.reason,
            _that.userInitiated);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SessionInterruption implements SessionInterruption {
  const _SessionInterruption(
      {required this.id,
      required this.startedAt,
      this.endedAt,
      this.reason = InterruptionReason.other,
      this.userInitiated = true});
  factory _SessionInterruption.fromJson(Map<String, dynamic> json) =>
      _$SessionInterruptionFromJson(json);

  @override
  final String id;
  @override
  final DateTime startedAt;
  @override
  final DateTime? endedAt;
  @override
  @JsonKey()
  final InterruptionReason reason;
  @override
  @JsonKey()
  final bool userInitiated;

  /// Create a copy of SessionInterruption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SessionInterruptionCopyWith<_SessionInterruption> get copyWith =>
      __$SessionInterruptionCopyWithImpl<_SessionInterruption>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SessionInterruptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SessionInterruption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.userInitiated, userInitiated) ||
                other.userInitiated == userInitiated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, startedAt, endedAt, reason, userInitiated);

  @override
  String toString() {
    return 'SessionInterruption(id: $id, startedAt: $startedAt, endedAt: $endedAt, reason: $reason, userInitiated: $userInitiated)';
  }
}

/// @nodoc
abstract mixin class _$SessionInterruptionCopyWith<$Res>
    implements $SessionInterruptionCopyWith<$Res> {
  factory _$SessionInterruptionCopyWith(_SessionInterruption value,
          $Res Function(_SessionInterruption) _then) =
      __$SessionInterruptionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime startedAt,
      DateTime? endedAt,
      InterruptionReason reason,
      bool userInitiated});
}

/// @nodoc
class __$SessionInterruptionCopyWithImpl<$Res>
    implements _$SessionInterruptionCopyWith<$Res> {
  __$SessionInterruptionCopyWithImpl(this._self, this._then);

  final _SessionInterruption _self;
  final $Res Function(_SessionInterruption) _then;

  /// Create a copy of SessionInterruption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? reason = null,
    Object? userInitiated = null,
  }) {
    return _then(_SessionInterruption(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endedAt: freezed == endedAt
          ? _self.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as InterruptionReason,
      userInitiated: null == userInitiated
          ? _self.userInitiated
          : userInitiated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on

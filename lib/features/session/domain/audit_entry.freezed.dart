// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuditEntry {
  String get id;
  DateTime get timestamp;
  AuditActorType get actorType;
  String? get actorId;
  AuditAction get action;
  String get entityType;
  String get entityId;
  String? get field;
  Object? get previousValue;
  Object? get newValue;
  String? get reason;
  String? get correlationId;

  /// Create a copy of AuditEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuditEntryCopyWith<AuditEntry> get copyWith =>
      _$AuditEntryCopyWithImpl<AuditEntry>(this as AuditEntry, _$identity);

  /// Serializes this AuditEntry to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuditEntry &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.actorType, actorType) ||
                other.actorType == actorType) &&
            (identical(other.actorId, actorId) || other.actorId == actorId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality()
                .equals(other.previousValue, previousValue) &&
            const DeepCollectionEquality().equals(other.newValue, newValue) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.correlationId, correlationId) ||
                other.correlationId == correlationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      actorType,
      actorId,
      action,
      entityType,
      entityId,
      field,
      const DeepCollectionEquality().hash(previousValue),
      const DeepCollectionEquality().hash(newValue),
      reason,
      correlationId);

  @override
  String toString() {
    return 'AuditEntry(id: $id, timestamp: $timestamp, actorType: $actorType, actorId: $actorId, action: $action, entityType: $entityType, entityId: $entityId, field: $field, previousValue: $previousValue, newValue: $newValue, reason: $reason, correlationId: $correlationId)';
  }
}

/// @nodoc
abstract mixin class $AuditEntryCopyWith<$Res> {
  factory $AuditEntryCopyWith(
          AuditEntry value, $Res Function(AuditEntry) _then) =
      _$AuditEntryCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      AuditActorType actorType,
      String? actorId,
      AuditAction action,
      String entityType,
      String entityId,
      String? field,
      Object? previousValue,
      Object? newValue,
      String? reason,
      String? correlationId});
}

/// @nodoc
class _$AuditEntryCopyWithImpl<$Res> implements $AuditEntryCopyWith<$Res> {
  _$AuditEntryCopyWithImpl(this._self, this._then);

  AuditEntry _self;
  final $Res Function(AuditEntry) _then;

  /// Create a copy of AuditEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? actorType = null,
    Object? actorId = freezed,
    Object? action = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? field = freezed,
    Object? previousValue = freezed,
    Object? newValue = freezed,
    Object? reason = freezed,
    Object? correlationId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actorType: null == actorType
          ? _self.actorType
          : actorType // ignore: cast_nullable_to_non_nullable
              as AuditActorType,
      actorId: freezed == actorId
          ? _self.actorId
          : actorId // ignore: cast_nullable_to_non_nullable
              as String?,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as AuditAction,
      entityType: null == entityType
          ? _self.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _self.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      field: freezed == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String?,
      previousValue:
          freezed == previousValue ? _self.previousValue : previousValue,
      newValue: freezed == newValue ? _self.newValue : newValue,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      correlationId: freezed == correlationId
          ? _self.correlationId
          : correlationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AuditEntry].
extension AuditEntryPatterns on AuditEntry {
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
    TResult Function(_AuditEntry value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuditEntry() when $default != null:
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
    TResult Function(_AuditEntry value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuditEntry():
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
    TResult? Function(_AuditEntry value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuditEntry() when $default != null:
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
            DateTime timestamp,
            AuditActorType actorType,
            String? actorId,
            AuditAction action,
            String entityType,
            String entityId,
            String? field,
            Object? previousValue,
            Object? newValue,
            String? reason,
            String? correlationId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuditEntry() when $default != null:
        return $default(
            _that.id,
            _that.timestamp,
            _that.actorType,
            _that.actorId,
            _that.action,
            _that.entityType,
            _that.entityId,
            _that.field,
            _that.previousValue,
            _that.newValue,
            _that.reason,
            _that.correlationId);
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
            DateTime timestamp,
            AuditActorType actorType,
            String? actorId,
            AuditAction action,
            String entityType,
            String entityId,
            String? field,
            Object? previousValue,
            Object? newValue,
            String? reason,
            String? correlationId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuditEntry():
        return $default(
            _that.id,
            _that.timestamp,
            _that.actorType,
            _that.actorId,
            _that.action,
            _that.entityType,
            _that.entityId,
            _that.field,
            _that.previousValue,
            _that.newValue,
            _that.reason,
            _that.correlationId);
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
            DateTime timestamp,
            AuditActorType actorType,
            String? actorId,
            AuditAction action,
            String entityType,
            String entityId,
            String? field,
            Object? previousValue,
            Object? newValue,
            String? reason,
            String? correlationId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuditEntry() when $default != null:
        return $default(
            _that.id,
            _that.timestamp,
            _that.actorType,
            _that.actorId,
            _that.action,
            _that.entityType,
            _that.entityId,
            _that.field,
            _that.previousValue,
            _that.newValue,
            _that.reason,
            _that.correlationId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AuditEntry implements AuditEntry {
  const _AuditEntry(
      {required this.id,
      required this.timestamp,
      this.actorType = AuditActorType.user,
      this.actorId,
      required this.action,
      required this.entityType,
      required this.entityId,
      this.field,
      this.previousValue,
      this.newValue,
      this.reason,
      this.correlationId});
  factory _AuditEntry.fromJson(Map<String, dynamic> json) =>
      _$AuditEntryFromJson(json);

  @override
  final String id;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final AuditActorType actorType;
  @override
  final String? actorId;
  @override
  final AuditAction action;
  @override
  final String entityType;
  @override
  final String entityId;
  @override
  final String? field;
  @override
  final Object? previousValue;
  @override
  final Object? newValue;
  @override
  final String? reason;
  @override
  final String? correlationId;

  /// Create a copy of AuditEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuditEntryCopyWith<_AuditEntry> get copyWith =>
      __$AuditEntryCopyWithImpl<_AuditEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuditEntryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuditEntry &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.actorType, actorType) ||
                other.actorType == actorType) &&
            (identical(other.actorId, actorId) || other.actorId == actorId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality()
                .equals(other.previousValue, previousValue) &&
            const DeepCollectionEquality().equals(other.newValue, newValue) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.correlationId, correlationId) ||
                other.correlationId == correlationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      timestamp,
      actorType,
      actorId,
      action,
      entityType,
      entityId,
      field,
      const DeepCollectionEquality().hash(previousValue),
      const DeepCollectionEquality().hash(newValue),
      reason,
      correlationId);

  @override
  String toString() {
    return 'AuditEntry(id: $id, timestamp: $timestamp, actorType: $actorType, actorId: $actorId, action: $action, entityType: $entityType, entityId: $entityId, field: $field, previousValue: $previousValue, newValue: $newValue, reason: $reason, correlationId: $correlationId)';
  }
}

/// @nodoc
abstract mixin class _$AuditEntryCopyWith<$Res>
    implements $AuditEntryCopyWith<$Res> {
  factory _$AuditEntryCopyWith(
          _AuditEntry value, $Res Function(_AuditEntry) _then) =
      __$AuditEntryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime timestamp,
      AuditActorType actorType,
      String? actorId,
      AuditAction action,
      String entityType,
      String entityId,
      String? field,
      Object? previousValue,
      Object? newValue,
      String? reason,
      String? correlationId});
}

/// @nodoc
class __$AuditEntryCopyWithImpl<$Res> implements _$AuditEntryCopyWith<$Res> {
  __$AuditEntryCopyWithImpl(this._self, this._then);

  final _AuditEntry _self;
  final $Res Function(_AuditEntry) _then;

  /// Create a copy of AuditEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? actorType = null,
    Object? actorId = freezed,
    Object? action = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? field = freezed,
    Object? previousValue = freezed,
    Object? newValue = freezed,
    Object? reason = freezed,
    Object? correlationId = freezed,
  }) {
    return _then(_AuditEntry(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actorType: null == actorType
          ? _self.actorType
          : actorType // ignore: cast_nullable_to_non_nullable
              as AuditActorType,
      actorId: freezed == actorId
          ? _self.actorId
          : actorId // ignore: cast_nullable_to_non_nullable
              as String?,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as AuditAction,
      entityType: null == entityType
          ? _self.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _self.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      field: freezed == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as String?,
      previousValue:
          freezed == previousValue ? _self.previousValue : previousValue,
      newValue: freezed == newValue ? _self.newValue : newValue,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      correlationId: freezed == correlationId
          ? _self.correlationId
          : correlationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

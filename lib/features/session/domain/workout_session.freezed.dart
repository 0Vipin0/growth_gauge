// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutSession {
  String get id;
  String get userId;
  String get templateId;
  String get templateRevisionId;
  String get templateName;
  SessionStatus get status;
  DateTime? get startedAt;
  DateTime? get pausedAt;
  DateTime? get completedAt;
  DateTime get createdAt;
  List<SessionBlock> get blocks;
  List<SessionInterruption> get interruptions;
  List<RestInterval> get restIntervals;
  List<AuditEntry> get audits;
  String? get sessionNotes;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<WorkoutSession> get copyWith =>
      _$WorkoutSessionCopyWithImpl<WorkoutSession>(
          this as WorkoutSession, _$identity);

  /// Serializes this WorkoutSession to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutSession &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.templateRevisionId, templateRevisionId) ||
                other.templateRevisionId == templateRevisionId) &&
            (identical(other.templateName, templateName) ||
                other.templateName == templateName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.pausedAt, pausedAt) ||
                other.pausedAt == pausedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other.blocks, blocks) &&
            const DeepCollectionEquality()
                .equals(other.interruptions, interruptions) &&
            const DeepCollectionEquality()
                .equals(other.restIntervals, restIntervals) &&
            const DeepCollectionEquality().equals(other.audits, audits) &&
            (identical(other.sessionNotes, sessionNotes) ||
                other.sessionNotes == sessionNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      templateId,
      templateRevisionId,
      templateName,
      status,
      startedAt,
      pausedAt,
      completedAt,
      createdAt,
      const DeepCollectionEquality().hash(blocks),
      const DeepCollectionEquality().hash(interruptions),
      const DeepCollectionEquality().hash(restIntervals),
      const DeepCollectionEquality().hash(audits),
      sessionNotes);

  @override
  String toString() {
    return 'WorkoutSession(id: $id, userId: $userId, templateId: $templateId, templateRevisionId: $templateRevisionId, templateName: $templateName, status: $status, startedAt: $startedAt, pausedAt: $pausedAt, completedAt: $completedAt, createdAt: $createdAt, blocks: $blocks, interruptions: $interruptions, restIntervals: $restIntervals, audits: $audits, sessionNotes: $sessionNotes)';
  }
}

/// @nodoc
abstract mixin class $WorkoutSessionCopyWith<$Res> {
  factory $WorkoutSessionCopyWith(
          WorkoutSession value, $Res Function(WorkoutSession) _then) =
      _$WorkoutSessionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      String templateId,
      String templateRevisionId,
      String templateName,
      SessionStatus status,
      DateTime? startedAt,
      DateTime? pausedAt,
      DateTime? completedAt,
      DateTime createdAt,
      List<SessionBlock> blocks,
      List<SessionInterruption> interruptions,
      List<RestInterval> restIntervals,
      List<AuditEntry> audits,
      String? sessionNotes});
}

/// @nodoc
class _$WorkoutSessionCopyWithImpl<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  _$WorkoutSessionCopyWithImpl(this._self, this._then);

  final WorkoutSession _self;
  final $Res Function(WorkoutSession) _then;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? templateId = null,
    Object? templateRevisionId = null,
    Object? templateName = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? pausedAt = freezed,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? blocks = null,
    Object? interruptions = null,
    Object? restIntervals = null,
    Object? audits = null,
    Object? sessionNotes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: null == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      templateRevisionId: null == templateRevisionId
          ? _self.templateRevisionId
          : templateRevisionId // ignore: cast_nullable_to_non_nullable
              as String,
      templateName: null == templateName
          ? _self.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SessionStatus,
      startedAt: freezed == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pausedAt: freezed == pausedAt
          ? _self.pausedAt
          : pausedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      blocks: null == blocks
          ? _self.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<SessionBlock>,
      interruptions: null == interruptions
          ? _self.interruptions
          : interruptions // ignore: cast_nullable_to_non_nullable
              as List<SessionInterruption>,
      restIntervals: null == restIntervals
          ? _self.restIntervals
          : restIntervals // ignore: cast_nullable_to_non_nullable
              as List<RestInterval>,
      audits: null == audits
          ? _self.audits
          : audits // ignore: cast_nullable_to_non_nullable
              as List<AuditEntry>,
      sessionNotes: freezed == sessionNotes
          ? _self.sessionNotes
          : sessionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkoutSession].
extension WorkoutSessionPatterns on WorkoutSession {
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
    TResult Function(_WorkoutSession value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession() when $default != null:
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
    TResult Function(_WorkoutSession value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession():
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
    TResult? Function(_WorkoutSession value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession() when $default != null:
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
            String userId,
            String templateId,
            String templateRevisionId,
            String templateName,
            SessionStatus status,
            DateTime? startedAt,
            DateTime? pausedAt,
            DateTime? completedAt,
            DateTime createdAt,
            List<SessionBlock> blocks,
            List<SessionInterruption> interruptions,
            List<RestInterval> restIntervals,
            List<AuditEntry> audits,
            String? sessionNotes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.templateId,
            _that.templateRevisionId,
            _that.templateName,
            _that.status,
            _that.startedAt,
            _that.pausedAt,
            _that.completedAt,
            _that.createdAt,
            _that.blocks,
            _that.interruptions,
            _that.restIntervals,
            _that.audits,
            _that.sessionNotes);
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
            String userId,
            String templateId,
            String templateRevisionId,
            String templateName,
            SessionStatus status,
            DateTime? startedAt,
            DateTime? pausedAt,
            DateTime? completedAt,
            DateTime createdAt,
            List<SessionBlock> blocks,
            List<SessionInterruption> interruptions,
            List<RestInterval> restIntervals,
            List<AuditEntry> audits,
            String? sessionNotes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession():
        return $default(
            _that.id,
            _that.userId,
            _that.templateId,
            _that.templateRevisionId,
            _that.templateName,
            _that.status,
            _that.startedAt,
            _that.pausedAt,
            _that.completedAt,
            _that.createdAt,
            _that.blocks,
            _that.interruptions,
            _that.restIntervals,
            _that.audits,
            _that.sessionNotes);
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
            String userId,
            String templateId,
            String templateRevisionId,
            String templateName,
            SessionStatus status,
            DateTime? startedAt,
            DateTime? pausedAt,
            DateTime? completedAt,
            DateTime createdAt,
            List<SessionBlock> blocks,
            List<SessionInterruption> interruptions,
            List<RestInterval> restIntervals,
            List<AuditEntry> audits,
            String? sessionNotes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutSession() when $default != null:
        return $default(
            _that.id,
            _that.userId,
            _that.templateId,
            _that.templateRevisionId,
            _that.templateName,
            _that.status,
            _that.startedAt,
            _that.pausedAt,
            _that.completedAt,
            _that.createdAt,
            _that.blocks,
            _that.interruptions,
            _that.restIntervals,
            _that.audits,
            _that.sessionNotes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutSession implements WorkoutSession {
  const _WorkoutSession(
      {required this.id,
      required this.userId,
      required this.templateId,
      required this.templateRevisionId,
      required this.templateName,
      this.status = SessionStatus.draft,
      this.startedAt,
      this.pausedAt,
      this.completedAt,
      required this.createdAt,
      final List<SessionBlock> blocks = const [],
      final List<SessionInterruption> interruptions = const [],
      final List<RestInterval> restIntervals = const [],
      final List<AuditEntry> audits = const [],
      this.sessionNotes})
      : _blocks = blocks,
        _interruptions = interruptions,
        _restIntervals = restIntervals,
        _audits = audits;
  factory _WorkoutSession.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String templateId;
  @override
  final String templateRevisionId;
  @override
  final String templateName;
  @override
  @JsonKey()
  final SessionStatus status;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? pausedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime createdAt;
  final List<SessionBlock> _blocks;
  @override
  @JsonKey()
  List<SessionBlock> get blocks {
    if (_blocks is EqualUnmodifiableListView) return _blocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blocks);
  }

  final List<SessionInterruption> _interruptions;
  @override
  @JsonKey()
  List<SessionInterruption> get interruptions {
    if (_interruptions is EqualUnmodifiableListView) return _interruptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interruptions);
  }

  final List<RestInterval> _restIntervals;
  @override
  @JsonKey()
  List<RestInterval> get restIntervals {
    if (_restIntervals is EqualUnmodifiableListView) return _restIntervals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_restIntervals);
  }

  final List<AuditEntry> _audits;
  @override
  @JsonKey()
  List<AuditEntry> get audits {
    if (_audits is EqualUnmodifiableListView) return _audits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_audits);
  }

  @override
  final String? sessionNotes;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutSessionCopyWith<_WorkoutSession> get copyWith =>
      __$WorkoutSessionCopyWithImpl<_WorkoutSession>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutSessionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutSession &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.templateRevisionId, templateRevisionId) ||
                other.templateRevisionId == templateRevisionId) &&
            (identical(other.templateName, templateName) ||
                other.templateName == templateName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.pausedAt, pausedAt) ||
                other.pausedAt == pausedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._blocks, _blocks) &&
            const DeepCollectionEquality()
                .equals(other._interruptions, _interruptions) &&
            const DeepCollectionEquality()
                .equals(other._restIntervals, _restIntervals) &&
            const DeepCollectionEquality().equals(other._audits, _audits) &&
            (identical(other.sessionNotes, sessionNotes) ||
                other.sessionNotes == sessionNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      templateId,
      templateRevisionId,
      templateName,
      status,
      startedAt,
      pausedAt,
      completedAt,
      createdAt,
      const DeepCollectionEquality().hash(_blocks),
      const DeepCollectionEquality().hash(_interruptions),
      const DeepCollectionEquality().hash(_restIntervals),
      const DeepCollectionEquality().hash(_audits),
      sessionNotes);

  @override
  String toString() {
    return 'WorkoutSession(id: $id, userId: $userId, templateId: $templateId, templateRevisionId: $templateRevisionId, templateName: $templateName, status: $status, startedAt: $startedAt, pausedAt: $pausedAt, completedAt: $completedAt, createdAt: $createdAt, blocks: $blocks, interruptions: $interruptions, restIntervals: $restIntervals, audits: $audits, sessionNotes: $sessionNotes)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutSessionCopyWith<$Res>
    implements $WorkoutSessionCopyWith<$Res> {
  factory _$WorkoutSessionCopyWith(
          _WorkoutSession value, $Res Function(_WorkoutSession) _then) =
      __$WorkoutSessionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String templateId,
      String templateRevisionId,
      String templateName,
      SessionStatus status,
      DateTime? startedAt,
      DateTime? pausedAt,
      DateTime? completedAt,
      DateTime createdAt,
      List<SessionBlock> blocks,
      List<SessionInterruption> interruptions,
      List<RestInterval> restIntervals,
      List<AuditEntry> audits,
      String? sessionNotes});
}

/// @nodoc
class __$WorkoutSessionCopyWithImpl<$Res>
    implements _$WorkoutSessionCopyWith<$Res> {
  __$WorkoutSessionCopyWithImpl(this._self, this._then);

  final _WorkoutSession _self;
  final $Res Function(_WorkoutSession) _then;

  /// Create a copy of WorkoutSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? templateId = null,
    Object? templateRevisionId = null,
    Object? templateName = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? pausedAt = freezed,
    Object? completedAt = freezed,
    Object? createdAt = null,
    Object? blocks = null,
    Object? interruptions = null,
    Object? restIntervals = null,
    Object? audits = null,
    Object? sessionNotes = freezed,
  }) {
    return _then(_WorkoutSession(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: null == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      templateRevisionId: null == templateRevisionId
          ? _self.templateRevisionId
          : templateRevisionId // ignore: cast_nullable_to_non_nullable
              as String,
      templateName: null == templateName
          ? _self.templateName
          : templateName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SessionStatus,
      startedAt: freezed == startedAt
          ? _self.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pausedAt: freezed == pausedAt
          ? _self.pausedAt
          : pausedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      blocks: null == blocks
          ? _self._blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<SessionBlock>,
      interruptions: null == interruptions
          ? _self._interruptions
          : interruptions // ignore: cast_nullable_to_non_nullable
              as List<SessionInterruption>,
      restIntervals: null == restIntervals
          ? _self._restIntervals
          : restIntervals // ignore: cast_nullable_to_non_nullable
              as List<RestInterval>,
      audits: null == audits
          ? _self._audits
          : audits // ignore: cast_nullable_to_non_nullable
              as List<AuditEntry>,
      sessionNotes: freezed == sessionNotes
          ? _self.sessionNotes
          : sessionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

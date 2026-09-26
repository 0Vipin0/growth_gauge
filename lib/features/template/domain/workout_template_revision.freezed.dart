// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_template_revision.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutTemplateRevision {
  String get id;
  String get templateId;
  int get revisionNumber;
  TemplateRevisionStatus get status;
  List<WorkoutBlock> get blocks;
  String get createdById;
  DateTime get createdAt;
  String get changeSummary;

  /// Create a copy of WorkoutTemplateRevision
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutTemplateRevisionCopyWith<WorkoutTemplateRevision> get copyWith =>
      _$WorkoutTemplateRevisionCopyWithImpl<WorkoutTemplateRevision>(
          this as WorkoutTemplateRevision, _$identity);

  /// Serializes this WorkoutTemplateRevision to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutTemplateRevision &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.revisionNumber, revisionNumber) ||
                other.revisionNumber == revisionNumber) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.blocks, blocks) &&
            (identical(other.createdById, createdById) ||
                other.createdById == createdById) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.changeSummary, changeSummary) ||
                other.changeSummary == changeSummary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      templateId,
      revisionNumber,
      status,
      const DeepCollectionEquality().hash(blocks),
      createdById,
      createdAt,
      changeSummary);

  @override
  String toString() {
    return 'WorkoutTemplateRevision(id: $id, templateId: $templateId, revisionNumber: $revisionNumber, status: $status, blocks: $blocks, createdById: $createdById, createdAt: $createdAt, changeSummary: $changeSummary)';
  }
}

/// @nodoc
abstract mixin class $WorkoutTemplateRevisionCopyWith<$Res> {
  factory $WorkoutTemplateRevisionCopyWith(WorkoutTemplateRevision value,
          $Res Function(WorkoutTemplateRevision) _then) =
      _$WorkoutTemplateRevisionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String templateId,
      int revisionNumber,
      TemplateRevisionStatus status,
      List<WorkoutBlock> blocks,
      String createdById,
      DateTime createdAt,
      String changeSummary});
}

/// @nodoc
class _$WorkoutTemplateRevisionCopyWithImpl<$Res>
    implements $WorkoutTemplateRevisionCopyWith<$Res> {
  _$WorkoutTemplateRevisionCopyWithImpl(this._self, this._then);

  WorkoutTemplateRevision _self;
  final $Res Function(WorkoutTemplateRevision) _then;

  /// Create a copy of WorkoutTemplateRevision
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? templateId = null,
    Object? revisionNumber = null,
    Object? status = null,
    Object? blocks = null,
    Object? createdById = null,
    Object? createdAt = null,
    Object? changeSummary = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: null == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      revisionNumber: null == revisionNumber
          ? _self.revisionNumber
          : revisionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as TemplateRevisionStatus,
      blocks: null == blocks
          ? _self.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<WorkoutBlock>,
      createdById: null == createdById
          ? _self.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changeSummary: null == changeSummary
          ? _self.changeSummary
          : changeSummary // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkoutTemplateRevision].
extension WorkoutTemplateRevisionPatterns on WorkoutTemplateRevision {
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
    TResult Function(_WorkoutTemplateRevision value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplateRevision() when $default != null:
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
    TResult Function(_WorkoutTemplateRevision value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplateRevision():
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
    TResult? Function(_WorkoutTemplateRevision value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplateRevision() when $default != null:
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
            String templateId,
            int revisionNumber,
            TemplateRevisionStatus status,
            List<WorkoutBlock> blocks,
            String createdById,
            DateTime createdAt,
            String changeSummary)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplateRevision() when $default != null:
        return $default(
            _that.id,
            _that.templateId,
            _that.revisionNumber,
            _that.status,
            _that.blocks,
            _that.createdById,
            _that.createdAt,
            _that.changeSummary);
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
            String templateId,
            int revisionNumber,
            TemplateRevisionStatus status,
            List<WorkoutBlock> blocks,
            String createdById,
            DateTime createdAt,
            String changeSummary)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplateRevision():
        return $default(
            _that.id,
            _that.templateId,
            _that.revisionNumber,
            _that.status,
            _that.blocks,
            _that.createdById,
            _that.createdAt,
            _that.changeSummary);
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
            String templateId,
            int revisionNumber,
            TemplateRevisionStatus status,
            List<WorkoutBlock> blocks,
            String createdById,
            DateTime createdAt,
            String changeSummary)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplateRevision() when $default != null:
        return $default(
            _that.id,
            _that.templateId,
            _that.revisionNumber,
            _that.status,
            _that.blocks,
            _that.createdById,
            _that.createdAt,
            _that.changeSummary);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutTemplateRevision implements WorkoutTemplateRevision {
  const _WorkoutTemplateRevision(
      {required this.id,
      required this.templateId,
      required this.revisionNumber,
      this.status = TemplateRevisionStatus.draft,
      List<WorkoutBlock> blocks = const [],
      required this.createdById,
      required this.createdAt,
      this.changeSummary = ''})
      : _blocks = blocks;
  factory _WorkoutTemplateRevision.fromJson(Map<String, dynamic> json) =>
      _$WorkoutTemplateRevisionFromJson(json);

  @override
  final String id;
  @override
  final String templateId;
  @override
  final int revisionNumber;
  @override
  @JsonKey()
  final TemplateRevisionStatus status;
  final List<WorkoutBlock> _blocks;
  @override
  @JsonKey()
  List<WorkoutBlock> get blocks {
    if (_blocks is EqualUnmodifiableListView) return _blocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blocks);
  }

  @override
  final String createdById;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final String changeSummary;

  /// Create a copy of WorkoutTemplateRevision
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutTemplateRevisionCopyWith<_WorkoutTemplateRevision> get copyWith =>
      __$WorkoutTemplateRevisionCopyWithImpl<_WorkoutTemplateRevision>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutTemplateRevisionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutTemplateRevision &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.revisionNumber, revisionNumber) ||
                other.revisionNumber == revisionNumber) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._blocks, _blocks) &&
            (identical(other.createdById, createdById) ||
                other.createdById == createdById) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.changeSummary, changeSummary) ||
                other.changeSummary == changeSummary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      templateId,
      revisionNumber,
      status,
      const DeepCollectionEquality().hash(_blocks),
      createdById,
      createdAt,
      changeSummary);

  @override
  String toString() {
    return 'WorkoutTemplateRevision(id: $id, templateId: $templateId, revisionNumber: $revisionNumber, status: $status, blocks: $blocks, createdById: $createdById, createdAt: $createdAt, changeSummary: $changeSummary)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutTemplateRevisionCopyWith<$Res>
    implements $WorkoutTemplateRevisionCopyWith<$Res> {
  factory _$WorkoutTemplateRevisionCopyWith(_WorkoutTemplateRevision value,
          $Res Function(_WorkoutTemplateRevision) _then) =
      __$WorkoutTemplateRevisionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String templateId,
      int revisionNumber,
      TemplateRevisionStatus status,
      List<WorkoutBlock> blocks,
      String createdById,
      DateTime createdAt,
      String changeSummary});
}

/// @nodoc
class __$WorkoutTemplateRevisionCopyWithImpl<$Res>
    implements _$WorkoutTemplateRevisionCopyWith<$Res> {
  __$WorkoutTemplateRevisionCopyWithImpl(this._self, this._then);

  final _WorkoutTemplateRevision _self;
  final $Res Function(_WorkoutTemplateRevision) _then;

  /// Create a copy of WorkoutTemplateRevision
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? templateId = null,
    Object? revisionNumber = null,
    Object? status = null,
    Object? blocks = null,
    Object? createdById = null,
    Object? createdAt = null,
    Object? changeSummary = null,
  }) {
    return _then(_WorkoutTemplateRevision(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: null == templateId
          ? _self.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String,
      revisionNumber: null == revisionNumber
          ? _self.revisionNumber
          : revisionNumber // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as TemplateRevisionStatus,
      blocks: null == blocks
          ? _self._blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<WorkoutBlock>,
      createdById: null == createdById
          ? _self.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      changeSummary: null == changeSummary
          ? _self.changeSummary
          : changeSummary // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on

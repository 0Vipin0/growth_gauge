// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionBlock {
  String get id;
  String get sourceTemplateBlockId;
  String get name;
  WorkoutBlockType get type;
  int get rounds;
  int? get timeCapSeconds;
  int? get transitionSeconds;
  List<SessionItem> get items;
  String? get notes;

  /// Create a copy of SessionBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SessionBlockCopyWith<SessionBlock> get copyWith =>
      _$SessionBlockCopyWithImpl<SessionBlock>(
          this as SessionBlock, _$identity);

  /// Serializes this SessionBlock to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionBlock &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceTemplateBlockId, sourceTemplateBlockId) ||
                other.sourceTemplateBlockId == sourceTemplateBlockId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.rounds, rounds) || other.rounds == rounds) &&
            (identical(other.timeCapSeconds, timeCapSeconds) ||
                other.timeCapSeconds == timeCapSeconds) &&
            (identical(other.transitionSeconds, transitionSeconds) ||
                other.transitionSeconds == transitionSeconds) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sourceTemplateBlockId,
      name,
      type,
      rounds,
      timeCapSeconds,
      transitionSeconds,
      const DeepCollectionEquality().hash(items),
      notes);

  @override
  String toString() {
    return 'SessionBlock(id: $id, sourceTemplateBlockId: $sourceTemplateBlockId, name: $name, type: $type, rounds: $rounds, timeCapSeconds: $timeCapSeconds, transitionSeconds: $transitionSeconds, items: $items, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $SessionBlockCopyWith<$Res> {
  factory $SessionBlockCopyWith(
          SessionBlock value, $Res Function(SessionBlock) _then) =
      _$SessionBlockCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String sourceTemplateBlockId,
      String name,
      WorkoutBlockType type,
      int rounds,
      int? timeCapSeconds,
      int? transitionSeconds,
      List<SessionItem> items,
      String? notes});
}

/// @nodoc
class _$SessionBlockCopyWithImpl<$Res> implements $SessionBlockCopyWith<$Res> {
  _$SessionBlockCopyWithImpl(this._self, this._then);

  SessionBlock _self;
  final $Res Function(SessionBlock) _then;

  /// Create a copy of SessionBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceTemplateBlockId = null,
    Object? name = null,
    Object? type = null,
    Object? rounds = null,
    Object? timeCapSeconds = freezed,
    Object? transitionSeconds = freezed,
    Object? items = null,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceTemplateBlockId: null == sourceTemplateBlockId
          ? _self.sourceTemplateBlockId
          : sourceTemplateBlockId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkoutBlockType,
      rounds: null == rounds
          ? _self.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int,
      timeCapSeconds: freezed == timeCapSeconds
          ? _self.timeCapSeconds
          : timeCapSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      transitionSeconds: freezed == transitionSeconds
          ? _self.transitionSeconds
          : transitionSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SessionItem>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SessionBlock].
extension SessionBlockPatterns on SessionBlock {
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
    TResult Function(_SessionBlock value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SessionBlock() when $default != null:
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
    TResult Function(_SessionBlock value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionBlock():
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
    TResult? Function(_SessionBlock value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionBlock() when $default != null:
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
            String sourceTemplateBlockId,
            String name,
            WorkoutBlockType type,
            int rounds,
            int? timeCapSeconds,
            int? transitionSeconds,
            List<SessionItem> items,
            String? notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SessionBlock() when $default != null:
        return $default(
            _that.id,
            _that.sourceTemplateBlockId,
            _that.name,
            _that.type,
            _that.rounds,
            _that.timeCapSeconds,
            _that.transitionSeconds,
            _that.items,
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
            String sourceTemplateBlockId,
            String name,
            WorkoutBlockType type,
            int rounds,
            int? timeCapSeconds,
            int? transitionSeconds,
            List<SessionItem> items,
            String? notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionBlock():
        return $default(
            _that.id,
            _that.sourceTemplateBlockId,
            _that.name,
            _that.type,
            _that.rounds,
            _that.timeCapSeconds,
            _that.transitionSeconds,
            _that.items,
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
            String sourceTemplateBlockId,
            String name,
            WorkoutBlockType type,
            int rounds,
            int? timeCapSeconds,
            int? transitionSeconds,
            List<SessionItem> items,
            String? notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionBlock() when $default != null:
        return $default(
            _that.id,
            _that.sourceTemplateBlockId,
            _that.name,
            _that.type,
            _that.rounds,
            _that.timeCapSeconds,
            _that.transitionSeconds,
            _that.items,
            _that.notes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SessionBlock implements SessionBlock {
  const _SessionBlock(
      {required this.id,
      required this.sourceTemplateBlockId,
      required this.name,
      this.type = WorkoutBlockType.standard,
      this.rounds = 1,
      this.timeCapSeconds,
      this.transitionSeconds,
      List<SessionItem> items = const [],
      this.notes})
      : _items = items;
  factory _SessionBlock.fromJson(Map<String, dynamic> json) =>
      _$SessionBlockFromJson(json);

  @override
  final String id;
  @override
  final String sourceTemplateBlockId;
  @override
  final String name;
  @override
  @JsonKey()
  final WorkoutBlockType type;
  @override
  @JsonKey()
  final int rounds;
  @override
  final int? timeCapSeconds;
  @override
  final int? transitionSeconds;
  final List<SessionItem> _items;
  @override
  @JsonKey()
  List<SessionItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String? notes;

  /// Create a copy of SessionBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SessionBlockCopyWith<_SessionBlock> get copyWith =>
      __$SessionBlockCopyWithImpl<_SessionBlock>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SessionBlockToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SessionBlock &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceTemplateBlockId, sourceTemplateBlockId) ||
                other.sourceTemplateBlockId == sourceTemplateBlockId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.rounds, rounds) || other.rounds == rounds) &&
            (identical(other.timeCapSeconds, timeCapSeconds) ||
                other.timeCapSeconds == timeCapSeconds) &&
            (identical(other.transitionSeconds, transitionSeconds) ||
                other.transitionSeconds == transitionSeconds) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sourceTemplateBlockId,
      name,
      type,
      rounds,
      timeCapSeconds,
      transitionSeconds,
      const DeepCollectionEquality().hash(_items),
      notes);

  @override
  String toString() {
    return 'SessionBlock(id: $id, sourceTemplateBlockId: $sourceTemplateBlockId, name: $name, type: $type, rounds: $rounds, timeCapSeconds: $timeCapSeconds, transitionSeconds: $transitionSeconds, items: $items, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$SessionBlockCopyWith<$Res>
    implements $SessionBlockCopyWith<$Res> {
  factory _$SessionBlockCopyWith(
          _SessionBlock value, $Res Function(_SessionBlock) _then) =
      __$SessionBlockCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String sourceTemplateBlockId,
      String name,
      WorkoutBlockType type,
      int rounds,
      int? timeCapSeconds,
      int? transitionSeconds,
      List<SessionItem> items,
      String? notes});
}

/// @nodoc
class __$SessionBlockCopyWithImpl<$Res>
    implements _$SessionBlockCopyWith<$Res> {
  __$SessionBlockCopyWithImpl(this._self, this._then);

  final _SessionBlock _self;
  final $Res Function(_SessionBlock) _then;

  /// Create a copy of SessionBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? sourceTemplateBlockId = null,
    Object? name = null,
    Object? type = null,
    Object? rounds = null,
    Object? timeCapSeconds = freezed,
    Object? transitionSeconds = freezed,
    Object? items = null,
    Object? notes = freezed,
  }) {
    return _then(_SessionBlock(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceTemplateBlockId: null == sourceTemplateBlockId
          ? _self.sourceTemplateBlockId
          : sourceTemplateBlockId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as WorkoutBlockType,
      rounds: null == rounds
          ? _self.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int,
      timeCapSeconds: freezed == timeCapSeconds
          ? _self.timeCapSeconds
          : timeCapSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      transitionSeconds: freezed == transitionSeconds
          ? _self.transitionSeconds
          : transitionSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SessionItem>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutBlock {
  String get id;
  String get name;
  WorkoutBlockType get type;
  int get rounds;
  int? get timeCapSeconds;
  int? get transitionSeconds;
  List<TemplateItem> get items;
  String? get notes;

  /// Create a copy of WorkoutBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutBlockCopyWith<WorkoutBlock> get copyWith =>
      _$WorkoutBlockCopyWithImpl<WorkoutBlock>(
          this as WorkoutBlock, _$identity);

  /// Serializes this WorkoutBlock to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutBlock &&
            (identical(other.id, id) || other.id == id) &&
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
      name,
      type,
      rounds,
      timeCapSeconds,
      transitionSeconds,
      const DeepCollectionEquality().hash(items),
      notes);

  @override
  String toString() {
    return 'WorkoutBlock(id: $id, name: $name, type: $type, rounds: $rounds, timeCapSeconds: $timeCapSeconds, transitionSeconds: $transitionSeconds, items: $items, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $WorkoutBlockCopyWith<$Res> {
  factory $WorkoutBlockCopyWith(
          WorkoutBlock value, $Res Function(WorkoutBlock) _then) =
      _$WorkoutBlockCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      WorkoutBlockType type,
      int rounds,
      int? timeCapSeconds,
      int? transitionSeconds,
      List<TemplateItem> items,
      String? notes});
}

/// @nodoc
class _$WorkoutBlockCopyWithImpl<$Res> implements $WorkoutBlockCopyWith<$Res> {
  _$WorkoutBlockCopyWithImpl(this._self, this._then);

  final WorkoutBlock _self;
  final $Res Function(WorkoutBlock) _then;

  /// Create a copy of WorkoutBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
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
              as List<TemplateItem>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkoutBlock].
extension WorkoutBlockPatterns on WorkoutBlock {
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
    TResult Function(_WorkoutBlock value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutBlock() when $default != null:
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
    TResult Function(_WorkoutBlock value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutBlock():
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
    TResult? Function(_WorkoutBlock value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutBlock() when $default != null:
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
            String name,
            WorkoutBlockType type,
            int rounds,
            int? timeCapSeconds,
            int? transitionSeconds,
            List<TemplateItem> items,
            String? notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutBlock() when $default != null:
        return $default(
            _that.id,
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
            String name,
            WorkoutBlockType type,
            int rounds,
            int? timeCapSeconds,
            int? transitionSeconds,
            List<TemplateItem> items,
            String? notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutBlock():
        return $default(
            _that.id,
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
            String name,
            WorkoutBlockType type,
            int rounds,
            int? timeCapSeconds,
            int? transitionSeconds,
            List<TemplateItem> items,
            String? notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutBlock() when $default != null:
        return $default(
            _that.id,
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
class _WorkoutBlock implements WorkoutBlock {
  const _WorkoutBlock(
      {required this.id,
      required this.name,
      this.type = WorkoutBlockType.standard,
      this.rounds = 1,
      this.timeCapSeconds,
      this.transitionSeconds,
      final List<TemplateItem> items = const [],
      this.notes})
      : _items = items;
  factory _WorkoutBlock.fromJson(Map<String, dynamic> json) =>
      _$WorkoutBlockFromJson(json);

  @override
  final String id;
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
  final List<TemplateItem> _items;
  @override
  @JsonKey()
  List<TemplateItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String? notes;

  /// Create a copy of WorkoutBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutBlockCopyWith<_WorkoutBlock> get copyWith =>
      __$WorkoutBlockCopyWithImpl<_WorkoutBlock>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutBlockToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutBlock &&
            (identical(other.id, id) || other.id == id) &&
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
      name,
      type,
      rounds,
      timeCapSeconds,
      transitionSeconds,
      const DeepCollectionEquality().hash(_items),
      notes);

  @override
  String toString() {
    return 'WorkoutBlock(id: $id, name: $name, type: $type, rounds: $rounds, timeCapSeconds: $timeCapSeconds, transitionSeconds: $transitionSeconds, items: $items, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutBlockCopyWith<$Res>
    implements $WorkoutBlockCopyWith<$Res> {
  factory _$WorkoutBlockCopyWith(
          _WorkoutBlock value, $Res Function(_WorkoutBlock) _then) =
      __$WorkoutBlockCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      WorkoutBlockType type,
      int rounds,
      int? timeCapSeconds,
      int? transitionSeconds,
      List<TemplateItem> items,
      String? notes});
}

/// @nodoc
class __$WorkoutBlockCopyWithImpl<$Res>
    implements _$WorkoutBlockCopyWith<$Res> {
  __$WorkoutBlockCopyWithImpl(this._self, this._then);

  final _WorkoutBlock _self;
  final $Res Function(_WorkoutBlock) _then;

  /// Create a copy of WorkoutBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? rounds = null,
    Object? timeCapSeconds = freezed,
    Object? transitionSeconds = freezed,
    Object? items = null,
    Object? notes = freezed,
  }) {
    return _then(_WorkoutBlock(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
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
              as List<TemplateItem>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

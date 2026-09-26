// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionItem {
  String get id;
  String get sourceTemplateItemId;
  String get exerciseId;
  int get order;
  List<ExecutionSet> get sets;
  String? get notes;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SessionItemCopyWith<SessionItem> get copyWith =>
      _$SessionItemCopyWithImpl<SessionItem>(this as SessionItem, _$identity);

  /// Serializes this SessionItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceTemplateItemId, sourceTemplateItemId) ||
                other.sourceTemplateItemId == sourceTemplateItemId) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other.sets, sets) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, sourceTemplateItemId,
      exerciseId, order, const DeepCollectionEquality().hash(sets), notes);

  @override
  String toString() {
    return 'SessionItem(id: $id, sourceTemplateItemId: $sourceTemplateItemId, exerciseId: $exerciseId, order: $order, sets: $sets, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $SessionItemCopyWith<$Res> {
  factory $SessionItemCopyWith(
          SessionItem value, $Res Function(SessionItem) _then) =
      _$SessionItemCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String sourceTemplateItemId,
      String exerciseId,
      int order,
      List<ExecutionSet> sets,
      String? notes});
}

/// @nodoc
class _$SessionItemCopyWithImpl<$Res> implements $SessionItemCopyWith<$Res> {
  _$SessionItemCopyWithImpl(this._self, this._then);

  final SessionItem _self;
  final $Res Function(SessionItem) _then;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceTemplateItemId = null,
    Object? exerciseId = null,
    Object? order = null,
    Object? sets = null,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceTemplateItemId: null == sourceTemplateItemId
          ? _self.sourceTemplateItemId
          : sourceTemplateItemId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseId: null == exerciseId
          ? _self.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      sets: null == sets
          ? _self.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExecutionSet>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SessionItem].
extension SessionItemPatterns on SessionItem {
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
    TResult Function(_SessionItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SessionItem() when $default != null:
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
    TResult Function(_SessionItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionItem():
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
    TResult? Function(_SessionItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionItem() when $default != null:
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
    TResult Function(String id, String sourceTemplateItemId, String exerciseId,
            int order, List<ExecutionSet> sets, String? notes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SessionItem() when $default != null:
        return $default(_that.id, _that.sourceTemplateItemId, _that.exerciseId,
            _that.order, _that.sets, _that.notes);
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
    TResult Function(String id, String sourceTemplateItemId, String exerciseId,
            int order, List<ExecutionSet> sets, String? notes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionItem():
        return $default(_that.id, _that.sourceTemplateItemId, _that.exerciseId,
            _that.order, _that.sets, _that.notes);
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
    TResult? Function(String id, String sourceTemplateItemId, String exerciseId,
            int order, List<ExecutionSet> sets, String? notes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SessionItem() when $default != null:
        return $default(_that.id, _that.sourceTemplateItemId, _that.exerciseId,
            _that.order, _that.sets, _that.notes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SessionItem implements SessionItem {
  const _SessionItem(
      {required this.id,
      required this.sourceTemplateItemId,
      required this.exerciseId,
      required this.order,
      final List<ExecutionSet> sets = const [],
      this.notes})
      : _sets = sets;
  factory _SessionItem.fromJson(Map<String, dynamic> json) =>
      _$SessionItemFromJson(json);

  @override
  final String id;
  @override
  final String sourceTemplateItemId;
  @override
  final String exerciseId;
  @override
  final int order;
  final List<ExecutionSet> _sets;
  @override
  @JsonKey()
  List<ExecutionSet> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  final String? notes;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SessionItemCopyWith<_SessionItem> get copyWith =>
      __$SessionItemCopyWithImpl<_SessionItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SessionItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SessionItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceTemplateItemId, sourceTemplateItemId) ||
                other.sourceTemplateItemId == sourceTemplateItemId) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other._sets, _sets) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, sourceTemplateItemId,
      exerciseId, order, const DeepCollectionEquality().hash(_sets), notes);

  @override
  String toString() {
    return 'SessionItem(id: $id, sourceTemplateItemId: $sourceTemplateItemId, exerciseId: $exerciseId, order: $order, sets: $sets, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$SessionItemCopyWith<$Res>
    implements $SessionItemCopyWith<$Res> {
  factory _$SessionItemCopyWith(
          _SessionItem value, $Res Function(_SessionItem) _then) =
      __$SessionItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String sourceTemplateItemId,
      String exerciseId,
      int order,
      List<ExecutionSet> sets,
      String? notes});
}

/// @nodoc
class __$SessionItemCopyWithImpl<$Res> implements _$SessionItemCopyWith<$Res> {
  __$SessionItemCopyWithImpl(this._self, this._then);

  final _SessionItem _self;
  final $Res Function(_SessionItem) _then;

  /// Create a copy of SessionItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? sourceTemplateItemId = null,
    Object? exerciseId = null,
    Object? order = null,
    Object? sets = null,
    Object? notes = freezed,
  }) {
    return _then(_SessionItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceTemplateItemId: null == sourceTemplateItemId
          ? _self.sourceTemplateItemId
          : sourceTemplateItemId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseId: null == exerciseId
          ? _self.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      sets: null == sets
          ? _self._sets
          : sets // ignore: cast_nullable_to_non_nullable
              as List<ExecutionSet>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

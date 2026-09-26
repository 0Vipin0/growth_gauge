// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplateItem {
  String get id;
  String get exerciseId;
  int get order;
  List<TargetSet> get targetSets;
  List<String> get substitutionExerciseIds;
  String? get coachNotes;

  /// Create a copy of TemplateItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TemplateItemCopyWith<TemplateItem> get copyWith =>
      _$TemplateItemCopyWithImpl<TemplateItem>(
          this as TemplateItem, _$identity);

  /// Serializes this TemplateItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TemplateItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality()
                .equals(other.targetSets, targetSets) &&
            const DeepCollectionEquality().equals(
                other.substitutionExerciseIds, substitutionExerciseIds) &&
            (identical(other.coachNotes, coachNotes) ||
                other.coachNotes == coachNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      exerciseId,
      order,
      const DeepCollectionEquality().hash(targetSets),
      const DeepCollectionEquality().hash(substitutionExerciseIds),
      coachNotes);

  @override
  String toString() {
    return 'TemplateItem(id: $id, exerciseId: $exerciseId, order: $order, targetSets: $targetSets, substitutionExerciseIds: $substitutionExerciseIds, coachNotes: $coachNotes)';
  }
}

/// @nodoc
abstract mixin class $TemplateItemCopyWith<$Res> {
  factory $TemplateItemCopyWith(
          TemplateItem value, $Res Function(TemplateItem) _then) =
      _$TemplateItemCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String exerciseId,
      int order,
      List<TargetSet> targetSets,
      List<String> substitutionExerciseIds,
      String? coachNotes});
}

/// @nodoc
class _$TemplateItemCopyWithImpl<$Res> implements $TemplateItemCopyWith<$Res> {
  _$TemplateItemCopyWithImpl(this._self, this._then);

  TemplateItem _self;
  final $Res Function(TemplateItem) _then;

  /// Create a copy of TemplateItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseId = null,
    Object? order = null,
    Object? targetSets = null,
    Object? substitutionExerciseIds = null,
    Object? coachNotes = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseId: null == exerciseId
          ? _self.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      targetSets: null == targetSets
          ? _self.targetSets
          : targetSets // ignore: cast_nullable_to_non_nullable
              as List<TargetSet>,
      substitutionExerciseIds: null == substitutionExerciseIds
          ? _self.substitutionExerciseIds
          : substitutionExerciseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coachNotes: freezed == coachNotes
          ? _self.coachNotes
          : coachNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TemplateItem].
extension TemplateItemPatterns on TemplateItem {
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
    TResult Function(_TemplateItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TemplateItem() when $default != null:
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
    TResult Function(_TemplateItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateItem():
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
    TResult? Function(_TemplateItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateItem() when $default != null:
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
            String exerciseId,
            int order,
            List<TargetSet> targetSets,
            List<String> substitutionExerciseIds,
            String? coachNotes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TemplateItem() when $default != null:
        return $default(_that.id, _that.exerciseId, _that.order,
            _that.targetSets, _that.substitutionExerciseIds, _that.coachNotes);
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
            String exerciseId,
            int order,
            List<TargetSet> targetSets,
            List<String> substitutionExerciseIds,
            String? coachNotes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateItem():
        return $default(_that.id, _that.exerciseId, _that.order,
            _that.targetSets, _that.substitutionExerciseIds, _that.coachNotes);
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
            String exerciseId,
            int order,
            List<TargetSet> targetSets,
            List<String> substitutionExerciseIds,
            String? coachNotes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TemplateItem() when $default != null:
        return $default(_that.id, _that.exerciseId, _that.order,
            _that.targetSets, _that.substitutionExerciseIds, _that.coachNotes);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TemplateItem implements TemplateItem {
  const _TemplateItem(
      {required this.id,
      required this.exerciseId,
      required this.order,
      List<TargetSet> targetSets = const [],
      List<String> substitutionExerciseIds = const [],
      this.coachNotes})
      : _targetSets = targetSets,
        _substitutionExerciseIds = substitutionExerciseIds;
  factory _TemplateItem.fromJson(Map<String, dynamic> json) =>
      _$TemplateItemFromJson(json);

  @override
  final String id;
  @override
  final String exerciseId;
  @override
  final int order;
  final List<TargetSet> _targetSets;
  @override
  @JsonKey()
  List<TargetSet> get targetSets {
    if (_targetSets is EqualUnmodifiableListView) return _targetSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetSets);
  }

  final List<String> _substitutionExerciseIds;
  @override
  @JsonKey()
  List<String> get substitutionExerciseIds {
    if (_substitutionExerciseIds is EqualUnmodifiableListView)
      return _substitutionExerciseIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_substitutionExerciseIds);
  }

  @override
  final String? coachNotes;

  /// Create a copy of TemplateItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TemplateItemCopyWith<_TemplateItem> get copyWith =>
      __$TemplateItemCopyWithImpl<_TemplateItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TemplateItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TemplateItem &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality()
                .equals(other._targetSets, _targetSets) &&
            const DeepCollectionEquality().equals(
                other._substitutionExerciseIds, _substitutionExerciseIds) &&
            (identical(other.coachNotes, coachNotes) ||
                other.coachNotes == coachNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      exerciseId,
      order,
      const DeepCollectionEquality().hash(_targetSets),
      const DeepCollectionEquality().hash(_substitutionExerciseIds),
      coachNotes);

  @override
  String toString() {
    return 'TemplateItem(id: $id, exerciseId: $exerciseId, order: $order, targetSets: $targetSets, substitutionExerciseIds: $substitutionExerciseIds, coachNotes: $coachNotes)';
  }
}

/// @nodoc
abstract mixin class _$TemplateItemCopyWith<$Res>
    implements $TemplateItemCopyWith<$Res> {
  factory _$TemplateItemCopyWith(
          _TemplateItem value, $Res Function(_TemplateItem) _then) =
      __$TemplateItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String exerciseId,
      int order,
      List<TargetSet> targetSets,
      List<String> substitutionExerciseIds,
      String? coachNotes});
}

/// @nodoc
class __$TemplateItemCopyWithImpl<$Res>
    implements _$TemplateItemCopyWith<$Res> {
  __$TemplateItemCopyWithImpl(this._self, this._then);

  final _TemplateItem _self;
  final $Res Function(_TemplateItem) _then;

  /// Create a copy of TemplateItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? exerciseId = null,
    Object? order = null,
    Object? targetSets = null,
    Object? substitutionExerciseIds = null,
    Object? coachNotes = freezed,
  }) {
    return _then(_TemplateItem(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseId: null == exerciseId
          ? _self.exerciseId
          : exerciseId // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      targetSets: null == targetSets
          ? _self._targetSets
          : targetSets // ignore: cast_nullable_to_non_nullable
              as List<TargetSet>,
      substitutionExerciseIds: null == substitutionExerciseIds
          ? _self._substitutionExerciseIds
          : substitutionExerciseIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      coachNotes: freezed == coachNotes
          ? _self.coachNotes
          : coachNotes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

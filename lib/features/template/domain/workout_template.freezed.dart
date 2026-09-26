// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkoutTemplate {
  String get id;
  String get name;
  String get description;

  /// The ID of the currently active (latest published or active draft) revision.
  String? get currentRevisionId;
  String get createdById;
  DateTime get createdAt;
  DateTime get updatedAt;
  bool get isArchived;
  List<String> get tags;

  /// Create a copy of WorkoutTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WorkoutTemplateCopyWith<WorkoutTemplate> get copyWith =>
      _$WorkoutTemplateCopyWithImpl<WorkoutTemplate>(
          this as WorkoutTemplate, _$identity);

  /// Serializes this WorkoutTemplate to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WorkoutTemplate &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.currentRevisionId, currentRevisionId) ||
                other.currentRevisionId == currentRevisionId) &&
            (identical(other.createdById, createdById) ||
                other.createdById == createdById) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      currentRevisionId,
      createdById,
      createdAt,
      updatedAt,
      isArchived,
      const DeepCollectionEquality().hash(tags));

  @override
  String toString() {
    return 'WorkoutTemplate(id: $id, name: $name, description: $description, currentRevisionId: $currentRevisionId, createdById: $createdById, createdAt: $createdAt, updatedAt: $updatedAt, isArchived: $isArchived, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class $WorkoutTemplateCopyWith<$Res> {
  factory $WorkoutTemplateCopyWith(
          WorkoutTemplate value, $Res Function(WorkoutTemplate) _then) =
      _$WorkoutTemplateCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String? currentRevisionId,
      String createdById,
      DateTime createdAt,
      DateTime updatedAt,
      bool isArchived,
      List<String> tags});
}

/// @nodoc
class _$WorkoutTemplateCopyWithImpl<$Res>
    implements $WorkoutTemplateCopyWith<$Res> {
  _$WorkoutTemplateCopyWithImpl(this._self, this._then);

  final WorkoutTemplate _self;
  final $Res Function(WorkoutTemplate) _then;

  /// Create a copy of WorkoutTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? currentRevisionId = freezed,
    Object? createdById = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isArchived = null,
    Object? tags = null,
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
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      currentRevisionId: freezed == currentRevisionId
          ? _self.currentRevisionId
          : currentRevisionId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdById: null == createdById
          ? _self.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isArchived: null == isArchived
          ? _self.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [WorkoutTemplate].
extension WorkoutTemplatePatterns on WorkoutTemplate {
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
    TResult Function(_WorkoutTemplate value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplate() when $default != null:
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
    TResult Function(_WorkoutTemplate value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplate():
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
    TResult? Function(_WorkoutTemplate value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplate() when $default != null:
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
            String description,
            String? currentRevisionId,
            String createdById,
            DateTime createdAt,
            DateTime updatedAt,
            bool isArchived,
            List<String> tags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplate() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.currentRevisionId,
            _that.createdById,
            _that.createdAt,
            _that.updatedAt,
            _that.isArchived,
            _that.tags);
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
            String description,
            String? currentRevisionId,
            String createdById,
            DateTime createdAt,
            DateTime updatedAt,
            bool isArchived,
            List<String> tags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplate():
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.currentRevisionId,
            _that.createdById,
            _that.createdAt,
            _that.updatedAt,
            _that.isArchived,
            _that.tags);
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
            String description,
            String? currentRevisionId,
            String createdById,
            DateTime createdAt,
            DateTime updatedAt,
            bool isArchived,
            List<String> tags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WorkoutTemplate() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.description,
            _that.currentRevisionId,
            _that.createdById,
            _that.createdAt,
            _that.updatedAt,
            _that.isArchived,
            _that.tags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WorkoutTemplate implements WorkoutTemplate {
  const _WorkoutTemplate(
      {required this.id,
      required this.name,
      this.description = '',
      this.currentRevisionId,
      required this.createdById,
      required this.createdAt,
      required this.updatedAt,
      this.isArchived = false,
      final List<String> tags = const []})
      : _tags = tags;
  factory _WorkoutTemplate.fromJson(Map<String, dynamic> json) =>
      _$WorkoutTemplateFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;

  /// The ID of the currently active (latest published or active draft) revision.
  @override
  final String? currentRevisionId;
  @override
  final String createdById;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final bool isArchived;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Create a copy of WorkoutTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WorkoutTemplateCopyWith<_WorkoutTemplate> get copyWith =>
      __$WorkoutTemplateCopyWithImpl<_WorkoutTemplate>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WorkoutTemplateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WorkoutTemplate &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.currentRevisionId, currentRevisionId) ||
                other.currentRevisionId == currentRevisionId) &&
            (identical(other.createdById, createdById) ||
                other.createdById == createdById) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      currentRevisionId,
      createdById,
      createdAt,
      updatedAt,
      isArchived,
      const DeepCollectionEquality().hash(_tags));

  @override
  String toString() {
    return 'WorkoutTemplate(id: $id, name: $name, description: $description, currentRevisionId: $currentRevisionId, createdById: $createdById, createdAt: $createdAt, updatedAt: $updatedAt, isArchived: $isArchived, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class _$WorkoutTemplateCopyWith<$Res>
    implements $WorkoutTemplateCopyWith<$Res> {
  factory _$WorkoutTemplateCopyWith(
          _WorkoutTemplate value, $Res Function(_WorkoutTemplate) _then) =
      __$WorkoutTemplateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String? currentRevisionId,
      String createdById,
      DateTime createdAt,
      DateTime updatedAt,
      bool isArchived,
      List<String> tags});
}

/// @nodoc
class __$WorkoutTemplateCopyWithImpl<$Res>
    implements _$WorkoutTemplateCopyWith<$Res> {
  __$WorkoutTemplateCopyWithImpl(this._self, this._then);

  final _WorkoutTemplate _self;
  final $Res Function(_WorkoutTemplate) _then;

  /// Create a copy of WorkoutTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? currentRevisionId = freezed,
    Object? createdById = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isArchived = null,
    Object? tags = null,
  }) {
    return _then(_WorkoutTemplate(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      currentRevisionId: freezed == currentRevisionId
          ? _self.currentRevisionId
          : currentRevisionId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdById: null == createdById
          ? _self.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isArchived: null == isArchived
          ? _self.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on

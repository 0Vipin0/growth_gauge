// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Exercise {
  String get id;
  String get name;
  List<String> get aliases;
  String get description;
  ExerciseStatus get status;
  ExerciseSourceType get sourceType;
  String? get createdById;
  String? get forkedFromExerciseId;
  int get version;
  DateTime get createdAt;
  DateTime get updatedAt;
  ExerciseClassification get classification;
  ExerciseExecutionProfile get execution;
  ExerciseEquipmentProfile get equipment;
  List<ExerciseRelationship> get relationships;
  ExerciseMeasurementProfile get measurementProfile;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseCopyWith<Exercise> get copyWith =>
      _$ExerciseCopyWithImpl<Exercise>(this as Exercise, _$identity);

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Exercise &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.aliases, aliases) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.createdById, createdById) ||
                other.createdById == createdById) &&
            (identical(other.forkedFromExerciseId, forkedFromExerciseId) ||
                other.forkedFromExerciseId == forkedFromExerciseId) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.classification, classification) ||
                other.classification == classification) &&
            (identical(other.execution, execution) ||
                other.execution == execution) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            const DeepCollectionEquality()
                .equals(other.relationships, relationships) &&
            (identical(other.measurementProfile, measurementProfile) ||
                other.measurementProfile == measurementProfile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(aliases),
      description,
      status,
      sourceType,
      createdById,
      forkedFromExerciseId,
      version,
      createdAt,
      updatedAt,
      classification,
      execution,
      equipment,
      const DeepCollectionEquality().hash(relationships),
      measurementProfile);

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, aliases: $aliases, description: $description, status: $status, sourceType: $sourceType, createdById: $createdById, forkedFromExerciseId: $forkedFromExerciseId, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, classification: $classification, execution: $execution, equipment: $equipment, relationships: $relationships, measurementProfile: $measurementProfile)';
  }
}

/// @nodoc
abstract mixin class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) _then) =
      _$ExerciseCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> aliases,
      String description,
      ExerciseStatus status,
      ExerciseSourceType sourceType,
      String? createdById,
      String? forkedFromExerciseId,
      int version,
      DateTime createdAt,
      DateTime updatedAt,
      ExerciseClassification classification,
      ExerciseExecutionProfile execution,
      ExerciseEquipmentProfile equipment,
      List<ExerciseRelationship> relationships,
      ExerciseMeasurementProfile measurementProfile});

  $ExerciseClassificationCopyWith<$Res> get classification;
  $ExerciseExecutionProfileCopyWith<$Res> get execution;
  $ExerciseEquipmentProfileCopyWith<$Res> get equipment;
  $ExerciseMeasurementProfileCopyWith<$Res> get measurementProfile;
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res> implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._self, this._then);

  final Exercise _self;
  final $Res Function(Exercise) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? aliases = null,
    Object? description = null,
    Object? status = null,
    Object? sourceType = null,
    Object? createdById = freezed,
    Object? forkedFromExerciseId = freezed,
    Object? version = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? classification = null,
    Object? execution = null,
    Object? equipment = null,
    Object? relationships = null,
    Object? measurementProfile = null,
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
      aliases: null == aliases
          ? _self.aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExerciseStatus,
      sourceType: null == sourceType
          ? _self.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as ExerciseSourceType,
      createdById: freezed == createdById
          ? _self.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
      forkedFromExerciseId: freezed == forkedFromExerciseId
          ? _self.forkedFromExerciseId
          : forkedFromExerciseId // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      classification: null == classification
          ? _self.classification
          : classification // ignore: cast_nullable_to_non_nullable
              as ExerciseClassification,
      execution: null == execution
          ? _self.execution
          : execution // ignore: cast_nullable_to_non_nullable
              as ExerciseExecutionProfile,
      equipment: null == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as ExerciseEquipmentProfile,
      relationships: null == relationships
          ? _self.relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as List<ExerciseRelationship>,
      measurementProfile: null == measurementProfile
          ? _self.measurementProfile
          : measurementProfile // ignore: cast_nullable_to_non_nullable
              as ExerciseMeasurementProfile,
    ));
  }

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseClassificationCopyWith<$Res> get classification {
    return $ExerciseClassificationCopyWith<$Res>(_self.classification, (value) {
      return _then(_self.copyWith(classification: value));
    });
  }

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseExecutionProfileCopyWith<$Res> get execution {
    return $ExerciseExecutionProfileCopyWith<$Res>(_self.execution, (value) {
      return _then(_self.copyWith(execution: value));
    });
  }

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseEquipmentProfileCopyWith<$Res> get equipment {
    return $ExerciseEquipmentProfileCopyWith<$Res>(_self.equipment, (value) {
      return _then(_self.copyWith(equipment: value));
    });
  }

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseMeasurementProfileCopyWith<$Res> get measurementProfile {
    return $ExerciseMeasurementProfileCopyWith<$Res>(_self.measurementProfile,
        (value) {
      return _then(_self.copyWith(measurementProfile: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Exercise].
extension ExercisePatterns on Exercise {
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
    TResult Function(_Exercise value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Exercise() when $default != null:
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
    TResult Function(_Exercise value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Exercise():
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
    TResult? Function(_Exercise value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Exercise() when $default != null:
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
            List<String> aliases,
            String description,
            ExerciseStatus status,
            ExerciseSourceType sourceType,
            String? createdById,
            String? forkedFromExerciseId,
            int version,
            DateTime createdAt,
            DateTime updatedAt,
            ExerciseClassification classification,
            ExerciseExecutionProfile execution,
            ExerciseEquipmentProfile equipment,
            List<ExerciseRelationship> relationships,
            ExerciseMeasurementProfile measurementProfile)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Exercise() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.aliases,
            _that.description,
            _that.status,
            _that.sourceType,
            _that.createdById,
            _that.forkedFromExerciseId,
            _that.version,
            _that.createdAt,
            _that.updatedAt,
            _that.classification,
            _that.execution,
            _that.equipment,
            _that.relationships,
            _that.measurementProfile);
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
            List<String> aliases,
            String description,
            ExerciseStatus status,
            ExerciseSourceType sourceType,
            String? createdById,
            String? forkedFromExerciseId,
            int version,
            DateTime createdAt,
            DateTime updatedAt,
            ExerciseClassification classification,
            ExerciseExecutionProfile execution,
            ExerciseEquipmentProfile equipment,
            List<ExerciseRelationship> relationships,
            ExerciseMeasurementProfile measurementProfile)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Exercise():
        return $default(
            _that.id,
            _that.name,
            _that.aliases,
            _that.description,
            _that.status,
            _that.sourceType,
            _that.createdById,
            _that.forkedFromExerciseId,
            _that.version,
            _that.createdAt,
            _that.updatedAt,
            _that.classification,
            _that.execution,
            _that.equipment,
            _that.relationships,
            _that.measurementProfile);
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
            List<String> aliases,
            String description,
            ExerciseStatus status,
            ExerciseSourceType sourceType,
            String? createdById,
            String? forkedFromExerciseId,
            int version,
            DateTime createdAt,
            DateTime updatedAt,
            ExerciseClassification classification,
            ExerciseExecutionProfile execution,
            ExerciseEquipmentProfile equipment,
            List<ExerciseRelationship> relationships,
            ExerciseMeasurementProfile measurementProfile)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Exercise() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.aliases,
            _that.description,
            _that.status,
            _that.sourceType,
            _that.createdById,
            _that.forkedFromExerciseId,
            _that.version,
            _that.createdAt,
            _that.updatedAt,
            _that.classification,
            _that.execution,
            _that.equipment,
            _that.relationships,
            _that.measurementProfile);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Exercise implements Exercise {
  const _Exercise(
      {required this.id,
      required this.name,
      final List<String> aliases = const [],
      this.description = '',
      this.status = ExerciseStatus.active,
      this.sourceType = ExerciseSourceType.system,
      this.createdById,
      this.forkedFromExerciseId,
      this.version = 1,
      required this.createdAt,
      required this.updatedAt,
      this.classification = const ExerciseClassification(),
      this.execution = const ExerciseExecutionProfile(),
      this.equipment = const ExerciseEquipmentProfile(),
      final List<ExerciseRelationship> relationships = const [],
      this.measurementProfile = const ExerciseMeasurementProfile()})
      : _aliases = aliases,
        _relationships = relationships;
  factory _Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _aliases;
  @override
  @JsonKey()
  List<String> get aliases {
    if (_aliases is EqualUnmodifiableListView) return _aliases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_aliases);
  }

  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final ExerciseStatus status;
  @override
  @JsonKey()
  final ExerciseSourceType sourceType;
  @override
  final String? createdById;
  @override
  final String? forkedFromExerciseId;
  @override
  @JsonKey()
  final int version;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  @JsonKey()
  final ExerciseClassification classification;
  @override
  @JsonKey()
  final ExerciseExecutionProfile execution;
  @override
  @JsonKey()
  final ExerciseEquipmentProfile equipment;
  final List<ExerciseRelationship> _relationships;
  @override
  @JsonKey()
  List<ExerciseRelationship> get relationships {
    if (_relationships is EqualUnmodifiableListView) return _relationships;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relationships);
  }

  @override
  @JsonKey()
  final ExerciseMeasurementProfile measurementProfile;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseCopyWith<_Exercise> get copyWith =>
      __$ExerciseCopyWithImpl<_Exercise>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExerciseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Exercise &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._aliases, _aliases) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.createdById, createdById) ||
                other.createdById == createdById) &&
            (identical(other.forkedFromExerciseId, forkedFromExerciseId) ||
                other.forkedFromExerciseId == forkedFromExerciseId) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.classification, classification) ||
                other.classification == classification) &&
            (identical(other.execution, execution) ||
                other.execution == execution) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            const DeepCollectionEquality()
                .equals(other._relationships, _relationships) &&
            (identical(other.measurementProfile, measurementProfile) ||
                other.measurementProfile == measurementProfile));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_aliases),
      description,
      status,
      sourceType,
      createdById,
      forkedFromExerciseId,
      version,
      createdAt,
      updatedAt,
      classification,
      execution,
      equipment,
      const DeepCollectionEquality().hash(_relationships),
      measurementProfile);

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, aliases: $aliases, description: $description, status: $status, sourceType: $sourceType, createdById: $createdById, forkedFromExerciseId: $forkedFromExerciseId, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, classification: $classification, execution: $execution, equipment: $equipment, relationships: $relationships, measurementProfile: $measurementProfile)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$ExerciseCopyWith(_Exercise value, $Res Function(_Exercise) _then) =
      __$ExerciseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> aliases,
      String description,
      ExerciseStatus status,
      ExerciseSourceType sourceType,
      String? createdById,
      String? forkedFromExerciseId,
      int version,
      DateTime createdAt,
      DateTime updatedAt,
      ExerciseClassification classification,
      ExerciseExecutionProfile execution,
      ExerciseEquipmentProfile equipment,
      List<ExerciseRelationship> relationships,
      ExerciseMeasurementProfile measurementProfile});

  @override
  $ExerciseClassificationCopyWith<$Res> get classification;
  @override
  $ExerciseExecutionProfileCopyWith<$Res> get execution;
  @override
  $ExerciseEquipmentProfileCopyWith<$Res> get equipment;
  @override
  $ExerciseMeasurementProfileCopyWith<$Res> get measurementProfile;
}

/// @nodoc
class __$ExerciseCopyWithImpl<$Res> implements _$ExerciseCopyWith<$Res> {
  __$ExerciseCopyWithImpl(this._self, this._then);

  final _Exercise _self;
  final $Res Function(_Exercise) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? aliases = null,
    Object? description = null,
    Object? status = null,
    Object? sourceType = null,
    Object? createdById = freezed,
    Object? forkedFromExerciseId = freezed,
    Object? version = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? classification = null,
    Object? execution = null,
    Object? equipment = null,
    Object? relationships = null,
    Object? measurementProfile = null,
  }) {
    return _then(_Exercise(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aliases: null == aliases
          ? _self._aliases
          : aliases // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExerciseStatus,
      sourceType: null == sourceType
          ? _self.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as ExerciseSourceType,
      createdById: freezed == createdById
          ? _self.createdById
          : createdById // ignore: cast_nullable_to_non_nullable
              as String?,
      forkedFromExerciseId: freezed == forkedFromExerciseId
          ? _self.forkedFromExerciseId
          : forkedFromExerciseId // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      classification: null == classification
          ? _self.classification
          : classification // ignore: cast_nullable_to_non_nullable
              as ExerciseClassification,
      execution: null == execution
          ? _self.execution
          : execution // ignore: cast_nullable_to_non_nullable
              as ExerciseExecutionProfile,
      equipment: null == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as ExerciseEquipmentProfile,
      relationships: null == relationships
          ? _self._relationships
          : relationships // ignore: cast_nullable_to_non_nullable
              as List<ExerciseRelationship>,
      measurementProfile: null == measurementProfile
          ? _self.measurementProfile
          : measurementProfile // ignore: cast_nullable_to_non_nullable
              as ExerciseMeasurementProfile,
    ));
  }

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseClassificationCopyWith<$Res> get classification {
    return $ExerciseClassificationCopyWith<$Res>(_self.classification, (value) {
      return _then(_self.copyWith(classification: value));
    });
  }

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseExecutionProfileCopyWith<$Res> get execution {
    return $ExerciseExecutionProfileCopyWith<$Res>(_self.execution, (value) {
      return _then(_self.copyWith(execution: value));
    });
  }

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseEquipmentProfileCopyWith<$Res> get equipment {
    return $ExerciseEquipmentProfileCopyWith<$Res>(_self.equipment, (value) {
      return _then(_self.copyWith(equipment: value));
    });
  }

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseMeasurementProfileCopyWith<$Res> get measurementProfile {
    return $ExerciseMeasurementProfileCopyWith<$Res>(_self.measurementProfile,
        (value) {
      return _then(_self.copyWith(measurementProfile: value));
    });
  }
}

// dart format on

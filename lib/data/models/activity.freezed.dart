// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'countBased':
      return CountBasedActivity.fromJson(json);
    case 'timeBased':
      return TimeBasedActivity.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Activity',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Activity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  String? get goalId => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            int count)
        countBased,
    required TResult Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            Duration duration)
        timeBased,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String name, String? description, String unit,
            bool isFavorite, String? goalId, List<String>? tags, int count)?
        countBased,
    TResult? Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            Duration duration)?
        timeBased,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, String? description, String unit,
            bool isFavorite, String? goalId, List<String>? tags, int count)?
        countBased,
    TResult Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            Duration duration)?
        timeBased,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CountBasedActivity value) countBased,
    required TResult Function(TimeBasedActivity value) timeBased,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CountBasedActivity value)? countBased,
    TResult? Function(TimeBasedActivity value)? timeBased,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CountBasedActivity value)? countBased,
    TResult Function(TimeBasedActivity value)? timeBased,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this Activity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityCopyWith<Activity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityCopyWith<$Res> {
  factory $ActivityCopyWith(Activity value, $Res Function(Activity) then) =
      _$ActivityCopyWithImpl<$Res, Activity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String unit,
      bool isFavorite,
      String? goalId,
      List<String>? tags});
}

/// @nodoc
class _$ActivityCopyWithImpl<$Res, $Val extends Activity>
    implements $ActivityCopyWith<$Res> {
  _$ActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? unit = null,
    Object? isFavorite = null,
    Object? goalId = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      goalId: freezed == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CountBasedActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$CountBasedActivityImplCopyWith(_$CountBasedActivityImpl value,
          $Res Function(_$CountBasedActivityImpl) then) =
      __$$CountBasedActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String unit,
      bool isFavorite,
      String? goalId,
      List<String>? tags,
      int count});
}

/// @nodoc
class __$$CountBasedActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$CountBasedActivityImpl>
    implements _$$CountBasedActivityImplCopyWith<$Res> {
  __$$CountBasedActivityImplCopyWithImpl(_$CountBasedActivityImpl _value,
      $Res Function(_$CountBasedActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? unit = null,
    Object? isFavorite = null,
    Object? goalId = freezed,
    Object? tags = freezed,
    Object? count = null,
  }) {
    return _then(_$CountBasedActivityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      goalId: freezed == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CountBasedActivityImpl implements CountBasedActivity {
  const _$CountBasedActivityImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.unit,
      this.isFavorite = false,
      this.goalId,
      final List<String>? tags,
      required this.count,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'countBased';

  factory _$CountBasedActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountBasedActivityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String unit;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  final String? goalId;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// --- Count-Specific Field ---
  @override
  final int count;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Activity.countBased(id: $id, name: $name, description: $description, unit: $unit, isFavorite: $isFavorite, goalId: $goalId, tags: $tags, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountBasedActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, unit,
      isFavorite, goalId, const DeepCollectionEquality().hash(_tags), count);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountBasedActivityImplCopyWith<_$CountBasedActivityImpl> get copyWith =>
      __$$CountBasedActivityImplCopyWithImpl<_$CountBasedActivityImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            int count)
        countBased,
    required TResult Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            Duration duration)
        timeBased,
  }) {
    return countBased(
        id, name, description, unit, isFavorite, goalId, tags, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String name, String? description, String unit,
            bool isFavorite, String? goalId, List<String>? tags, int count)?
        countBased,
    TResult? Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            Duration duration)?
        timeBased,
  }) {
    return countBased?.call(
        id, name, description, unit, isFavorite, goalId, tags, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, String? description, String unit,
            bool isFavorite, String? goalId, List<String>? tags, int count)?
        countBased,
    TResult Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            Duration duration)?
        timeBased,
    required TResult orElse(),
  }) {
    if (countBased != null) {
      return countBased(
          id, name, description, unit, isFavorite, goalId, tags, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CountBasedActivity value) countBased,
    required TResult Function(TimeBasedActivity value) timeBased,
  }) {
    return countBased(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CountBasedActivity value)? countBased,
    TResult? Function(TimeBasedActivity value)? timeBased,
  }) {
    return countBased?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CountBasedActivity value)? countBased,
    TResult Function(TimeBasedActivity value)? timeBased,
    required TResult orElse(),
  }) {
    if (countBased != null) {
      return countBased(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CountBasedActivityImplToJson(
      this,
    );
  }
}

abstract class CountBasedActivity implements Activity, ActivityBase {
  const factory CountBasedActivity(
      {required final String id,
      required final String name,
      final String? description,
      required final String unit,
      final bool isFavorite,
      final String? goalId,
      final List<String>? tags,
      required final int count}) = _$CountBasedActivityImpl;

  factory CountBasedActivity.fromJson(Map<String, dynamic> json) =
      _$CountBasedActivityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get unit;
  @override
  bool get isFavorite;
  @override
  String? get goalId;
  @override
  List<String>? get tags; // --- Count-Specific Field ---
  int get count;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountBasedActivityImplCopyWith<_$CountBasedActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TimeBasedActivityImplCopyWith<$Res>
    implements $ActivityCopyWith<$Res> {
  factory _$$TimeBasedActivityImplCopyWith(_$TimeBasedActivityImpl value,
          $Res Function(_$TimeBasedActivityImpl) then) =
      __$$TimeBasedActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      String unit,
      bool isFavorite,
      String? goalId,
      List<String>? tags,
      Duration duration});
}

/// @nodoc
class __$$TimeBasedActivityImplCopyWithImpl<$Res>
    extends _$ActivityCopyWithImpl<$Res, _$TimeBasedActivityImpl>
    implements _$$TimeBasedActivityImplCopyWith<$Res> {
  __$$TimeBasedActivityImplCopyWithImpl(_$TimeBasedActivityImpl _value,
      $Res Function(_$TimeBasedActivityImpl) _then)
      : super(_value, _then);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? unit = null,
    Object? isFavorite = null,
    Object? goalId = freezed,
    Object? tags = freezed,
    Object? duration = null,
  }) {
    return _then(_$TimeBasedActivityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      goalId: freezed == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeBasedActivityImpl implements TimeBasedActivity {
  const _$TimeBasedActivityImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.unit,
      this.isFavorite = false,
      this.goalId,
      final List<String>? tags,
      required this.duration,
      final String? $type})
      : _tags = tags,
        $type = $type ?? 'timeBased';

  factory _$TimeBasedActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeBasedActivityImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String unit;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  final String? goalId;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// --- Time-Specific Field ---
  @override
  final Duration duration;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'Activity.timeBased(id: $id, name: $name, description: $description, unit: $unit, isFavorite: $isFavorite, goalId: $goalId, tags: $tags, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeBasedActivityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, unit,
      isFavorite, goalId, const DeepCollectionEquality().hash(_tags), duration);

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeBasedActivityImplCopyWith<_$TimeBasedActivityImpl> get copyWith =>
      __$$TimeBasedActivityImplCopyWithImpl<_$TimeBasedActivityImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            int count)
        countBased,
    required TResult Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            Duration duration)
        timeBased,
  }) {
    return timeBased(
        id, name, description, unit, isFavorite, goalId, tags, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String name, String? description, String unit,
            bool isFavorite, String? goalId, List<String>? tags, int count)?
        countBased,
    TResult? Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            Duration duration)?
        timeBased,
  }) {
    return timeBased?.call(
        id, name, description, unit, isFavorite, goalId, tags, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String name, String? description, String unit,
            bool isFavorite, String? goalId, List<String>? tags, int count)?
        countBased,
    TResult Function(
            String id,
            String name,
            String? description,
            String unit,
            bool isFavorite,
            String? goalId,
            List<String>? tags,
            Duration duration)?
        timeBased,
    required TResult orElse(),
  }) {
    if (timeBased != null) {
      return timeBased(
          id, name, description, unit, isFavorite, goalId, tags, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CountBasedActivity value) countBased,
    required TResult Function(TimeBasedActivity value) timeBased,
  }) {
    return timeBased(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CountBasedActivity value)? countBased,
    TResult? Function(TimeBasedActivity value)? timeBased,
  }) {
    return timeBased?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CountBasedActivity value)? countBased,
    TResult Function(TimeBasedActivity value)? timeBased,
    required TResult orElse(),
  }) {
    if (timeBased != null) {
      return timeBased(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeBasedActivityImplToJson(
      this,
    );
  }
}

abstract class TimeBasedActivity implements Activity, ActivityBase {
  const factory TimeBasedActivity(
      {required final String id,
      required final String name,
      final String? description,
      required final String unit,
      final bool isFavorite,
      final String? goalId,
      final List<String>? tags,
      required final Duration duration}) = _$TimeBasedActivityImpl;

  factory TimeBasedActivity.fromJson(Map<String, dynamic> json) =
      _$TimeBasedActivityImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String get unit;
  @override
  bool get isFavorite;
  @override
  String? get goalId;
  @override
  List<String>? get tags; // --- Time-Specific Field ---
  Duration get duration;

  /// Create a copy of Activity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeBasedActivityImplCopyWith<_$TimeBasedActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivityLog _$ActivityLogFromJson(Map<String, dynamic> json) {
  return _ActivityLog.fromJson(json);
}

/// @nodoc
mixin _$ActivityLog {
  String get id => throw _privateConstructorUsedError;
  String get activityId =>
      throw _privateConstructorUsedError; // Assuming you want 'activityId' for the field name
  DateTime get timestamp => throw _privateConstructorUsedError;
  double get value =>
      throw _privateConstructorUsedError; // Can be count or duration (in seconds/minutes)
  String? get notes => throw _privateConstructorUsedError;
  int? get rpe => throw _privateConstructorUsedError;

  /// Serializes this ActivityLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityLogCopyWith<ActivityLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityLogCopyWith<$Res> {
  factory $ActivityLogCopyWith(
          ActivityLog value, $Res Function(ActivityLog) then) =
      _$ActivityLogCopyWithImpl<$Res, ActivityLog>;
  @useResult
  $Res call(
      {String id,
      String activityId,
      DateTime timestamp,
      double value,
      String? notes,
      int? rpe});
}

/// @nodoc
class _$ActivityLogCopyWithImpl<$Res, $Val extends ActivityLog>
    implements $ActivityLogCopyWith<$Res> {
  _$ActivityLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activityId = null,
    Object? timestamp = null,
    Object? value = null,
    Object? notes = freezed,
    Object? rpe = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      rpe: freezed == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityLogImplCopyWith<$Res>
    implements $ActivityLogCopyWith<$Res> {
  factory _$$ActivityLogImplCopyWith(
          _$ActivityLogImpl value, $Res Function(_$ActivityLogImpl) then) =
      __$$ActivityLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String activityId,
      DateTime timestamp,
      double value,
      String? notes,
      int? rpe});
}

/// @nodoc
class __$$ActivityLogImplCopyWithImpl<$Res>
    extends _$ActivityLogCopyWithImpl<$Res, _$ActivityLogImpl>
    implements _$$ActivityLogImplCopyWith<$Res> {
  __$$ActivityLogImplCopyWithImpl(
      _$ActivityLogImpl _value, $Res Function(_$ActivityLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? activityId = null,
    Object? timestamp = null,
    Object? value = null,
    Object? notes = freezed,
    Object? rpe = freezed,
  }) {
    return _then(_$ActivityLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      activityId: null == activityId
          ? _value.activityId
          : activityId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      rpe: freezed == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityLogImpl implements _ActivityLog {
  const _$ActivityLogImpl(
      {required this.id,
      required this.activityId,
      required this.timestamp,
      required this.value,
      this.notes,
      this.rpe});

  factory _$ActivityLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityLogImplFromJson(json);

  @override
  final String id;
  @override
  final String activityId;
// Assuming you want 'activityId' for the field name
  @override
  final DateTime timestamp;
  @override
  final double value;
// Can be count or duration (in seconds/minutes)
  @override
  final String? notes;
  @override
  final int? rpe;

  @override
  String toString() {
    return 'ActivityLog(id: $id, activityId: $activityId, timestamp: $timestamp, value: $value, notes: $notes, rpe: $rpe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.activityId, activityId) ||
                other.activityId == activityId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.rpe, rpe) || other.rpe == rpe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, activityId, timestamp, value, notes, rpe);

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityLogImplCopyWith<_$ActivityLogImpl> get copyWith =>
      __$$ActivityLogImplCopyWithImpl<_$ActivityLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityLogImplToJson(
      this,
    );
  }
}

abstract class _ActivityLog implements ActivityLog {
  const factory _ActivityLog(
      {required final String id,
      required final String activityId,
      required final DateTime timestamp,
      required final double value,
      final String? notes,
      final int? rpe}) = _$ActivityLogImpl;

  factory _ActivityLog.fromJson(Map<String, dynamic> json) =
      _$ActivityLogImpl.fromJson;

  @override
  String get id;
  @override
  String get activityId; // Assuming you want 'activityId' for the field name
  @override
  DateTime get timestamp;
  @override
  double get value; // Can be count or duration (in seconds/minutes)
  @override
  String? get notes;
  @override
  int? get rpe;

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityLogImplCopyWith<_$ActivityLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double? get targetValue => throw _privateConstructorUsedError;
  double? get currentValue => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;

  /// Serializes this Goal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res, Goal>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      double? targetValue,
      double? currentValue,
      DateTime startDate,
      DateTime? endDate});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res, $Val extends Goal>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? targetValue = freezed,
    Object? currentValue = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: freezed == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double?,
      currentValue: freezed == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalImplCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$GoalImplCopyWith(
          _$GoalImpl value, $Res Function(_$GoalImpl) then) =
      __$$GoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      double? targetValue,
      double? currentValue,
      DateTime startDate,
      DateTime? endDate});
}

/// @nodoc
class __$$GoalImplCopyWithImpl<$Res>
    extends _$GoalCopyWithImpl<$Res, _$GoalImpl>
    implements _$$GoalImplCopyWith<$Res> {
  __$$GoalImplCopyWithImpl(_$GoalImpl _value, $Res Function(_$GoalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? targetValue = freezed,
    Object? currentValue = freezed,
    Object? startDate = null,
    Object? endDate = freezed,
  }) {
    return _then(_$GoalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: freezed == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as double?,
      currentValue: freezed == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double?,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalImpl implements _Goal {
  const _$GoalImpl(
      {required this.id,
      required this.name,
      required this.type,
      this.targetValue,
      this.currentValue,
      required this.startDate,
      this.endDate});

  factory _$GoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final double? targetValue;
  @override
  final double? currentValue;
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'Goal(id: $id, name: $name, type: $type, targetValue: $targetValue, currentValue: $currentValue, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, targetValue,
      currentValue, startDate, endDate);

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      __$$GoalImplCopyWithImpl<_$GoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalImplToJson(
      this,
    );
  }
}

abstract class _Goal implements Goal {
  const factory _Goal(
      {required final String id,
      required final String name,
      required final String type,
      final double? targetValue,
      final double? currentValue,
      required final DateTime startDate,
      final DateTime? endDate}) = _$GoalImpl;

  factory _Goal.fromJson(Map<String, dynamic> json) = _$GoalImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  double? get targetValue;
  @override
  double? get currentValue;
  @override
  DateTime get startDate;
  @override
  DateTime? get endDate;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

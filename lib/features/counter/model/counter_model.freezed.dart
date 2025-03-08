// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'counter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CounterModel _$CounterModelFromJson(Map<String, dynamic> json) {
  return _CounterModel.fromJson(json);
}

/// @nodoc
mixin _$CounterModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<CounterLog> get logs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CounterModelCopyWith<CounterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterModelCopyWith<$Res> {
  factory $CounterModelCopyWith(
          CounterModel value, $Res Function(CounterModel) then) =
      _$CounterModelCopyWithImpl<$Res, CounterModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      int count,
      String description,
      List<CounterLog> logs});
}

/// @nodoc
class _$CounterModelCopyWithImpl<$Res, $Val extends CounterModel>
    implements $CounterModelCopyWith<$Res> {
  _$CounterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? count = null,
    Object? description = null,
    Object? logs = null,
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
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<CounterLog>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CounterModelImplCopyWith<$Res>
    implements $CounterModelCopyWith<$Res> {
  factory _$$CounterModelImplCopyWith(
          _$CounterModelImpl value, $Res Function(_$CounterModelImpl) then) =
      __$$CounterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int count,
      String description,
      List<CounterLog> logs});
}

/// @nodoc
class __$$CounterModelImplCopyWithImpl<$Res>
    extends _$CounterModelCopyWithImpl<$Res, _$CounterModelImpl>
    implements _$$CounterModelImplCopyWith<$Res> {
  __$$CounterModelImplCopyWithImpl(
      _$CounterModelImpl _value, $Res Function(_$CounterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? count = null,
    Object? description = null,
    Object? logs = null,
  }) {
    return _then(_$CounterModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _value._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<CounterLog>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CounterModelImpl implements _CounterModel {
  _$CounterModelImpl(
      {required this.id,
      required this.name,
      required this.count,
      required this.description,
      required final List<CounterLog> logs})
      : _logs = logs;

  factory _$CounterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CounterModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int count;
  @override
  final String description;
  final List<CounterLog> _logs;
  @override
  List<CounterLog> get logs {
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logs);
  }

  @override
  String toString() {
    return 'CounterModel(id: $id, name: $name, count: $count, description: $description, logs: $logs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CounterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._logs, _logs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, count, description,
      const DeepCollectionEquality().hash(_logs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CounterModelImplCopyWith<_$CounterModelImpl> get copyWith =>
      __$$CounterModelImplCopyWithImpl<_$CounterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CounterModelImplToJson(
      this,
    );
  }
}

abstract class _CounterModel implements CounterModel {
  factory _CounterModel(
      {required final String id,
      required final String name,
      required final int count,
      required final String description,
      required final List<CounterLog> logs}) = _$CounterModelImpl;

  factory _CounterModel.fromJson(Map<String, dynamic> json) =
      _$CounterModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get count;
  @override
  String get description;
  @override
  List<CounterLog> get logs;
  @override
  @JsonKey(ignore: true)
  _$$CounterModelImplCopyWith<_$CounterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CounterLog _$CounterLogFromJson(Map<String, dynamic> json) {
  return _CounterLog.fromJson(json);
}

/// @nodoc
mixin _$CounterLog {
  String get id => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CounterLogCopyWith<CounterLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterLogCopyWith<$Res> {
  factory $CounterLogCopyWith(
          CounterLog value, $Res Function(CounterLog) then) =
      _$CounterLogCopyWithImpl<$Res, CounterLog>;
  @useResult
  $Res call({String id, String action, DateTime timestamp});
}

/// @nodoc
class _$CounterLogCopyWithImpl<$Res, $Val extends CounterLog>
    implements $CounterLogCopyWith<$Res> {
  _$CounterLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CounterLogImplCopyWith<$Res>
    implements $CounterLogCopyWith<$Res> {
  factory _$$CounterLogImplCopyWith(
          _$CounterLogImpl value, $Res Function(_$CounterLogImpl) then) =
      __$$CounterLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String action, DateTime timestamp});
}

/// @nodoc
class __$$CounterLogImplCopyWithImpl<$Res>
    extends _$CounterLogCopyWithImpl<$Res, _$CounterLogImpl>
    implements _$$CounterLogImplCopyWith<$Res> {
  __$$CounterLogImplCopyWithImpl(
      _$CounterLogImpl _value, $Res Function(_$CounterLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? timestamp = null,
  }) {
    return _then(_$CounterLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CounterLogImpl implements _CounterLog {
  _$CounterLogImpl(
      {required this.id, required this.action, required this.timestamp});

  factory _$CounterLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$CounterLogImplFromJson(json);

  @override
  final String id;
  @override
  final String action;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'CounterLog(id: $id, action: $action, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CounterLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, action, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CounterLogImplCopyWith<_$CounterLogImpl> get copyWith =>
      __$$CounterLogImplCopyWithImpl<_$CounterLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CounterLogImplToJson(
      this,
    );
  }
}

abstract class _CounterLog implements CounterLog {
  factory _CounterLog(
      {required final String id,
      required final String action,
      required final DateTime timestamp}) = _$CounterLogImpl;

  factory _CounterLog.fromJson(Map<String, dynamic> json) =
      _$CounterLogImpl.fromJson;

  @override
  String get id;
  @override
  String get action;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$CounterLogImplCopyWith<_$CounterLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

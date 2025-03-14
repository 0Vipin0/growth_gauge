// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimerModel _$TimerModelFromJson(Map<String, dynamic> json) {
  return _TimerModel.fromJson(json);
}

/// @nodoc
mixin _$TimerModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Duration get interval => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<TimerLog> get logs => throw _privateConstructorUsedError;

  /// Serializes this TimerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimerModelCopyWith<TimerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerModelCopyWith<$Res> {
  factory $TimerModelCopyWith(
          TimerModel value, $Res Function(TimerModel) then) =
      _$TimerModelCopyWithImpl<$Res, TimerModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      Duration interval,
      String description,
      List<TimerLog> logs});
}

/// @nodoc
class _$TimerModelCopyWithImpl<$Res, $Val extends TimerModel>
    implements $TimerModelCopyWith<$Res> {
  _$TimerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? interval = null,
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
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<TimerLog>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerModelImplCopyWith<$Res>
    implements $TimerModelCopyWith<$Res> {
  factory _$$TimerModelImplCopyWith(
          _$TimerModelImpl value, $Res Function(_$TimerModelImpl) then) =
      __$$TimerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      Duration interval,
      String description,
      List<TimerLog> logs});
}

/// @nodoc
class __$$TimerModelImplCopyWithImpl<$Res>
    extends _$TimerModelCopyWithImpl<$Res, _$TimerModelImpl>
    implements _$$TimerModelImplCopyWith<$Res> {
  __$$TimerModelImplCopyWithImpl(
      _$TimerModelImpl _value, $Res Function(_$TimerModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? interval = null,
    Object? description = null,
    Object? logs = null,
  }) {
    return _then(_$TimerModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _value._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<TimerLog>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimerModelImpl implements _TimerModel {
  _$TimerModelImpl(
      {required this.id,
      required this.name,
      required this.interval,
      required this.description,
      final List<TimerLog> logs = const []})
      : _logs = logs;

  factory _$TimerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimerModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final Duration interval;
  @override
  final String description;
  final List<TimerLog> _logs;
  @override
  @JsonKey()
  List<TimerLog> get logs {
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logs);
  }

  @override
  String toString() {
    return 'TimerModel(id: $id, name: $name, interval: $interval, description: $description, logs: $logs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._logs, _logs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, interval, description,
      const DeepCollectionEquality().hash(_logs));

  /// Create a copy of TimerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerModelImplCopyWith<_$TimerModelImpl> get copyWith =>
      __$$TimerModelImplCopyWithImpl<_$TimerModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimerModelImplToJson(
      this,
    );
  }
}

abstract class _TimerModel implements TimerModel {
  factory _TimerModel(
      {required final String id,
      required final String name,
      required final Duration interval,
      required final String description,
      final List<TimerLog> logs}) = _$TimerModelImpl;

  factory _TimerModel.fromJson(Map<String, dynamic> json) =
      _$TimerModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  Duration get interval;
  @override
  String get description;
  @override
  List<TimerLog> get logs;

  /// Create a copy of TimerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimerModelImplCopyWith<_$TimerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimerLog _$TimerLogFromJson(Map<String, dynamic> json) {
  return _TimerLog.fromJson(json);
}

/// @nodoc
mixin _$TimerLog {
  String get id => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Duration get interval => throw _privateConstructorUsedError;

  /// Serializes this TimerLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimerLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimerLogCopyWith<TimerLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerLogCopyWith<$Res> {
  factory $TimerLogCopyWith(TimerLog value, $Res Function(TimerLog) then) =
      _$TimerLogCopyWithImpl<$Res, TimerLog>;
  @useResult
  $Res call({String id, String action, DateTime timestamp, Duration interval});
}

/// @nodoc
class _$TimerLogCopyWithImpl<$Res, $Val extends TimerLog>
    implements $TimerLogCopyWith<$Res> {
  _$TimerLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimerLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? timestamp = null,
    Object? interval = null,
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
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerLogImplCopyWith<$Res>
    implements $TimerLogCopyWith<$Res> {
  factory _$$TimerLogImplCopyWith(
          _$TimerLogImpl value, $Res Function(_$TimerLogImpl) then) =
      __$$TimerLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String action, DateTime timestamp, Duration interval});
}

/// @nodoc
class __$$TimerLogImplCopyWithImpl<$Res>
    extends _$TimerLogCopyWithImpl<$Res, _$TimerLogImpl>
    implements _$$TimerLogImplCopyWith<$Res> {
  __$$TimerLogImplCopyWithImpl(
      _$TimerLogImpl _value, $Res Function(_$TimerLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimerLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? timestamp = null,
    Object? interval = null,
  }) {
    return _then(_$TimerLogImpl(
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
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimerLogImpl implements _TimerLog {
  _$TimerLogImpl(
      {required this.id,
      required this.action,
      required this.timestamp,
      required this.interval});

  factory _$TimerLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimerLogImplFromJson(json);

  @override
  final String id;
  @override
  final String action;
  @override
  final DateTime timestamp;
  @override
  final Duration interval;

  @override
  String toString() {
    return 'TimerLog(id: $id, action: $action, timestamp: $timestamp, interval: $interval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.interval, interval) ||
                other.interval == interval));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, action, timestamp, interval);

  /// Create a copy of TimerLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerLogImplCopyWith<_$TimerLogImpl> get copyWith =>
      __$$TimerLogImplCopyWithImpl<_$TimerLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimerLogImplToJson(
      this,
    );
  }
}

abstract class _TimerLog implements TimerLog {
  factory _TimerLog(
      {required final String id,
      required final String action,
      required final DateTime timestamp,
      required final Duration interval}) = _$TimerLogImpl;

  factory _TimerLog.fromJson(Map<String, dynamic> json) =
      _$TimerLogImpl.fromJson;

  @override
  String get id;
  @override
  String get action;
  @override
  DateTime get timestamp;
  @override
  Duration get interval;

  /// Create a copy of TimerLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimerLogImplCopyWith<_$TimerLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

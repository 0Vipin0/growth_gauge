// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimerModel {
  String get id;
  String get name;
  Duration get interval;
  String get description;
  List<TimerLog> get logs;
  Duration? get target;
  List<String>? get tags;

  /// Create a copy of TimerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimerModelCopyWith<TimerModel> get copyWith =>
      _$TimerModelCopyWithImpl<TimerModel>(this as TimerModel, _$identity);

  /// Serializes this TimerModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.logs, logs) &&
            (identical(other.target, target) || other.target == target) &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      interval,
      description,
      const DeepCollectionEquality().hash(logs),
      target,
      const DeepCollectionEquality().hash(tags));

  @override
  String toString() {
    return 'TimerModel(id: $id, name: $name, interval: $interval, description: $description, logs: $logs, target: $target, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class $TimerModelCopyWith<$Res> {
  factory $TimerModelCopyWith(
          TimerModel value, $Res Function(TimerModel) _then) =
      _$TimerModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      Duration interval,
      String description,
      List<TimerLog> logs,
      Duration? target,
      List<String>? tags});
}

/// @nodoc
class _$TimerModelCopyWithImpl<$Res> implements $TimerModelCopyWith<$Res> {
  _$TimerModelCopyWithImpl(this._self, this._then);

  final TimerModel _self;
  final $Res Function(TimerModel) _then;

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
    Object? target = freezed,
    Object? tags = freezed,
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
      interval: null == interval
          ? _self.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _self.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<TimerLog>,
      target: freezed == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as Duration?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimerModel].
extension TimerModelPatterns on TimerModel {
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
    TResult Function(_TimerModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimerModel() when $default != null:
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
    TResult Function(_TimerModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimerModel():
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
    TResult? Function(_TimerModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimerModel() when $default != null:
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
            Duration interval,
            String description,
            List<TimerLog> logs,
            Duration? target,
            List<String>? tags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimerModel() when $default != null:
        return $default(_that.id, _that.name, _that.interval, _that.description,
            _that.logs, _that.target, _that.tags);
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
            Duration interval,
            String description,
            List<TimerLog> logs,
            Duration? target,
            List<String>? tags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimerModel():
        return $default(_that.id, _that.name, _that.interval, _that.description,
            _that.logs, _that.target, _that.tags);
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
            Duration interval,
            String description,
            List<TimerLog> logs,
            Duration? target,
            List<String>? tags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimerModel() when $default != null:
        return $default(_that.id, _that.name, _that.interval, _that.description,
            _that.logs, _that.target, _that.tags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TimerModel implements TimerModel {
  _TimerModel(
      {required this.id,
      required this.name,
      required this.interval,
      required this.description,
      final List<TimerLog> logs = const [],
      this.target,
      final List<String>? tags})
      : _logs = logs,
        _tags = tags;
  factory _TimerModel.fromJson(Map<String, dynamic> json) =>
      _$TimerModelFromJson(json);

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
  final Duration? target;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of TimerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimerModelCopyWith<_TimerModel> get copyWith =>
      __$TimerModelCopyWithImpl<_TimerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimerModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._logs, _logs) &&
            (identical(other.target, target) || other.target == target) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      interval,
      description,
      const DeepCollectionEquality().hash(_logs),
      target,
      const DeepCollectionEquality().hash(_tags));

  @override
  String toString() {
    return 'TimerModel(id: $id, name: $name, interval: $interval, description: $description, logs: $logs, target: $target, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class _$TimerModelCopyWith<$Res>
    implements $TimerModelCopyWith<$Res> {
  factory _$TimerModelCopyWith(
          _TimerModel value, $Res Function(_TimerModel) _then) =
      __$TimerModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      Duration interval,
      String description,
      List<TimerLog> logs,
      Duration? target,
      List<String>? tags});
}

/// @nodoc
class __$TimerModelCopyWithImpl<$Res> implements _$TimerModelCopyWith<$Res> {
  __$TimerModelCopyWithImpl(this._self, this._then);

  final _TimerModel _self;
  final $Res Function(_TimerModel) _then;

  /// Create a copy of TimerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? interval = null,
    Object? description = null,
    Object? logs = null,
    Object? target = freezed,
    Object? tags = freezed,
  }) {
    return _then(_TimerModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      interval: null == interval
          ? _self.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _self._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<TimerLog>,
      target: freezed == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as Duration?,
      tags: freezed == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
mixin _$TimerLog {
  String get id;
  String get action;
  DateTime get timestamp;
  Duration get interval;

  /// Create a copy of TimerLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TimerLogCopyWith<TimerLog> get copyWith =>
      _$TimerLogCopyWithImpl<TimerLog>(this as TimerLog, _$identity);

  /// Serializes this TimerLog to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TimerLog &&
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

  @override
  String toString() {
    return 'TimerLog(id: $id, action: $action, timestamp: $timestamp, interval: $interval)';
  }
}

/// @nodoc
abstract mixin class $TimerLogCopyWith<$Res> {
  factory $TimerLogCopyWith(TimerLog value, $Res Function(TimerLog) _then) =
      _$TimerLogCopyWithImpl;
  @useResult
  $Res call({String id, String action, DateTime timestamp, Duration interval});
}

/// @nodoc
class _$TimerLogCopyWithImpl<$Res> implements $TimerLogCopyWith<$Res> {
  _$TimerLogCopyWithImpl(this._self, this._then);

  final TimerLog _self;
  final $Res Function(TimerLog) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      interval: null == interval
          ? _self.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// Adds pattern-matching-related methods to [TimerLog].
extension TimerLogPatterns on TimerLog {
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
    TResult Function(_TimerLog value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimerLog() when $default != null:
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
    TResult Function(_TimerLog value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimerLog():
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
    TResult? Function(_TimerLog value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimerLog() when $default != null:
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
            String id, String action, DateTime timestamp, Duration interval)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TimerLog() when $default != null:
        return $default(
            _that.id, _that.action, _that.timestamp, _that.interval);
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
            String id, String action, DateTime timestamp, Duration interval)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimerLog():
        return $default(
            _that.id, _that.action, _that.timestamp, _that.interval);
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
            String id, String action, DateTime timestamp, Duration interval)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TimerLog() when $default != null:
        return $default(
            _that.id, _that.action, _that.timestamp, _that.interval);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TimerLog implements TimerLog {
  _TimerLog(
      {required this.id,
      required this.action,
      required this.timestamp,
      required this.interval});
  factory _TimerLog.fromJson(Map<String, dynamic> json) =>
      _$TimerLogFromJson(json);

  @override
  final String id;
  @override
  final String action;
  @override
  final DateTime timestamp;
  @override
  final Duration interval;

  /// Create a copy of TimerLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TimerLogCopyWith<_TimerLog> get copyWith =>
      __$TimerLogCopyWithImpl<_TimerLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TimerLogToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TimerLog &&
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

  @override
  String toString() {
    return 'TimerLog(id: $id, action: $action, timestamp: $timestamp, interval: $interval)';
  }
}

/// @nodoc
abstract mixin class _$TimerLogCopyWith<$Res>
    implements $TimerLogCopyWith<$Res> {
  factory _$TimerLogCopyWith(_TimerLog value, $Res Function(_TimerLog) _then) =
      __$TimerLogCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String action, DateTime timestamp, Duration interval});
}

/// @nodoc
class __$TimerLogCopyWithImpl<$Res> implements _$TimerLogCopyWith<$Res> {
  __$TimerLogCopyWithImpl(this._self, this._then);

  final _TimerLog _self;
  final $Res Function(_TimerLog) _then;

  /// Create a copy of TimerLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? timestamp = null,
    Object? interval = null,
  }) {
    return _then(_TimerLog(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _self.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      interval: null == interval
          ? _self.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

// dart format on

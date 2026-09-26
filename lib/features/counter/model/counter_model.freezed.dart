// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'counter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CounterModel {
  String get id;
  String get name;
  int get count;
  String get description;
  List<CounterLog> get logs;
  int? get target;
  List<String>? get tags;

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CounterModelCopyWith<CounterModel> get copyWith =>
      _$CounterModelCopyWithImpl<CounterModel>(
          this as CounterModel, _$identity);

  /// Serializes this CounterModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CounterModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.count, count) || other.count == count) &&
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
      count,
      description,
      const DeepCollectionEquality().hash(logs),
      target,
      const DeepCollectionEquality().hash(tags));

  @override
  String toString() {
    return 'CounterModel(id: $id, name: $name, count: $count, description: $description, logs: $logs, target: $target, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class $CounterModelCopyWith<$Res> {
  factory $CounterModelCopyWith(
          CounterModel value, $Res Function(CounterModel) _then) =
      _$CounterModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      int count,
      String description,
      List<CounterLog> logs,
      int? target,
      List<String>? tags});
}

/// @nodoc
class _$CounterModelCopyWithImpl<$Res> implements $CounterModelCopyWith<$Res> {
  _$CounterModelCopyWithImpl(this._self, this._then);

  final CounterModel _self;
  final $Res Function(CounterModel) _then;

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? count = null,
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
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _self.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<CounterLog>,
      target: freezed == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: freezed == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CounterModel].
extension CounterModelPatterns on CounterModel {
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
    TResult Function(_CounterModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CounterModel() when $default != null:
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
    TResult Function(_CounterModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CounterModel():
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
    TResult? Function(_CounterModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CounterModel() when $default != null:
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
    TResult Function(String id, String name, int count, String description,
            List<CounterLog> logs, int? target, List<String>? tags)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CounterModel() when $default != null:
        return $default(_that.id, _that.name, _that.count, _that.description,
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
    TResult Function(String id, String name, int count, String description,
            List<CounterLog> logs, int? target, List<String>? tags)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CounterModel():
        return $default(_that.id, _that.name, _that.count, _that.description,
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
    TResult? Function(String id, String name, int count, String description,
            List<CounterLog> logs, int? target, List<String>? tags)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CounterModel() when $default != null:
        return $default(_that.id, _that.name, _that.count, _that.description,
            _that.logs, _that.target, _that.tags);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CounterModel implements CounterModel {
  _CounterModel(
      {required this.id,
      required this.name,
      required this.count,
      required this.description,
      required final List<CounterLog> logs,
      this.target,
      final List<String>? tags})
      : _logs = logs,
        _tags = tags;
  factory _CounterModel.fromJson(Map<String, dynamic> json) =>
      _$CounterModelFromJson(json);

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
  final int? target;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CounterModelCopyWith<_CounterModel> get copyWith =>
      __$CounterModelCopyWithImpl<_CounterModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CounterModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CounterModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.count, count) || other.count == count) &&
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
      count,
      description,
      const DeepCollectionEquality().hash(_logs),
      target,
      const DeepCollectionEquality().hash(_tags));

  @override
  String toString() {
    return 'CounterModel(id: $id, name: $name, count: $count, description: $description, logs: $logs, target: $target, tags: $tags)';
  }
}

/// @nodoc
abstract mixin class _$CounterModelCopyWith<$Res>
    implements $CounterModelCopyWith<$Res> {
  factory _$CounterModelCopyWith(
          _CounterModel value, $Res Function(_CounterModel) _then) =
      __$CounterModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int count,
      String description,
      List<CounterLog> logs,
      int? target,
      List<String>? tags});
}

/// @nodoc
class __$CounterModelCopyWithImpl<$Res>
    implements _$CounterModelCopyWith<$Res> {
  __$CounterModelCopyWithImpl(this._self, this._then);

  final _CounterModel _self;
  final $Res Function(_CounterModel) _then;

  /// Create a copy of CounterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? count = null,
    Object? description = null,
    Object? logs = null,
    Object? target = freezed,
    Object? tags = freezed,
  }) {
    return _then(_CounterModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      logs: null == logs
          ? _self._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<CounterLog>,
      target: freezed == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as int?,
      tags: freezed == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
mixin _$CounterLog {
  String get id;
  String get action;
  DateTime get timestamp;

  /// Create a copy of CounterLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CounterLogCopyWith<CounterLog> get copyWith =>
      _$CounterLogCopyWithImpl<CounterLog>(this as CounterLog, _$identity);

  /// Serializes this CounterLog to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CounterLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, action, timestamp);

  @override
  String toString() {
    return 'CounterLog(id: $id, action: $action, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class $CounterLogCopyWith<$Res> {
  factory $CounterLogCopyWith(
          CounterLog value, $Res Function(CounterLog) _then) =
      _$CounterLogCopyWithImpl;
  @useResult
  $Res call({String id, String action, DateTime timestamp});
}

/// @nodoc
class _$CounterLogCopyWithImpl<$Res> implements $CounterLogCopyWith<$Res> {
  _$CounterLogCopyWithImpl(this._self, this._then);

  final CounterLog _self;
  final $Res Function(CounterLog) _then;

  /// Create a copy of CounterLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? timestamp = null,
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
    ));
  }
}

/// Adds pattern-matching-related methods to [CounterLog].
extension CounterLogPatterns on CounterLog {
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
    TResult Function(_CounterLog value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CounterLog() when $default != null:
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
    TResult Function(_CounterLog value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CounterLog():
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
    TResult? Function(_CounterLog value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CounterLog() when $default != null:
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
    TResult Function(String id, String action, DateTime timestamp)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CounterLog() when $default != null:
        return $default(_that.id, _that.action, _that.timestamp);
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
    TResult Function(String id, String action, DateTime timestamp) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CounterLog():
        return $default(_that.id, _that.action, _that.timestamp);
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
    TResult? Function(String id, String action, DateTime timestamp)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CounterLog() when $default != null:
        return $default(_that.id, _that.action, _that.timestamp);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CounterLog implements CounterLog {
  _CounterLog(
      {required this.id, required this.action, required this.timestamp});
  factory _CounterLog.fromJson(Map<String, dynamic> json) =>
      _$CounterLogFromJson(json);

  @override
  final String id;
  @override
  final String action;
  @override
  final DateTime timestamp;

  /// Create a copy of CounterLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CounterLogCopyWith<_CounterLog> get copyWith =>
      __$CounterLogCopyWithImpl<_CounterLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CounterLogToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CounterLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, action, timestamp);

  @override
  String toString() {
    return 'CounterLog(id: $id, action: $action, timestamp: $timestamp)';
  }
}

/// @nodoc
abstract mixin class _$CounterLogCopyWith<$Res>
    implements $CounterLogCopyWith<$Res> {
  factory _$CounterLogCopyWith(
          _CounterLog value, $Res Function(_CounterLog) _then) =
      __$CounterLogCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String action, DateTime timestamp});
}

/// @nodoc
class __$CounterLogCopyWithImpl<$Res> implements _$CounterLogCopyWith<$Res> {
  __$CounterLogCopyWithImpl(this._self, this._then);

  final _CounterLog _self;
  final $Res Function(_CounterLog) _then;

  /// Create a copy of CounterLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? timestamp = null,
  }) {
    return _then(_CounterLog(
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
    ));
  }
}

// dart format on

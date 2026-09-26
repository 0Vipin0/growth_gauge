// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rest_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RestPolicy {
  String get id;
  String get name;
  int get targetSeconds;
  int? get minimumSeconds;
  int? get maximumSeconds;
  bool get autoStart;
  bool get allowSkip;
  bool get allowExtend;

  /// Create a copy of RestPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RestPolicyCopyWith<RestPolicy> get copyWith =>
      _$RestPolicyCopyWithImpl<RestPolicy>(this as RestPolicy, _$identity);

  /// Serializes this RestPolicy to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RestPolicy &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.targetSeconds, targetSeconds) ||
                other.targetSeconds == targetSeconds) &&
            (identical(other.minimumSeconds, minimumSeconds) ||
                other.minimumSeconds == minimumSeconds) &&
            (identical(other.maximumSeconds, maximumSeconds) ||
                other.maximumSeconds == maximumSeconds) &&
            (identical(other.autoStart, autoStart) ||
                other.autoStart == autoStart) &&
            (identical(other.allowSkip, allowSkip) ||
                other.allowSkip == allowSkip) &&
            (identical(other.allowExtend, allowExtend) ||
                other.allowExtend == allowExtend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, targetSeconds,
      minimumSeconds, maximumSeconds, autoStart, allowSkip, allowExtend);

  @override
  String toString() {
    return 'RestPolicy(id: $id, name: $name, targetSeconds: $targetSeconds, minimumSeconds: $minimumSeconds, maximumSeconds: $maximumSeconds, autoStart: $autoStart, allowSkip: $allowSkip, allowExtend: $allowExtend)';
  }
}

/// @nodoc
abstract mixin class $RestPolicyCopyWith<$Res> {
  factory $RestPolicyCopyWith(
          RestPolicy value, $Res Function(RestPolicy) _then) =
      _$RestPolicyCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      int targetSeconds,
      int? minimumSeconds,
      int? maximumSeconds,
      bool autoStart,
      bool allowSkip,
      bool allowExtend});
}

/// @nodoc
class _$RestPolicyCopyWithImpl<$Res> implements $RestPolicyCopyWith<$Res> {
  _$RestPolicyCopyWithImpl(this._self, this._then);

  RestPolicy _self;
  final $Res Function(RestPolicy) _then;

  /// Create a copy of RestPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? targetSeconds = null,
    Object? minimumSeconds = freezed,
    Object? maximumSeconds = freezed,
    Object? autoStart = null,
    Object? allowSkip = null,
    Object? allowExtend = null,
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
      targetSeconds: null == targetSeconds
          ? _self.targetSeconds
          : targetSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      minimumSeconds: freezed == minimumSeconds
          ? _self.minimumSeconds
          : minimumSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      maximumSeconds: freezed == maximumSeconds
          ? _self.maximumSeconds
          : maximumSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      autoStart: null == autoStart
          ? _self.autoStart
          : autoStart // ignore: cast_nullable_to_non_nullable
              as bool,
      allowSkip: null == allowSkip
          ? _self.allowSkip
          : allowSkip // ignore: cast_nullable_to_non_nullable
              as bool,
      allowExtend: null == allowExtend
          ? _self.allowExtend
          : allowExtend // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [RestPolicy].
extension RestPolicyPatterns on RestPolicy {
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
    TResult Function(_RestPolicy value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RestPolicy() when $default != null:
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
    TResult Function(_RestPolicy value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestPolicy():
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
    TResult? Function(_RestPolicy value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestPolicy() when $default != null:
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
            int targetSeconds,
            int? minimumSeconds,
            int? maximumSeconds,
            bool autoStart,
            bool allowSkip,
            bool allowExtend)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RestPolicy() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.targetSeconds,
            _that.minimumSeconds,
            _that.maximumSeconds,
            _that.autoStart,
            _that.allowSkip,
            _that.allowExtend);
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
            int targetSeconds,
            int? minimumSeconds,
            int? maximumSeconds,
            bool autoStart,
            bool allowSkip,
            bool allowExtend)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestPolicy():
        return $default(
            _that.id,
            _that.name,
            _that.targetSeconds,
            _that.minimumSeconds,
            _that.maximumSeconds,
            _that.autoStart,
            _that.allowSkip,
            _that.allowExtend);
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
            int targetSeconds,
            int? minimumSeconds,
            int? maximumSeconds,
            bool autoStart,
            bool allowSkip,
            bool allowExtend)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RestPolicy() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.targetSeconds,
            _that.minimumSeconds,
            _that.maximumSeconds,
            _that.autoStart,
            _that.allowSkip,
            _that.allowExtend);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RestPolicy implements RestPolicy {
  const _RestPolicy(
      {required this.id,
      this.name = 'Standard Rest',
      required this.targetSeconds,
      this.minimumSeconds,
      this.maximumSeconds,
      this.autoStart = true,
      this.allowSkip = true,
      this.allowExtend = true});
  factory _RestPolicy.fromJson(Map<String, dynamic> json) =>
      _$RestPolicyFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final int targetSeconds;
  @override
  final int? minimumSeconds;
  @override
  final int? maximumSeconds;
  @override
  @JsonKey()
  final bool autoStart;
  @override
  @JsonKey()
  final bool allowSkip;
  @override
  @JsonKey()
  final bool allowExtend;

  /// Create a copy of RestPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RestPolicyCopyWith<_RestPolicy> get copyWith =>
      __$RestPolicyCopyWithImpl<_RestPolicy>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RestPolicyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RestPolicy &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.targetSeconds, targetSeconds) ||
                other.targetSeconds == targetSeconds) &&
            (identical(other.minimumSeconds, minimumSeconds) ||
                other.minimumSeconds == minimumSeconds) &&
            (identical(other.maximumSeconds, maximumSeconds) ||
                other.maximumSeconds == maximumSeconds) &&
            (identical(other.autoStart, autoStart) ||
                other.autoStart == autoStart) &&
            (identical(other.allowSkip, allowSkip) ||
                other.allowSkip == allowSkip) &&
            (identical(other.allowExtend, allowExtend) ||
                other.allowExtend == allowExtend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, targetSeconds,
      minimumSeconds, maximumSeconds, autoStart, allowSkip, allowExtend);

  @override
  String toString() {
    return 'RestPolicy(id: $id, name: $name, targetSeconds: $targetSeconds, minimumSeconds: $minimumSeconds, maximumSeconds: $maximumSeconds, autoStart: $autoStart, allowSkip: $allowSkip, allowExtend: $allowExtend)';
  }
}

/// @nodoc
abstract mixin class _$RestPolicyCopyWith<$Res>
    implements $RestPolicyCopyWith<$Res> {
  factory _$RestPolicyCopyWith(
          _RestPolicy value, $Res Function(_RestPolicy) _then) =
      __$RestPolicyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int targetSeconds,
      int? minimumSeconds,
      int? maximumSeconds,
      bool autoStart,
      bool allowSkip,
      bool allowExtend});
}

/// @nodoc
class __$RestPolicyCopyWithImpl<$Res> implements _$RestPolicyCopyWith<$Res> {
  __$RestPolicyCopyWithImpl(this._self, this._then);

  final _RestPolicy _self;
  final $Res Function(_RestPolicy) _then;

  /// Create a copy of RestPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? targetSeconds = null,
    Object? minimumSeconds = freezed,
    Object? maximumSeconds = freezed,
    Object? autoStart = null,
    Object? allowSkip = null,
    Object? allowExtend = null,
  }) {
    return _then(_RestPolicy(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      targetSeconds: null == targetSeconds
          ? _self.targetSeconds
          : targetSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      minimumSeconds: freezed == minimumSeconds
          ? _self.minimumSeconds
          : minimumSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      maximumSeconds: freezed == maximumSeconds
          ? _self.maximumSeconds
          : maximumSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      autoStart: null == autoStart
          ? _self.autoStart
          : autoStart // ignore: cast_nullable_to_non_nullable
              as bool,
      allowSkip: null == allowSkip
          ? _self.allowSkip
          : allowSkip // ignore: cast_nullable_to_non_nullable
              as bool,
      allowExtend: null == allowExtend
          ? _self.allowExtend
          : allowExtend // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on

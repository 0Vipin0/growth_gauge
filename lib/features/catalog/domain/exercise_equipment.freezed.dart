// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_equipment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseEquipmentProfile {
  List<EquipmentType> get requiredEquipment;
  List<EquipmentType> get optionalEquipment;

  /// Create a copy of ExerciseEquipmentProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseEquipmentProfileCopyWith<ExerciseEquipmentProfile> get copyWith =>
      _$ExerciseEquipmentProfileCopyWithImpl<ExerciseEquipmentProfile>(
          this as ExerciseEquipmentProfile, _$identity);

  /// Serializes this ExerciseEquipmentProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExerciseEquipmentProfile &&
            const DeepCollectionEquality()
                .equals(other.requiredEquipment, requiredEquipment) &&
            const DeepCollectionEquality()
                .equals(other.optionalEquipment, optionalEquipment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(requiredEquipment),
      const DeepCollectionEquality().hash(optionalEquipment));

  @override
  String toString() {
    return 'ExerciseEquipmentProfile(requiredEquipment: $requiredEquipment, optionalEquipment: $optionalEquipment)';
  }
}

/// @nodoc
abstract mixin class $ExerciseEquipmentProfileCopyWith<$Res> {
  factory $ExerciseEquipmentProfileCopyWith(ExerciseEquipmentProfile value,
          $Res Function(ExerciseEquipmentProfile) _then) =
      _$ExerciseEquipmentProfileCopyWithImpl;
  @useResult
  $Res call(
      {List<EquipmentType> requiredEquipment,
      List<EquipmentType> optionalEquipment});
}

/// @nodoc
class _$ExerciseEquipmentProfileCopyWithImpl<$Res>
    implements $ExerciseEquipmentProfileCopyWith<$Res> {
  _$ExerciseEquipmentProfileCopyWithImpl(this._self, this._then);

  final ExerciseEquipmentProfile _self;
  final $Res Function(ExerciseEquipmentProfile) _then;

  /// Create a copy of ExerciseEquipmentProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requiredEquipment = null,
    Object? optionalEquipment = null,
  }) {
    return _then(_self.copyWith(
      requiredEquipment: null == requiredEquipment
          ? _self.requiredEquipment
          : requiredEquipment // ignore: cast_nullable_to_non_nullable
              as List<EquipmentType>,
      optionalEquipment: null == optionalEquipment
          ? _self.optionalEquipment
          : optionalEquipment // ignore: cast_nullable_to_non_nullable
              as List<EquipmentType>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExerciseEquipmentProfile].
extension ExerciseEquipmentProfilePatterns on ExerciseEquipmentProfile {
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
    TResult Function(_ExerciseEquipmentProfile value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseEquipmentProfile() when $default != null:
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
    TResult Function(_ExerciseEquipmentProfile value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseEquipmentProfile():
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
    TResult? Function(_ExerciseEquipmentProfile value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseEquipmentProfile() when $default != null:
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
    TResult Function(List<EquipmentType> requiredEquipment,
            List<EquipmentType> optionalEquipment)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseEquipmentProfile() when $default != null:
        return $default(_that.requiredEquipment, _that.optionalEquipment);
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
    TResult Function(List<EquipmentType> requiredEquipment,
            List<EquipmentType> optionalEquipment)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseEquipmentProfile():
        return $default(_that.requiredEquipment, _that.optionalEquipment);
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
    TResult? Function(List<EquipmentType> requiredEquipment,
            List<EquipmentType> optionalEquipment)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseEquipmentProfile() when $default != null:
        return $default(_that.requiredEquipment, _that.optionalEquipment);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExerciseEquipmentProfile implements ExerciseEquipmentProfile {
  const _ExerciseEquipmentProfile(
      {final List<EquipmentType> requiredEquipment = const [],
      final List<EquipmentType> optionalEquipment = const []})
      : _requiredEquipment = requiredEquipment,
        _optionalEquipment = optionalEquipment;
  factory _ExerciseEquipmentProfile.fromJson(Map<String, dynamic> json) =>
      _$ExerciseEquipmentProfileFromJson(json);

  final List<EquipmentType> _requiredEquipment;
  @override
  @JsonKey()
  List<EquipmentType> get requiredEquipment {
    if (_requiredEquipment is EqualUnmodifiableListView)
      return _requiredEquipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredEquipment);
  }

  final List<EquipmentType> _optionalEquipment;
  @override
  @JsonKey()
  List<EquipmentType> get optionalEquipment {
    if (_optionalEquipment is EqualUnmodifiableListView)
      return _optionalEquipment;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_optionalEquipment);
  }

  /// Create a copy of ExerciseEquipmentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseEquipmentProfileCopyWith<_ExerciseEquipmentProfile> get copyWith =>
      __$ExerciseEquipmentProfileCopyWithImpl<_ExerciseEquipmentProfile>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExerciseEquipmentProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExerciseEquipmentProfile &&
            const DeepCollectionEquality()
                .equals(other._requiredEquipment, _requiredEquipment) &&
            const DeepCollectionEquality()
                .equals(other._optionalEquipment, _optionalEquipment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_requiredEquipment),
      const DeepCollectionEquality().hash(_optionalEquipment));

  @override
  String toString() {
    return 'ExerciseEquipmentProfile(requiredEquipment: $requiredEquipment, optionalEquipment: $optionalEquipment)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseEquipmentProfileCopyWith<$Res>
    implements $ExerciseEquipmentProfileCopyWith<$Res> {
  factory _$ExerciseEquipmentProfileCopyWith(_ExerciseEquipmentProfile value,
          $Res Function(_ExerciseEquipmentProfile) _then) =
      __$ExerciseEquipmentProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<EquipmentType> requiredEquipment,
      List<EquipmentType> optionalEquipment});
}

/// @nodoc
class __$ExerciseEquipmentProfileCopyWithImpl<$Res>
    implements _$ExerciseEquipmentProfileCopyWith<$Res> {
  __$ExerciseEquipmentProfileCopyWithImpl(this._self, this._then);

  final _ExerciseEquipmentProfile _self;
  final $Res Function(_ExerciseEquipmentProfile) _then;

  /// Create a copy of ExerciseEquipmentProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? requiredEquipment = null,
    Object? optionalEquipment = null,
  }) {
    return _then(_ExerciseEquipmentProfile(
      requiredEquipment: null == requiredEquipment
          ? _self._requiredEquipment
          : requiredEquipment // ignore: cast_nullable_to_non_nullable
              as List<EquipmentType>,
      optionalEquipment: null == optionalEquipment
          ? _self._optionalEquipment
          : optionalEquipment // ignore: cast_nullable_to_non_nullable
              as List<EquipmentType>,
    ));
  }
}

// dart format on

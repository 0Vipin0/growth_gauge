// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_set_metric.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseSetMetric {

 String get id; String get sessionId; String get exerciseId; String get userId; DateTime get timestamp; double? get weightKg; int? get reps; double? get volumeLoad; double? get estimated1Rm; double? get rpe; int? get rir; String get setType;
/// Create a copy of ExerciseSetMetric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseSetMetricCopyWith<ExerciseSetMetric> get copyWith => _$ExerciseSetMetricCopyWithImpl<ExerciseSetMetric>(this as ExerciseSetMetric, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExerciseSetMetric;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseSetMetric&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.exerciseId, _this.exerciseId) || other.exerciseId == _this.exerciseId)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.weightKg, _this.weightKg) || other.weightKg == _this.weightKg)&&(identical(other.reps, _this.reps) || other.reps == _this.reps)&&(identical(other.volumeLoad, _this.volumeLoad) || other.volumeLoad == _this.volumeLoad)&&(identical(other.estimated1Rm, _this.estimated1Rm) || other.estimated1Rm == _this.estimated1Rm)&&(identical(other.rpe, _this.rpe) || other.rpe == _this.rpe)&&(identical(other.rir, _this.rir) || other.rir == _this.rir)&&(identical(other.setType, _this.setType) || other.setType == _this.setType));
}


@override
int get hashCode {
  final _this = this as ExerciseSetMetric;
  return Object.hash(runtimeType,_this.id,_this.sessionId,_this.exerciseId,_this.userId,_this.timestamp,_this.weightKg,_this.reps,_this.volumeLoad,_this.estimated1Rm,_this.rpe,_this.rir,_this.setType);
}

@override
String toString() {
  final _this = this as ExerciseSetMetric;
  return 'ExerciseSetMetric(id: ${_this.id}, sessionId: ${_this.sessionId}, exerciseId: ${_this.exerciseId}, userId: ${_this.userId}, timestamp: ${_this.timestamp}, weightKg: ${_this.weightKg}, reps: ${_this.reps}, volumeLoad: ${_this.volumeLoad}, estimated1Rm: ${_this.estimated1Rm}, rpe: ${_this.rpe}, rir: ${_this.rir}, setType: ${_this.setType})';
}


}

/// @nodoc
abstract mixin class $ExerciseSetMetricCopyWith<$Res>  {
  factory $ExerciseSetMetricCopyWith(ExerciseSetMetric value, $Res Function(ExerciseSetMetric) _then) = _$ExerciseSetMetricCopyWithImpl;
@useResult
$Res call({
 String id, String sessionId, String exerciseId, String userId, DateTime timestamp, double? weightKg, int? reps, double? volumeLoad, double? estimated1Rm, double? rpe, int? rir, String setType
});




}
/// @nodoc
class _$ExerciseSetMetricCopyWithImpl<$Res>
    implements $ExerciseSetMetricCopyWith<$Res> {
  _$ExerciseSetMetricCopyWithImpl(this._self, this._then);

  final ExerciseSetMetric _self;
  final $Res Function(ExerciseSetMetric) _then;

/// Create a copy of ExerciseSetMetric
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionId = null,Object? exerciseId = null,Object? userId = null,Object? timestamp = null,Object? weightKg = freezed,Object? reps = freezed,Object? volumeLoad = freezed,Object? estimated1Rm = freezed,Object? rpe = freezed,Object? rir = freezed,Object? setType = null,}) {
  return _then(ExerciseSetMetric(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int?,volumeLoad: freezed == volumeLoad ? _self.volumeLoad : volumeLoad // ignore: cast_nullable_to_non_nullable
as double?,estimated1Rm: freezed == estimated1Rm ? _self.estimated1Rm : estimated1Rm // ignore: cast_nullable_to_non_nullable
as double?,rpe: freezed == rpe ? _self.rpe : rpe // ignore: cast_nullable_to_non_nullable
as double?,rir: freezed == rir ? _self.rir : rir // ignore: cast_nullable_to_non_nullable
as int?,setType: null == setType ? _self.setType : setType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseSetMetric].
extension ExerciseSetMetricPatterns on ExerciseSetMetric {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseSetMetric value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseSetMetric() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseSetMetric value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseSetMetric():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseSetMetric value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseSetMetric() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sessionId,  String exerciseId,  String userId,  DateTime timestamp,  double? weightKg,  int? reps,  double? volumeLoad,  double? estimated1Rm,  double? rpe,  int? rir,  String setType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseSetMetric() when $default != null:
return $default(_that.id,_that.sessionId,_that.exerciseId,_that.userId,_that.timestamp,_that.weightKg,_that.reps,_that.volumeLoad,_that.estimated1Rm,_that.rpe,_that.rir,_that.setType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sessionId,  String exerciseId,  String userId,  DateTime timestamp,  double? weightKg,  int? reps,  double? volumeLoad,  double? estimated1Rm,  double? rpe,  int? rir,  String setType)  $default,) {final _that = this;
switch (_that) {
case _ExerciseSetMetric():
return $default(_that.id,_that.sessionId,_that.exerciseId,_that.userId,_that.timestamp,_that.weightKg,_that.reps,_that.volumeLoad,_that.estimated1Rm,_that.rpe,_that.rir,_that.setType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sessionId,  String exerciseId,  String userId,  DateTime timestamp,  double? weightKg,  int? reps,  double? volumeLoad,  double? estimated1Rm,  double? rpe,  int? rir,  String setType)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseSetMetric() when $default != null:
return $default(_that.id,_that.sessionId,_that.exerciseId,_that.userId,_that.timestamp,_that.weightKg,_that.reps,_that.volumeLoad,_that.estimated1Rm,_that.rpe,_that.rir,_that.setType);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseSetMetric implements ExerciseSetMetric {
  const _ExerciseSetMetric({required this.id, required this.sessionId, required this.exerciseId, required this.userId, required this.timestamp, this.weightKg, this.reps, this.volumeLoad, this.estimated1Rm, this.rpe, this.rir, required this.setType});
  

@override final  String id;
@override final  String sessionId;
@override final  String exerciseId;
@override final  String userId;
@override final  DateTime timestamp;
@override final  double? weightKg;
@override final  int? reps;
@override final  double? volumeLoad;
@override final  double? estimated1Rm;
@override final  double? rpe;
@override final  int? rir;
@override final  String setType;

/// Create a copy of ExerciseSetMetric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseSetMetricCopyWith<_ExerciseSetMetric> get copyWith => __$ExerciseSetMetricCopyWithImpl<_ExerciseSetMetric>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseSetMetric&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.weightKg, weightKg) || other.weightKg == weightKg)&&(identical(other.reps, reps) || other.reps == reps)&&(identical(other.volumeLoad, volumeLoad) || other.volumeLoad == volumeLoad)&&(identical(other.estimated1Rm, estimated1Rm) || other.estimated1Rm == estimated1Rm)&&(identical(other.rpe, rpe) || other.rpe == rpe)&&(identical(other.rir, rir) || other.rir == rir)&&(identical(other.setType, setType) || other.setType == setType));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,sessionId,exerciseId,userId,timestamp,weightKg,reps,volumeLoad,estimated1Rm,rpe,rir,setType);
}

@override
String toString() {
    return 'ExerciseSetMetric(id: $id, sessionId: $sessionId, exerciseId: $exerciseId, userId: $userId, timestamp: $timestamp, weightKg: $weightKg, reps: $reps, volumeLoad: $volumeLoad, estimated1Rm: $estimated1Rm, rpe: $rpe, rir: $rir, setType: $setType)';
}


}

/// @nodoc
abstract mixin class _$ExerciseSetMetricCopyWith<$Res> implements $ExerciseSetMetricCopyWith<$Res> {
  factory _$ExerciseSetMetricCopyWith(_ExerciseSetMetric value, $Res Function(_ExerciseSetMetric) _then) = __$ExerciseSetMetricCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionId, String exerciseId, String userId, DateTime timestamp, double? weightKg, int? reps, double? volumeLoad, double? estimated1Rm, double? rpe, int? rir, String setType
});




}
/// @nodoc
class __$ExerciseSetMetricCopyWithImpl<$Res>
    implements _$ExerciseSetMetricCopyWith<$Res> {
  __$ExerciseSetMetricCopyWithImpl(this._self, this._then);

  final _ExerciseSetMetric _self;
  final $Res Function(_ExerciseSetMetric) _then;

/// Create a copy of ExerciseSetMetric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionId = null,Object? exerciseId = null,Object? userId = null,Object? timestamp = null,Object? weightKg = freezed,Object? reps = freezed,Object? volumeLoad = freezed,Object? estimated1Rm = freezed,Object? rpe = freezed,Object? rir = freezed,Object? setType = null,}) {
  return _then(_ExerciseSetMetric(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,weightKg: freezed == weightKg ? _self.weightKg : weightKg // ignore: cast_nullable_to_non_nullable
as double?,reps: freezed == reps ? _self.reps : reps // ignore: cast_nullable_to_non_nullable
as int?,volumeLoad: freezed == volumeLoad ? _self.volumeLoad : volumeLoad // ignore: cast_nullable_to_non_nullable
as double?,estimated1Rm: freezed == estimated1Rm ? _self.estimated1Rm : estimated1Rm // ignore: cast_nullable_to_non_nullable
as double?,rpe: freezed == rpe ? _self.rpe : rpe // ignore: cast_nullable_to_non_nullable
as double?,rir: freezed == rir ? _self.rir : rir // ignore: cast_nullable_to_non_nullable
as int?,setType: null == setType ? _self.setType : setType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

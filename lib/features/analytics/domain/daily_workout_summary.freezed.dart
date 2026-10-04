// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_workout_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyWorkoutSummary {

 String get id; DateTime get date; String get sessionId; String get userId; String get templateName; int get durationSeconds; int get activeSeconds; double get volumeLoadKg; int get totalCompletedSets; int get totalCompletedReps; double? get averageRpe;
/// Create a copy of DailyWorkoutSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyWorkoutSummaryCopyWith<DailyWorkoutSummary> get copyWith => _$DailyWorkoutSummaryCopyWithImpl<DailyWorkoutSummary>(this as DailyWorkoutSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyWorkoutSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.templateName, templateName) || other.templateName == templateName)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.activeSeconds, activeSeconds) || other.activeSeconds == activeSeconds)&&(identical(other.volumeLoadKg, volumeLoadKg) || other.volumeLoadKg == volumeLoadKg)&&(identical(other.totalCompletedSets, totalCompletedSets) || other.totalCompletedSets == totalCompletedSets)&&(identical(other.totalCompletedReps, totalCompletedReps) || other.totalCompletedReps == totalCompletedReps)&&(identical(other.averageRpe, averageRpe) || other.averageRpe == averageRpe));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,sessionId,userId,templateName,durationSeconds,activeSeconds,volumeLoadKg,totalCompletedSets,totalCompletedReps,averageRpe);

@override
String toString() {
  return 'DailyWorkoutSummary(id: $id, date: $date, sessionId: $sessionId, userId: $userId, templateName: $templateName, durationSeconds: $durationSeconds, activeSeconds: $activeSeconds, volumeLoadKg: $volumeLoadKg, totalCompletedSets: $totalCompletedSets, totalCompletedReps: $totalCompletedReps, averageRpe: $averageRpe)';
}


}

/// @nodoc
abstract mixin class $DailyWorkoutSummaryCopyWith<$Res>  {
  factory $DailyWorkoutSummaryCopyWith(DailyWorkoutSummary value, $Res Function(DailyWorkoutSummary) _then) = _$DailyWorkoutSummaryCopyWithImpl;
@useResult
$Res call({
 String id, DateTime date, String sessionId, String userId, String templateName, int durationSeconds, int activeSeconds, double volumeLoadKg, int totalCompletedSets, int totalCompletedReps, double? averageRpe
});




}
/// @nodoc
class _$DailyWorkoutSummaryCopyWithImpl<$Res>
    implements $DailyWorkoutSummaryCopyWith<$Res> {
  _$DailyWorkoutSummaryCopyWithImpl(this._self, this._then);

  final DailyWorkoutSummary _self;
  final $Res Function(DailyWorkoutSummary) _then;

/// Create a copy of DailyWorkoutSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? sessionId = null,Object? userId = null,Object? templateName = null,Object? durationSeconds = null,Object? activeSeconds = null,Object? volumeLoadKg = null,Object? totalCompletedSets = null,Object? totalCompletedReps = null,Object? averageRpe = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,templateName: null == templateName ? _self.templateName : templateName // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,activeSeconds: null == activeSeconds ? _self.activeSeconds : activeSeconds // ignore: cast_nullable_to_non_nullable
as int,volumeLoadKg: null == volumeLoadKg ? _self.volumeLoadKg : volumeLoadKg // ignore: cast_nullable_to_non_nullable
as double,totalCompletedSets: null == totalCompletedSets ? _self.totalCompletedSets : totalCompletedSets // ignore: cast_nullable_to_non_nullable
as int,totalCompletedReps: null == totalCompletedReps ? _self.totalCompletedReps : totalCompletedReps // ignore: cast_nullable_to_non_nullable
as int,averageRpe: freezed == averageRpe ? _self.averageRpe : averageRpe // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyWorkoutSummary].
extension DailyWorkoutSummaryPatterns on DailyWorkoutSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyWorkoutSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyWorkoutSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyWorkoutSummary value)  $default,){
final _that = this;
switch (_that) {
case _DailyWorkoutSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyWorkoutSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DailyWorkoutSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime date,  String sessionId,  String userId,  String templateName,  int durationSeconds,  int activeSeconds,  double volumeLoadKg,  int totalCompletedSets,  int totalCompletedReps,  double? averageRpe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyWorkoutSummary() when $default != null:
return $default(_that.id,_that.date,_that.sessionId,_that.userId,_that.templateName,_that.durationSeconds,_that.activeSeconds,_that.volumeLoadKg,_that.totalCompletedSets,_that.totalCompletedReps,_that.averageRpe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime date,  String sessionId,  String userId,  String templateName,  int durationSeconds,  int activeSeconds,  double volumeLoadKg,  int totalCompletedSets,  int totalCompletedReps,  double? averageRpe)  $default,) {final _that = this;
switch (_that) {
case _DailyWorkoutSummary():
return $default(_that.id,_that.date,_that.sessionId,_that.userId,_that.templateName,_that.durationSeconds,_that.activeSeconds,_that.volumeLoadKg,_that.totalCompletedSets,_that.totalCompletedReps,_that.averageRpe);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime date,  String sessionId,  String userId,  String templateName,  int durationSeconds,  int activeSeconds,  double volumeLoadKg,  int totalCompletedSets,  int totalCompletedReps,  double? averageRpe)?  $default,) {final _that = this;
switch (_that) {
case _DailyWorkoutSummary() when $default != null:
return $default(_that.id,_that.date,_that.sessionId,_that.userId,_that.templateName,_that.durationSeconds,_that.activeSeconds,_that.volumeLoadKg,_that.totalCompletedSets,_that.totalCompletedReps,_that.averageRpe);case _:
  return null;

}
}

}

/// @nodoc


class _DailyWorkoutSummary implements DailyWorkoutSummary {
  const _DailyWorkoutSummary({required this.id, required this.date, required this.sessionId, required this.userId, required this.templateName, required this.durationSeconds, required this.activeSeconds, required this.volumeLoadKg, required this.totalCompletedSets, required this.totalCompletedReps, this.averageRpe});
  

@override final  String id;
@override final  DateTime date;
@override final  String sessionId;
@override final  String userId;
@override final  String templateName;
@override final  int durationSeconds;
@override final  int activeSeconds;
@override final  double volumeLoadKg;
@override final  int totalCompletedSets;
@override final  int totalCompletedReps;
@override final  double? averageRpe;

/// Create a copy of DailyWorkoutSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyWorkoutSummaryCopyWith<_DailyWorkoutSummary> get copyWith => __$DailyWorkoutSummaryCopyWithImpl<_DailyWorkoutSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyWorkoutSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.templateName, templateName) || other.templateName == templateName)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.activeSeconds, activeSeconds) || other.activeSeconds == activeSeconds)&&(identical(other.volumeLoadKg, volumeLoadKg) || other.volumeLoadKg == volumeLoadKg)&&(identical(other.totalCompletedSets, totalCompletedSets) || other.totalCompletedSets == totalCompletedSets)&&(identical(other.totalCompletedReps, totalCompletedReps) || other.totalCompletedReps == totalCompletedReps)&&(identical(other.averageRpe, averageRpe) || other.averageRpe == averageRpe));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,sessionId,userId,templateName,durationSeconds,activeSeconds,volumeLoadKg,totalCompletedSets,totalCompletedReps,averageRpe);

@override
String toString() {
  return 'DailyWorkoutSummary(id: $id, date: $date, sessionId: $sessionId, userId: $userId, templateName: $templateName, durationSeconds: $durationSeconds, activeSeconds: $activeSeconds, volumeLoadKg: $volumeLoadKg, totalCompletedSets: $totalCompletedSets, totalCompletedReps: $totalCompletedReps, averageRpe: $averageRpe)';
}


}

/// @nodoc
abstract mixin class _$DailyWorkoutSummaryCopyWith<$Res> implements $DailyWorkoutSummaryCopyWith<$Res> {
  factory _$DailyWorkoutSummaryCopyWith(_DailyWorkoutSummary value, $Res Function(_DailyWorkoutSummary) _then) = __$DailyWorkoutSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime date, String sessionId, String userId, String templateName, int durationSeconds, int activeSeconds, double volumeLoadKg, int totalCompletedSets, int totalCompletedReps, double? averageRpe
});




}
/// @nodoc
class __$DailyWorkoutSummaryCopyWithImpl<$Res>
    implements _$DailyWorkoutSummaryCopyWith<$Res> {
  __$DailyWorkoutSummaryCopyWithImpl(this._self, this._then);

  final _DailyWorkoutSummary _self;
  final $Res Function(_DailyWorkoutSummary) _then;

/// Create a copy of DailyWorkoutSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? sessionId = null,Object? userId = null,Object? templateName = null,Object? durationSeconds = null,Object? activeSeconds = null,Object? volumeLoadKg = null,Object? totalCompletedSets = null,Object? totalCompletedReps = null,Object? averageRpe = freezed,}) {
  return _then(_DailyWorkoutSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,templateName: null == templateName ? _self.templateName : templateName // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,activeSeconds: null == activeSeconds ? _self.activeSeconds : activeSeconds // ignore: cast_nullable_to_non_nullable
as int,volumeLoadKg: null == volumeLoadKg ? _self.volumeLoadKg : volumeLoadKg // ignore: cast_nullable_to_non_nullable
as double,totalCompletedSets: null == totalCompletedSets ? _self.totalCompletedSets : totalCompletedSets // ignore: cast_nullable_to_non_nullable
as int,totalCompletedReps: null == totalCompletedReps ? _self.totalCompletedReps : totalCompletedReps // ignore: cast_nullable_to_non_nullable
as int,averageRpe: freezed == averageRpe ? _self.averageRpe : averageRpe // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on

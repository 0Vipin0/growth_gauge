// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'muscle_volume_stat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MuscleVolumeStat {

 String get muscleGroup; int get isoYear; int get isoWeek; DateTime get weekStartDate; double get totalVolumeKg; int get totalSets;
/// Create a copy of MuscleVolumeStat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MuscleVolumeStatCopyWith<MuscleVolumeStat> get copyWith => _$MuscleVolumeStatCopyWithImpl<MuscleVolumeStat>(this as MuscleVolumeStat, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MuscleVolumeStat&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&(identical(other.isoYear, isoYear) || other.isoYear == isoYear)&&(identical(other.isoWeek, isoWeek) || other.isoWeek == isoWeek)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.totalVolumeKg, totalVolumeKg) || other.totalVolumeKg == totalVolumeKg)&&(identical(other.totalSets, totalSets) || other.totalSets == totalSets));
}


@override
int get hashCode => Object.hash(runtimeType,muscleGroup,isoYear,isoWeek,weekStartDate,totalVolumeKg,totalSets);

@override
String toString() {
  return 'MuscleVolumeStat(muscleGroup: $muscleGroup, isoYear: $isoYear, isoWeek: $isoWeek, weekStartDate: $weekStartDate, totalVolumeKg: $totalVolumeKg, totalSets: $totalSets)';
}


}

/// @nodoc
abstract mixin class $MuscleVolumeStatCopyWith<$Res>  {
  factory $MuscleVolumeStatCopyWith(MuscleVolumeStat value, $Res Function(MuscleVolumeStat) _then) = _$MuscleVolumeStatCopyWithImpl;
@useResult
$Res call({
 String muscleGroup, int isoYear, int isoWeek, DateTime weekStartDate, double totalVolumeKg, int totalSets
});




}
/// @nodoc
class _$MuscleVolumeStatCopyWithImpl<$Res>
    implements $MuscleVolumeStatCopyWith<$Res> {
  _$MuscleVolumeStatCopyWithImpl(this._self, this._then);

  final MuscleVolumeStat _self;
  final $Res Function(MuscleVolumeStat) _then;

/// Create a copy of MuscleVolumeStat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? muscleGroup = null,Object? isoYear = null,Object? isoWeek = null,Object? weekStartDate = null,Object? totalVolumeKg = null,Object? totalSets = null,}) {
  return _then(_self.copyWith(
muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,isoYear: null == isoYear ? _self.isoYear : isoYear // ignore: cast_nullable_to_non_nullable
as int,isoWeek: null == isoWeek ? _self.isoWeek : isoWeek // ignore: cast_nullable_to_non_nullable
as int,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalVolumeKg: null == totalVolumeKg ? _self.totalVolumeKg : totalVolumeKg // ignore: cast_nullable_to_non_nullable
as double,totalSets: null == totalSets ? _self.totalSets : totalSets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MuscleVolumeStat].
extension MuscleVolumeStatPatterns on MuscleVolumeStat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MuscleVolumeStat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MuscleVolumeStat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MuscleVolumeStat value)  $default,){
final _that = this;
switch (_that) {
case _MuscleVolumeStat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MuscleVolumeStat value)?  $default,){
final _that = this;
switch (_that) {
case _MuscleVolumeStat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String muscleGroup,  int isoYear,  int isoWeek,  DateTime weekStartDate,  double totalVolumeKg,  int totalSets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MuscleVolumeStat() when $default != null:
return $default(_that.muscleGroup,_that.isoYear,_that.isoWeek,_that.weekStartDate,_that.totalVolumeKg,_that.totalSets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String muscleGroup,  int isoYear,  int isoWeek,  DateTime weekStartDate,  double totalVolumeKg,  int totalSets)  $default,) {final _that = this;
switch (_that) {
case _MuscleVolumeStat():
return $default(_that.muscleGroup,_that.isoYear,_that.isoWeek,_that.weekStartDate,_that.totalVolumeKg,_that.totalSets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String muscleGroup,  int isoYear,  int isoWeek,  DateTime weekStartDate,  double totalVolumeKg,  int totalSets)?  $default,) {final _that = this;
switch (_that) {
case _MuscleVolumeStat() when $default != null:
return $default(_that.muscleGroup,_that.isoYear,_that.isoWeek,_that.weekStartDate,_that.totalVolumeKg,_that.totalSets);case _:
  return null;

}
}

}

/// @nodoc


class _MuscleVolumeStat implements MuscleVolumeStat {
  const _MuscleVolumeStat({required this.muscleGroup, required this.isoYear, required this.isoWeek, required this.weekStartDate, required this.totalVolumeKg, required this.totalSets});
  

@override final  String muscleGroup;
@override final  int isoYear;
@override final  int isoWeek;
@override final  DateTime weekStartDate;
@override final  double totalVolumeKg;
@override final  int totalSets;

/// Create a copy of MuscleVolumeStat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MuscleVolumeStatCopyWith<_MuscleVolumeStat> get copyWith => __$MuscleVolumeStatCopyWithImpl<_MuscleVolumeStat>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MuscleVolumeStat&&(identical(other.muscleGroup, muscleGroup) || other.muscleGroup == muscleGroup)&&(identical(other.isoYear, isoYear) || other.isoYear == isoYear)&&(identical(other.isoWeek, isoWeek) || other.isoWeek == isoWeek)&&(identical(other.weekStartDate, weekStartDate) || other.weekStartDate == weekStartDate)&&(identical(other.totalVolumeKg, totalVolumeKg) || other.totalVolumeKg == totalVolumeKg)&&(identical(other.totalSets, totalSets) || other.totalSets == totalSets));
}


@override
int get hashCode => Object.hash(runtimeType,muscleGroup,isoYear,isoWeek,weekStartDate,totalVolumeKg,totalSets);

@override
String toString() {
  return 'MuscleVolumeStat(muscleGroup: $muscleGroup, isoYear: $isoYear, isoWeek: $isoWeek, weekStartDate: $weekStartDate, totalVolumeKg: $totalVolumeKg, totalSets: $totalSets)';
}


}

/// @nodoc
abstract mixin class _$MuscleVolumeStatCopyWith<$Res> implements $MuscleVolumeStatCopyWith<$Res> {
  factory _$MuscleVolumeStatCopyWith(_MuscleVolumeStat value, $Res Function(_MuscleVolumeStat) _then) = __$MuscleVolumeStatCopyWithImpl;
@override @useResult
$Res call({
 String muscleGroup, int isoYear, int isoWeek, DateTime weekStartDate, double totalVolumeKg, int totalSets
});




}
/// @nodoc
class __$MuscleVolumeStatCopyWithImpl<$Res>
    implements _$MuscleVolumeStatCopyWith<$Res> {
  __$MuscleVolumeStatCopyWithImpl(this._self, this._then);

  final _MuscleVolumeStat _self;
  final $Res Function(_MuscleVolumeStat) _then;

/// Create a copy of MuscleVolumeStat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? muscleGroup = null,Object? isoYear = null,Object? isoWeek = null,Object? weekStartDate = null,Object? totalVolumeKg = null,Object? totalSets = null,}) {
  return _then(_MuscleVolumeStat(
muscleGroup: null == muscleGroup ? _self.muscleGroup : muscleGroup // ignore: cast_nullable_to_non_nullable
as String,isoYear: null == isoYear ? _self.isoYear : isoYear // ignore: cast_nullable_to_non_nullable
as int,isoWeek: null == isoWeek ? _self.isoWeek : isoWeek // ignore: cast_nullable_to_non_nullable
as int,weekStartDate: null == weekStartDate ? _self.weekStartDate : weekStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,totalVolumeKg: null == totalVolumeKg ? _self.totalVolumeKg : totalVolumeKg // ignore: cast_nullable_to_non_nullable
as double,totalSets: null == totalSets ? _self.totalSets : totalSets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

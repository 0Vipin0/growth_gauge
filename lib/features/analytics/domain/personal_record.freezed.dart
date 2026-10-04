// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PersonalRecord {

 String get id; String get exerciseId; String get userId; PrType get prType; double get value; String get sessionId; String? get setId; DateTime get achievedAt; String? get replacesRecordId;
/// Create a copy of PersonalRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalRecordCopyWith<PersonalRecord> get copyWith => _$PersonalRecordCopyWithImpl<PersonalRecord>(this as PersonalRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.prType, prType) || other.prType == prType)&&(identical(other.value, value) || other.value == value)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.setId, setId) || other.setId == setId)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt)&&(identical(other.replacesRecordId, replacesRecordId) || other.replacesRecordId == replacesRecordId));
}


@override
int get hashCode => Object.hash(runtimeType,id,exerciseId,userId,prType,value,sessionId,setId,achievedAt,replacesRecordId);

@override
String toString() {
  return 'PersonalRecord(id: $id, exerciseId: $exerciseId, userId: $userId, prType: $prType, value: $value, sessionId: $sessionId, setId: $setId, achievedAt: $achievedAt, replacesRecordId: $replacesRecordId)';
}


}

/// @nodoc
abstract mixin class $PersonalRecordCopyWith<$Res>  {
  factory $PersonalRecordCopyWith(PersonalRecord value, $Res Function(PersonalRecord) _then) = _$PersonalRecordCopyWithImpl;
@useResult
$Res call({
 String id, String exerciseId, String userId, PrType prType, double value, String sessionId, String? setId, DateTime achievedAt, String? replacesRecordId
});




}
/// @nodoc
class _$PersonalRecordCopyWithImpl<$Res>
    implements $PersonalRecordCopyWith<$Res> {
  _$PersonalRecordCopyWithImpl(this._self, this._then);

  final PersonalRecord _self;
  final $Res Function(PersonalRecord) _then;

/// Create a copy of PersonalRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? exerciseId = null,Object? userId = null,Object? prType = null,Object? value = null,Object? sessionId = null,Object? setId = freezed,Object? achievedAt = null,Object? replacesRecordId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,prType: null == prType ? _self.prType : prType // ignore: cast_nullable_to_non_nullable
as PrType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,setId: freezed == setId ? _self.setId : setId // ignore: cast_nullable_to_non_nullable
as String?,achievedAt: null == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime,replacesRecordId: freezed == replacesRecordId ? _self.replacesRecordId : replacesRecordId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalRecord].
extension PersonalRecordPatterns on PersonalRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalRecord value)  $default,){
final _that = this;
switch (_that) {
case _PersonalRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String exerciseId,  String userId,  PrType prType,  double value,  String sessionId,  String? setId,  DateTime achievedAt,  String? replacesRecordId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalRecord() when $default != null:
return $default(_that.id,_that.exerciseId,_that.userId,_that.prType,_that.value,_that.sessionId,_that.setId,_that.achievedAt,_that.replacesRecordId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String exerciseId,  String userId,  PrType prType,  double value,  String sessionId,  String? setId,  DateTime achievedAt,  String? replacesRecordId)  $default,) {final _that = this;
switch (_that) {
case _PersonalRecord():
return $default(_that.id,_that.exerciseId,_that.userId,_that.prType,_that.value,_that.sessionId,_that.setId,_that.achievedAt,_that.replacesRecordId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String exerciseId,  String userId,  PrType prType,  double value,  String sessionId,  String? setId,  DateTime achievedAt,  String? replacesRecordId)?  $default,) {final _that = this;
switch (_that) {
case _PersonalRecord() when $default != null:
return $default(_that.id,_that.exerciseId,_that.userId,_that.prType,_that.value,_that.sessionId,_that.setId,_that.achievedAt,_that.replacesRecordId);case _:
  return null;

}
}

}

/// @nodoc


class _PersonalRecord implements PersonalRecord {
  const _PersonalRecord({required this.id, required this.exerciseId, required this.userId, required this.prType, required this.value, required this.sessionId, this.setId, required this.achievedAt, this.replacesRecordId});
  

@override final  String id;
@override final  String exerciseId;
@override final  String userId;
@override final  PrType prType;
@override final  double value;
@override final  String sessionId;
@override final  String? setId;
@override final  DateTime achievedAt;
@override final  String? replacesRecordId;

/// Create a copy of PersonalRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalRecordCopyWith<_PersonalRecord> get copyWith => __$PersonalRecordCopyWithImpl<_PersonalRecord>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.exerciseId, exerciseId) || other.exerciseId == exerciseId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.prType, prType) || other.prType == prType)&&(identical(other.value, value) || other.value == value)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.setId, setId) || other.setId == setId)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt)&&(identical(other.replacesRecordId, replacesRecordId) || other.replacesRecordId == replacesRecordId));
}


@override
int get hashCode => Object.hash(runtimeType,id,exerciseId,userId,prType,value,sessionId,setId,achievedAt,replacesRecordId);

@override
String toString() {
  return 'PersonalRecord(id: $id, exerciseId: $exerciseId, userId: $userId, prType: $prType, value: $value, sessionId: $sessionId, setId: $setId, achievedAt: $achievedAt, replacesRecordId: $replacesRecordId)';
}


}

/// @nodoc
abstract mixin class _$PersonalRecordCopyWith<$Res> implements $PersonalRecordCopyWith<$Res> {
  factory _$PersonalRecordCopyWith(_PersonalRecord value, $Res Function(_PersonalRecord) _then) = __$PersonalRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String exerciseId, String userId, PrType prType, double value, String sessionId, String? setId, DateTime achievedAt, String? replacesRecordId
});




}
/// @nodoc
class __$PersonalRecordCopyWithImpl<$Res>
    implements _$PersonalRecordCopyWith<$Res> {
  __$PersonalRecordCopyWithImpl(this._self, this._then);

  final _PersonalRecord _self;
  final $Res Function(_PersonalRecord) _then;

/// Create a copy of PersonalRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? exerciseId = null,Object? userId = null,Object? prType = null,Object? value = null,Object? sessionId = null,Object? setId = freezed,Object? achievedAt = null,Object? replacesRecordId = freezed,}) {
  return _then(_PersonalRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,exerciseId: null == exerciseId ? _self.exerciseId : exerciseId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,prType: null == prType ? _self.prType : prType // ignore: cast_nullable_to_non_nullable
as PrType,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,setId: freezed == setId ? _self.setId : setId // ignore: cast_nullable_to_non_nullable
as String?,achievedAt: null == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime,replacesRecordId: freezed == replacesRecordId ? _self.replacesRecordId : replacesRecordId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

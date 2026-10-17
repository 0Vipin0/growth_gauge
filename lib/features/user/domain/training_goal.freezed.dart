// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingGoal {

 String get id; String get userId; GoalType get type; String get name; String get description; double get startValue; double get targetValue; double get currentValue; String get unit; DateTime get startDate; DateTime? get targetDate; GoalStatus get status; DateTime get createdAt; DateTime? get completedAt;
/// Create a copy of TrainingGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingGoalCopyWith<TrainingGoal> get copyWith => _$TrainingGoalCopyWithImpl<TrainingGoal>(this as TrainingGoal, _$identity);

  /// Serializes this TrainingGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TrainingGoal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingGoal&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.startValue, _this.startValue) || other.startValue == _this.startValue)&&(identical(other.targetValue, _this.targetValue) || other.targetValue == _this.targetValue)&&(identical(other.currentValue, _this.currentValue) || other.currentValue == _this.currentValue)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.targetDate, _this.targetDate) || other.targetDate == _this.targetDate)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TrainingGoal;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.type,_this.name,_this.description,_this.startValue,_this.targetValue,_this.currentValue,_this.unit,_this.startDate,_this.targetDate,_this.status,_this.createdAt,_this.completedAt);
}

@override
String toString() {
  final _this = this as TrainingGoal;
  return 'TrainingGoal(id: ${_this.id}, userId: ${_this.userId}, type: ${_this.type}, name: ${_this.name}, description: ${_this.description}, startValue: ${_this.startValue}, targetValue: ${_this.targetValue}, currentValue: ${_this.currentValue}, unit: ${_this.unit}, startDate: ${_this.startDate}, targetDate: ${_this.targetDate}, status: ${_this.status}, createdAt: ${_this.createdAt}, completedAt: ${_this.completedAt})';
}


}

/// @nodoc
abstract mixin class $TrainingGoalCopyWith<$Res>  {
  factory $TrainingGoalCopyWith(TrainingGoal value, $Res Function(TrainingGoal) _then) = _$TrainingGoalCopyWithImpl;
@useResult
$Res call({
 String id, String userId, GoalType type, String name, String description, double startValue, double targetValue, double currentValue, String unit, DateTime startDate, DateTime? targetDate, GoalStatus status, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class _$TrainingGoalCopyWithImpl<$Res>
    implements $TrainingGoalCopyWith<$Res> {
  _$TrainingGoalCopyWithImpl(this._self, this._then);

  final TrainingGoal _self;
  final $Res Function(TrainingGoal) _then;

/// Create a copy of TrainingGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? name = null,Object? description = null,Object? startValue = null,Object? targetValue = null,Object? currentValue = null,Object? unit = null,Object? startDate = null,Object? targetDate = freezed,Object? status = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(TrainingGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startValue: null == startValue ? _self.startValue : startValue // ignore: cast_nullable_to_non_nullable
as double,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as double,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoalStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingGoal].
extension TrainingGoalPatterns on TrainingGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingGoal value)  $default,){
final _that = this;
switch (_that) {
case _TrainingGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingGoal value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  GoalType type,  String name,  String description,  double startValue,  double targetValue,  double currentValue,  String unit,  DateTime startDate,  DateTime? targetDate,  GoalStatus status,  DateTime createdAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingGoal() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.name,_that.description,_that.startValue,_that.targetValue,_that.currentValue,_that.unit,_that.startDate,_that.targetDate,_that.status,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  GoalType type,  String name,  String description,  double startValue,  double targetValue,  double currentValue,  String unit,  DateTime startDate,  DateTime? targetDate,  GoalStatus status,  DateTime createdAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _TrainingGoal():
return $default(_that.id,_that.userId,_that.type,_that.name,_that.description,_that.startValue,_that.targetValue,_that.currentValue,_that.unit,_that.startDate,_that.targetDate,_that.status,_that.createdAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  GoalType type,  String name,  String description,  double startValue,  double targetValue,  double currentValue,  String unit,  DateTime startDate,  DateTime? targetDate,  GoalStatus status,  DateTime createdAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _TrainingGoal() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.name,_that.description,_that.startValue,_that.targetValue,_that.currentValue,_that.unit,_that.startDate,_that.targetDate,_that.status,_that.createdAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingGoal implements TrainingGoal {
  const _TrainingGoal({required this.id, required this.userId, required this.type, required this.name, this.description = '', required this.startValue, required this.targetValue, required this.currentValue, this.unit = 'kg', required this.startDate, this.targetDate, this.status = GoalStatus.active, required this.createdAt, this.completedAt});
  factory _TrainingGoal.fromJson(Map<String, dynamic> json) => _$TrainingGoalFromJson(json);

@override final  String id;
@override final  String userId;
@override final  GoalType type;
@override final  String name;
@override@JsonKey() final  String description;
@override final  double startValue;
@override final  double targetValue;
@override final  double currentValue;
@override@JsonKey() final  String unit;
@override final  DateTime startDate;
@override final  DateTime? targetDate;
@override@JsonKey() final  GoalStatus status;
@override final  DateTime createdAt;
@override final  DateTime? completedAt;

/// Create a copy of TrainingGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingGoalCopyWith<_TrainingGoal> get copyWith => __$TrainingGoalCopyWithImpl<_TrainingGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingGoalToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.startValue, startValue) || other.startValue == startValue)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.targetDate, targetDate) || other.targetDate == targetDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,type,name,description,startValue,targetValue,currentValue,unit,startDate,targetDate,status,createdAt,completedAt);
}

@override
String toString() {
    return 'TrainingGoal(id: $id, userId: $userId, type: $type, name: $name, description: $description, startValue: $startValue, targetValue: $targetValue, currentValue: $currentValue, unit: $unit, startDate: $startDate, targetDate: $targetDate, status: $status, createdAt: $createdAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$TrainingGoalCopyWith<$Res> implements $TrainingGoalCopyWith<$Res> {
  factory _$TrainingGoalCopyWith(_TrainingGoal value, $Res Function(_TrainingGoal) _then) = __$TrainingGoalCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, GoalType type, String name, String description, double startValue, double targetValue, double currentValue, String unit, DateTime startDate, DateTime? targetDate, GoalStatus status, DateTime createdAt, DateTime? completedAt
});




}
/// @nodoc
class __$TrainingGoalCopyWithImpl<$Res>
    implements _$TrainingGoalCopyWith<$Res> {
  __$TrainingGoalCopyWithImpl(this._self, this._then);

  final _TrainingGoal _self;
  final $Res Function(_TrainingGoal) _then;

/// Create a copy of TrainingGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? name = null,Object? description = null,Object? startValue = null,Object? targetValue = null,Object? currentValue = null,Object? unit = null,Object? startDate = null,Object? targetDate = freezed,Object? status = null,Object? createdAt = null,Object? completedAt = freezed,}) {
  return _then(_TrainingGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,startValue: null == startValue ? _self.startValue : startValue // ignore: cast_nullable_to_non_nullable
as double,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as double,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,targetDate: freezed == targetDate ? _self.targetDate : targetDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GoalStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

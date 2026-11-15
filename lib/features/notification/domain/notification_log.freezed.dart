// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationLog {

 int get id; int get notificationId; String get title; String get body; NotificationCategory get type; NotificationStatus get status; DateTime? get scheduledTime; DateTime? get triggeredAt; DateTime get createdAt; String? get payload;
/// Create a copy of NotificationLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationLogCopyWith<NotificationLog> get copyWith => _$NotificationLogCopyWithImpl<NotificationLog>(this as NotificationLog, _$identity);

  /// Serializes this NotificationLog to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotificationLog;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationLog&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.notificationId, _this.notificationId) || other.notificationId == _this.notificationId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.scheduledTime, _this.scheduledTime) || other.scheduledTime == _this.scheduledTime)&&(identical(other.triggeredAt, _this.triggeredAt) || other.triggeredAt == _this.triggeredAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.payload, _this.payload) || other.payload == _this.payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotificationLog;
  return Object.hash(runtimeType,_this.id,_this.notificationId,_this.title,_this.body,_this.type,_this.status,_this.scheduledTime,_this.triggeredAt,_this.createdAt,_this.payload);
}

@override
String toString() {
  final _this = this as NotificationLog;
  return 'NotificationLog(id: ${_this.id}, notificationId: ${_this.notificationId}, title: ${_this.title}, body: ${_this.body}, type: ${_this.type}, status: ${_this.status}, scheduledTime: ${_this.scheduledTime}, triggeredAt: ${_this.triggeredAt}, createdAt: ${_this.createdAt}, payload: ${_this.payload})';
}


}

/// @nodoc
abstract mixin class $NotificationLogCopyWith<$Res>  {
  factory $NotificationLogCopyWith(NotificationLog value, $Res Function(NotificationLog) _then) = _$NotificationLogCopyWithImpl;
@useResult
$Res call({
 int id, int notificationId, String title, String body, NotificationCategory type, NotificationStatus status, DateTime? scheduledTime, DateTime? triggeredAt, DateTime createdAt, String? payload
});




}
/// @nodoc
class _$NotificationLogCopyWithImpl<$Res>
    implements $NotificationLogCopyWith<$Res> {
  _$NotificationLogCopyWithImpl(this._self, this._then);

  final NotificationLog _self;
  final $Res Function(NotificationLog) _then;

/// Create a copy of NotificationLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? notificationId = null,Object? title = null,Object? body = null,Object? type = null,Object? status = null,Object? scheduledTime = freezed,Object? triggeredAt = freezed,Object? createdAt = null,Object? payload = freezed,}) {
  return _then(NotificationLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationCategory,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotificationStatus,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,triggeredAt: freezed == triggeredAt ? _self.triggeredAt : triggeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationLog].
extension NotificationLogPatterns on NotificationLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationLog value)  $default,){
final _that = this;
switch (_that) {
case _NotificationLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationLog value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int notificationId,  String title,  String body,  NotificationCategory type,  NotificationStatus status,  DateTime? scheduledTime,  DateTime? triggeredAt,  DateTime createdAt,  String? payload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationLog() when $default != null:
return $default(_that.id,_that.notificationId,_that.title,_that.body,_that.type,_that.status,_that.scheduledTime,_that.triggeredAt,_that.createdAt,_that.payload);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int notificationId,  String title,  String body,  NotificationCategory type,  NotificationStatus status,  DateTime? scheduledTime,  DateTime? triggeredAt,  DateTime createdAt,  String? payload)  $default,) {final _that = this;
switch (_that) {
case _NotificationLog():
return $default(_that.id,_that.notificationId,_that.title,_that.body,_that.type,_that.status,_that.scheduledTime,_that.triggeredAt,_that.createdAt,_that.payload);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int notificationId,  String title,  String body,  NotificationCategory type,  NotificationStatus status,  DateTime? scheduledTime,  DateTime? triggeredAt,  DateTime createdAt,  String? payload)?  $default,) {final _that = this;
switch (_that) {
case _NotificationLog() when $default != null:
return $default(_that.id,_that.notificationId,_that.title,_that.body,_that.type,_that.status,_that.scheduledTime,_that.triggeredAt,_that.createdAt,_that.payload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationLog implements NotificationLog {
  const _NotificationLog({required this.id, required this.notificationId, required this.title, required this.body, this.type = NotificationCategory.general, this.status = NotificationStatus.scheduled, this.scheduledTime, this.triggeredAt, required this.createdAt, this.payload});
  factory _NotificationLog.fromJson(Map<String, dynamic> json) => _$NotificationLogFromJson(json);

@override final  int id;
@override final  int notificationId;
@override final  String title;
@override final  String body;
@override@JsonKey() final  NotificationCategory type;
@override@JsonKey() final  NotificationStatus status;
@override final  DateTime? scheduledTime;
@override final  DateTime? triggeredAt;
@override final  DateTime createdAt;
@override final  String? payload;

/// Create a copy of NotificationLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationLogCopyWith<_NotificationLog> get copyWith => __$NotificationLogCopyWithImpl<_NotificationLog>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationLogToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationLog&&(identical(other.id, id) || other.id == id)&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.triggeredAt, triggeredAt) || other.triggeredAt == triggeredAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.payload, payload) || other.payload == payload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,notificationId,title,body,type,status,scheduledTime,triggeredAt,createdAt,payload);
}

@override
String toString() {
    return 'NotificationLog(id: $id, notificationId: $notificationId, title: $title, body: $body, type: $type, status: $status, scheduledTime: $scheduledTime, triggeredAt: $triggeredAt, createdAt: $createdAt, payload: $payload)';
}


}

/// @nodoc
abstract mixin class _$NotificationLogCopyWith<$Res> implements $NotificationLogCopyWith<$Res> {
  factory _$NotificationLogCopyWith(_NotificationLog value, $Res Function(_NotificationLog) _then) = __$NotificationLogCopyWithImpl;
@override @useResult
$Res call({
 int id, int notificationId, String title, String body, NotificationCategory type, NotificationStatus status, DateTime? scheduledTime, DateTime? triggeredAt, DateTime createdAt, String? payload
});




}
/// @nodoc
class __$NotificationLogCopyWithImpl<$Res>
    implements _$NotificationLogCopyWith<$Res> {
  __$NotificationLogCopyWithImpl(this._self, this._then);

  final _NotificationLog _self;
  final $Res Function(_NotificationLog) _then;

/// Create a copy of NotificationLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? notificationId = null,Object? title = null,Object? body = null,Object? type = null,Object? status = null,Object? scheduledTime = freezed,Object? triggeredAt = freezed,Object? createdAt = null,Object? payload = freezed,}) {
  return _then(_NotificationLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationCategory,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotificationStatus,scheduledTime: freezed == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as DateTime?,triggeredAt: freezed == triggeredAt ? _self.triggeredAt : triggeredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

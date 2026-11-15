// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'equipment_inventory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EquipmentInventory {

 String get userId; List<EquipmentType> get ownedEquipment; DateTime get updatedAt;
/// Create a copy of EquipmentInventory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EquipmentInventoryCopyWith<EquipmentInventory> get copyWith => _$EquipmentInventoryCopyWithImpl<EquipmentInventory>(this as EquipmentInventory, _$identity);

  /// Serializes this EquipmentInventory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EquipmentInventory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EquipmentInventory&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&const DeepCollectionEquality().equals(other.ownedEquipment, _this.ownedEquipment)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EquipmentInventory;
  return Object.hash(runtimeType,_this.userId,const DeepCollectionEquality().hash(_this.ownedEquipment),_this.updatedAt);
}

@override
String toString() {
  final _this = this as EquipmentInventory;
  return 'EquipmentInventory(userId: ${_this.userId}, ownedEquipment: ${_this.ownedEquipment}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $EquipmentInventoryCopyWith<$Res>  {
  factory $EquipmentInventoryCopyWith(EquipmentInventory value, $Res Function(EquipmentInventory) _then) = _$EquipmentInventoryCopyWithImpl;
@useResult
$Res call({
 String userId, List<EquipmentType> ownedEquipment, DateTime updatedAt
});




}
/// @nodoc
class _$EquipmentInventoryCopyWithImpl<$Res>
    implements $EquipmentInventoryCopyWith<$Res> {
  _$EquipmentInventoryCopyWithImpl(this._self, this._then);

  final EquipmentInventory _self;
  final $Res Function(EquipmentInventory) _then;

/// Create a copy of EquipmentInventory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? ownedEquipment = null,Object? updatedAt = null,}) {
  return _then(EquipmentInventory(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ownedEquipment: null == ownedEquipment ? _self.ownedEquipment : ownedEquipment // ignore: cast_nullable_to_non_nullable
as List<EquipmentType>,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [EquipmentInventory].
extension EquipmentInventoryPatterns on EquipmentInventory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EquipmentInventory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EquipmentInventory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EquipmentInventory value)  $default,){
final _that = this;
switch (_that) {
case _EquipmentInventory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EquipmentInventory value)?  $default,){
final _that = this;
switch (_that) {
case _EquipmentInventory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  List<EquipmentType> ownedEquipment,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EquipmentInventory() when $default != null:
return $default(_that.userId,_that.ownedEquipment,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  List<EquipmentType> ownedEquipment,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EquipmentInventory():
return $default(_that.userId,_that.ownedEquipment,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  List<EquipmentType> ownedEquipment,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EquipmentInventory() when $default != null:
return $default(_that.userId,_that.ownedEquipment,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EquipmentInventory implements EquipmentInventory {
  const _EquipmentInventory({required this.userId,  List<EquipmentType> ownedEquipment = const [], required this.updatedAt}): _ownedEquipment = ownedEquipment;
  factory _EquipmentInventory.fromJson(Map<String, dynamic> json) => _$EquipmentInventoryFromJson(json);

@override final  String userId;
 final  List<EquipmentType> _ownedEquipment;
@override@JsonKey() List<EquipmentType> get ownedEquipment {
  if (_ownedEquipment is EqualUnmodifiableListView) return _ownedEquipment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownedEquipment);
}

@override final  DateTime updatedAt;

/// Create a copy of EquipmentInventory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EquipmentInventoryCopyWith<_EquipmentInventory> get copyWith => __$EquipmentInventoryCopyWithImpl<_EquipmentInventory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EquipmentInventoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EquipmentInventory&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.ownedEquipment, _ownedEquipment)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(_ownedEquipment),updatedAt);
}

@override
String toString() {
    return 'EquipmentInventory(userId: $userId, ownedEquipment: $ownedEquipment, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EquipmentInventoryCopyWith<$Res> implements $EquipmentInventoryCopyWith<$Res> {
  factory _$EquipmentInventoryCopyWith(_EquipmentInventory value, $Res Function(_EquipmentInventory) _then) = __$EquipmentInventoryCopyWithImpl;
@override @useResult
$Res call({
 String userId, List<EquipmentType> ownedEquipment, DateTime updatedAt
});




}
/// @nodoc
class __$EquipmentInventoryCopyWithImpl<$Res>
    implements _$EquipmentInventoryCopyWith<$Res> {
  __$EquipmentInventoryCopyWithImpl(this._self, this._then);

  final _EquipmentInventory _self;
  final $Res Function(_EquipmentInventory) _then;

/// Create a copy of EquipmentInventory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? ownedEquipment = null,Object? updatedAt = null,}) {
  return _then(_EquipmentInventory(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,ownedEquipment: null == ownedEquipment ? _self._ownedEquipment : ownedEquipment // ignore: cast_nullable_to_non_nullable
as List<EquipmentType>,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

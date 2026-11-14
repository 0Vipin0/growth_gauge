// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => _UserAccount(
  id: json['id'] as String,
  status:
      $enumDecodeNullable(_$AccountStatusEnumMap, json['status']) ??
      AccountStatus.active,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  lastActiveAt: json['lastActiveAt'] == null
      ? null
      : DateTime.parse(json['lastActiveAt'] as String),
);

Map<String, dynamic> _$UserAccountToJson(_UserAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': _$AccountStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
    };

const _$AccountStatusEnumMap = {
  AccountStatus.active: 'ACTIVE',
  AccountStatus.suspended: 'SUSPENDED',
  AccountStatus.deleted: 'DELETED',
  AccountStatus.pending: 'PENDING',
};

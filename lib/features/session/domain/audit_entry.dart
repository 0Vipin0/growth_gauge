import 'package:freezed_annotation/freezed_annotation.dart';

import 'session_enums.dart';

part 'audit_entry.freezed.dart';
part 'audit_entry.g.dart';

@freezed
abstract class AuditEntry with _$AuditEntry {
  const factory({
    required String id,
    required DateTime timestamp,
    @Default(AuditActorType.user) AuditActorType actorType,
    String? actorId,
    required AuditAction action,
    required String entityType,
    required String entityId,
    String? field,
    Object? previousValue,
    Object? newValue,
    String? reason,
    String? correlationId,
  }) = _AuditEntry;

  factory fromJson(Map<String, dynamic> json) => _$AuditEntryFromJson(json);
}

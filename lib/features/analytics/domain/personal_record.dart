import 'package:freezed_annotation/freezed_annotation.dart';

import 'analytics_enums.dart';

part 'personal_record.freezed.dart';

/// Immutable read model representing one personal record achievement.
@freezed
abstract class PersonalRecord with _$PersonalRecord {
  const factory PersonalRecord({
    required String id,
    required String exerciseId,
    required String userId,
    required PrType prType,
    required double value,
    required String sessionId,
    String? setId,
    required DateTime achievedAt,
    String? replacesRecordId,
  }) = _PersonalRecord;
}

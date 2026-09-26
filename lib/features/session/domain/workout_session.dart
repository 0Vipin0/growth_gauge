import 'package:freezed_annotation/freezed_annotation.dart';

import 'audit_entry.dart';
import 'rest_interval.dart';
import 'session_block.dart';
import 'session_enums.dart';
import 'session_interruption.dart';

part 'workout_session.freezed.dart';
part 'workout_session.g.dart';

/// Authoritative, self-contained runtime copy of one immutable template revision.
@freezed
abstract class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,
    required String userId,
    required String templateId,
    required String templateRevisionId,
    required String templateName,
    @Default(SessionStatus.draft) SessionStatus status,
    DateTime? startedAt,
    DateTime? pausedAt,
    DateTime? completedAt,
    required DateTime createdAt,
    @Default([]) List<SessionBlock> blocks,
    @Default([]) List<SessionInterruption> interruptions,
    @Default([]) List<RestInterval> restIntervals,
    @Default([]) List<AuditEntry> audits,
    String? sessionNotes,
  }) = _WorkoutSession;

  factory WorkoutSession.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSessionFromJson(json);

  int elapsedWallClockSecondsAt(DateTime now) {
    final start = startedAt;
    if (start == null) return 0;
    final end = completedAt ?? now;
    return end.difference(start).inSeconds.clamp(0, 1 << 31);
  }

  int elapsedActiveSecondsAt(DateTime now) {
    final wallClock = elapsedWallClockSecondsAt(now);
    final interrupted = interruptions.fold<int>(0, (total, interruption) {
      final end = interruption.endedAt ??
          (status == SessionStatus.paused ? now : interruption.startedAt);
      return total + end.difference(interruption.startedAt).inSeconds;
    });
    return (wallClock - interrupted).clamp(0, wallClock);
  }
}

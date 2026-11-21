import 'package:equatable/equatable.dart';

enum SessionIntervalPhase() {
  work,
  rest,
  cooldown,
}

enum SessionIntervalStatus() {
  pending,
  active,
  paused,
  completed,
  skipped,
}

/// One persisted phase in a session's reusable work/rest/cooldown timer.
class const SessionInterval({
  required final String id,
  required final SessionIntervalPhase phase,
  required final SessionIntervalStatus status,
  required final int durationSeconds,
  final int elapsedSeconds = 0,
  final DateTime? startedAt,
  final DateTime? completedAt,
}) extends Equatable {
  @override
  List<Object?> get props => [
    id,
    phase,
    status,
    durationSeconds,
    elapsedSeconds,
    startedAt,
    completedAt,
  ];

  int elapsedAt(DateTime now) {
    final live = status == SessionIntervalStatus.active && startedAt != null
        ? now.difference(startedAt!).inSeconds
        : 0;
    return (elapsedSeconds + live).clamp(0, durationSeconds);
  }

  int remainingAt(DateTime now) =>
      (durationSeconds - elapsedAt(now)).clamp(0, durationSeconds);

  SessionInterval copyWith({
    SessionIntervalPhase? phase,
    SessionIntervalStatus? status,
    int? durationSeconds,
    int? elapsedSeconds,
    DateTime? startedAt,
    bool clearStartedAt = false,
    DateTime? completedAt,
    bool clearCompletedAt = false,
  }) => SessionInterval(
    id: id,
    phase: phase ?? this.phase,
    status: status ?? this.status,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    startedAt: clearStartedAt ? null : startedAt ?? this.startedAt,
    completedAt: clearCompletedAt ? null : completedAt ?? this.completedAt,
  );

  factory fromJson(Map<String, dynamic> json) => SessionInterval(
    id: json['id'] as String,
    phase: SessionIntervalPhase.values.byName(json['phase'] as String),
    status: SessionIntervalStatus.values.byName(json['status'] as String),
    durationSeconds: json['durationSeconds'] as int,
    elapsedSeconds: json['elapsedSeconds'] as int? ?? 0,
    startedAt: json['startedAt'] == null
        ? null
        : DateTime.parse(json['startedAt'] as String),
    completedAt: json['completedAt'] == null
        ? null
        : DateTime.parse(json['completedAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'phase': phase.name,
    'status': status.name,
    'durationSeconds': durationSeconds,
    'elapsedSeconds': elapsedSeconds,
    'startedAt': startedAt?.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
  };
}

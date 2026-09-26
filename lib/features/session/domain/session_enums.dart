enum SessionStatus {
  draft,
  starting,
  inProgress,
  paused,
  completing,
  completed,
  cancelled,
  abandoned
}

enum InterruptionReason {
  userPause,
  applicationBackground,
  phoneCall,
  equipmentProblem,
  other
}

enum AuditActorType { user, system }

enum AuditAction {
  created,
  updated,
  deleted,
  started,
  paused,
  resumed,
  completed,
  cancelled,
  abandoned
}

enum ExecutionSetStatus { planned, inProgress, completed, skipped }

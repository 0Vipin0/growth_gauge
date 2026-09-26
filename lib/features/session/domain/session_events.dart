import '../../../core/events/domain_event.dart';

class WorkoutSessionStarted extends DomainEvent {
  WorkoutSessionStarted({required super.aggregateId});
  @override
  String get eventType => 'WorkoutSessionStarted';
}

class WorkoutSessionPaused extends DomainEvent {
  WorkoutSessionPaused({required super.aggregateId});
  @override
  String get eventType => 'WorkoutSessionPaused';
}

class WorkoutSessionResumed extends DomainEvent {
  WorkoutSessionResumed({required super.aggregateId});
  @override
  String get eventType => 'WorkoutSessionResumed';
}

class WorkoutSessionCompleted extends DomainEvent {
  WorkoutSessionCompleted({required super.aggregateId});
  @override
  String get eventType => 'WorkoutSessionCompleted';
}

class RestStarted extends DomainEvent {
  RestStarted({required super.aggregateId});
  @override
  String get eventType => 'RestStarted';
}

class RestCompleted extends DomainEvent {
  RestCompleted({required super.aggregateId});
  @override
  String get eventType => 'RestCompleted';
}

class WorkoutSessionCancelled extends DomainEvent {
  WorkoutSessionCancelled({required super.aggregateId});
  @override
  String get eventType => 'WorkoutSessionCancelled';
}

class WorkoutSessionAbandoned extends DomainEvent {
  WorkoutSessionAbandoned({required super.aggregateId});
  @override
  String get eventType => 'WorkoutSessionAbandoned';
}

class ExecutionSetCompleted extends DomainEvent {
  ExecutionSetCompleted({required super.aggregateId, required this.setId});
  final String setId;
  @override
  String get eventType => 'ExecutionSetCompleted';
  @override
  List<Object?> get props => [...super.props, setId];
}

class ExecutionSetSkipped extends DomainEvent {
  ExecutionSetSkipped({required super.aggregateId, required this.setId});
  final String setId;
  @override
  String get eventType => 'ExecutionSetSkipped';
  @override
  List<Object?> get props => [...super.props, setId];
}

class ExecutionSetDeleted extends DomainEvent {
  ExecutionSetDeleted({required super.aggregateId, required this.setId});
  final String setId;
  @override
  String get eventType => 'ExecutionSetDeleted';
  @override
  List<Object?> get props => [...super.props, setId];
}

import '../../../core/events/domain_event.dart';

class  WorkoutSessionStarted({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionStarted';
}

class  WorkoutSessionPaused({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionPaused';
}

class  WorkoutSessionResumed({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionResumed';
}

class  WorkoutSessionCompleted({required super.aggregateId})
    extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionCompleted';
}

class RestStarted({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'RestStarted';
}

class RestCompleted({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'RestCompleted';
}

class RestSkipped({
  required super.aggregateId,
  required final String restIntervalId,
}) extends DomainEvent {
  @override
  String get eventType => 'RestSkipped';
  @override
  List<Object?> get props => [...super.props, restIntervalId];
}

class WorkoutSessionCancelled({required super.aggregateId})
    extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionCancelled';
}

class WorkoutSessionAbandoned({required super.aggregateId})
    extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionAbandoned';
}

class ExecutionSetCompleted({
  required super.aggregateId,
  required final String setId,
}) extends DomainEvent {
  @override
  String get eventType => 'ExecutionSetCompleted';
  @override
  List<Object?> get props => [...super.props, setId];
}

class  ExecutionSetSkipped({
  required super.aggregateId,
  required final String setId,
}) extends DomainEvent {
  @override
  String get eventType => 'ExecutionSetSkipped';
  @override
  List<Object?> get props => [...super.props, setId];
}

class ExecutionSetDeleted({
  required super.aggregateId,
  required final String setId,
}) extends DomainEvent {
  @override
  String get eventType => 'ExecutionSetDeleted';
  @override
  List<Object?> get props => [...super.props, setId];
}

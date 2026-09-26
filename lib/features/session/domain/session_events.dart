import '../../../core/events/domain_event.dart';

class const WorkoutSessionStarted({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionStarted';
}

class const WorkoutSessionPaused({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionPaused';
}

class const WorkoutSessionResumed({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionResumed';
}

class const WorkoutSessionCompleted({required super.aggregateId})
    extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionCompleted';
}

class const RestStarted({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'RestStarted';
}

class const RestCompleted({required super.aggregateId}) extends DomainEvent {
  @override
  String get eventType => 'RestCompleted';
}

class const RestSkipped({
  required super.aggregateId,
  required final String restIntervalId,
}) extends DomainEvent {
  @override
  String get eventType => 'RestSkipped';
  @override
  List<Object?> get props => [...super.props, restIntervalId];
}

class const WorkoutSessionCancelled({required super.aggregateId})
    extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionCancelled';
}

class const WorkoutSessionAbandoned({required super.aggregateId})
    extends DomainEvent {
  @override
  String get eventType => 'WorkoutSessionAbandoned';
}

class const ExecutionSetCompleted({
  required super.aggregateId,
  required final String setId,
}) extends DomainEvent {
  @override
  String get eventType => 'ExecutionSetCompleted';
  @override
  List<Object?> get props => [...super.props, setId];
}

class const ExecutionSetSkipped({
  required super.aggregateId,
  required final String setId,
}) extends DomainEvent {
  @override
  String get eventType => 'ExecutionSetSkipped';
  @override
  List<Object?> get props => [...super.props, setId];
}

class const ExecutionSetDeleted({
  required super.aggregateId,
  required final String setId,
}) extends DomainEvent {
  @override
  String get eventType => 'ExecutionSetDeleted';
  @override
  List<Object?> get props => [...super.props, setId];
}

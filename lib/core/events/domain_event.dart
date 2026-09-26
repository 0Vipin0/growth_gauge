import 'package:equatable/equatable.dart';

import '../ids/unique_id.dart';
import '../time/app_clock.dart';

/// Base class for all domain events across the application.
abstract class DomainEvent extends Equatable {
  final String eventId;
  final DateTime occurredAt;
  final String aggregateId;

  DomainEvent({
    String? eventId,
    DateTime? occurredAt,
    required this.aggregateId,
  })  : eventId = eventId ?? UniqueId.generate().value,
        occurredAt = occurredAt ?? AppClock.nowUtc();

  /// A unique string identifier representing this event type.
  String get eventType;

  @override
  List<Object?> get props => [eventId, occurredAt, aggregateId, eventType];
}

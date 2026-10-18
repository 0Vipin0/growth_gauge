import 'package:equatable/equatable.dart';

import '../ids/unique_id.dart';
import '../time/app_clock.dart';

/// Base class for all domain events across the application.
// Event IDs and timestamps default to runtime-generated values.
// ignore: prefer_const_constructors_in_immutables
abstract class DomainEvent({
  String? eventId,
  DateTime? occurredAt,
  required final String aggregateId,
}) extends Equatable {
  final String eventId = eventId ?? UniqueId.generate().value;
  final DateTime occurredAt = occurredAt ?? AppClock.nowUtc();

  /// A unique string identifier representing this event type.
  String get eventType;

  @override
  List<Object?> get props => [eventId, occurredAt, aggregateId, eventType];
}

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/events/domain_event.dart';
import 'package:growth_gauge/core/events/domain_event_dispatcher.dart';

class const SampleWorkoutEvent({
  required super.aggregateId,
  required final String sessionName,
}) extends DomainEvent {
  @override
  String get eventType => 'SampleWorkoutEvent';
}

class const AnotherDomainEvent({required super.aggregateId})
    extends DomainEvent {
  @override
  String get eventType => 'AnotherDomainEvent';
}

void main() {
  group('DomainEventDispatcher', () {
    late DomainEventDispatcher dispatcher;

    setUp(() {
      dispatcher = DomainEventDispatcher();
    });

    tearDown(() async {
      await dispatcher.dispose();
    });

    test('dispatches events to typed subscribers', () async {
      final receivedEvents = <SampleWorkoutEvent>[];
      final completer = Completer<void>();

      final subscription = dispatcher.subscribe<SampleWorkoutEvent>((event) {
        receivedEvents.add(event);
        if (receivedEvents.length == 2) {
          completer.complete();
        }
      });

      dispatcher.publish(
        const SampleWorkoutEvent(aggregateId: 'sess-1', sessionName: 'Upper Body'),
      );
      // This should be filtered out by typed subscription
      dispatcher.publish(const AnotherDomainEvent(aggregateId: 'other-1'));
      dispatcher.publish(
        const SampleWorkoutEvent(aggregateId: 'sess-2', sessionName: 'Lower Body'),
      );

      await completer.future.timeout(const Duration(seconds: 2));

      expect(receivedEvents.length, equals(2));
      expect(receivedEvents[0].sessionName, equals('Upper Body'));
      expect(receivedEvents[1].sessionName, equals('Lower Body'));

      await subscription.cancel();
    });

    test('cancelled subscription does not receive subsequent events', () async {
      final received = <SampleWorkoutEvent>[];
      final subscription = dispatcher.subscribe<SampleWorkoutEvent>(
        (e) => received.add(e),
      );

      dispatcher.publish(
        const SampleWorkoutEvent(aggregateId: 's1', sessionName: 'A'),
      );
      await Future<void>.delayed(const Duration(milliseconds: 20));

      expect(received.length, equals(1));

      await subscription.cancel();

      dispatcher.publish(
        const SampleWorkoutEvent(aggregateId: 's2', sessionName: 'B'),
      );
      await Future<void>.delayed(const Duration(milliseconds: 20));

      expect(received.length, equals(1));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:growth_gauge/features/timer/provider/timer_list_provider.dart';
import 'package:growth_gauge/features/timer/repository/repository.dart';
import 'package:growth_gauge/features/notification/notification_service.dart';
import 'package:growth_gauge/features/timer/model/model.dart';

class MockTimerRepository extends Mock implements TimerRepository {}
class MockNotificationService extends Mock implements NotificationService {}

final testTimers = [
  TimerModel(
    id: '1',
    name: 'Test Timer 1',
    interval: Duration(minutes: 5),
    description: 'A test timer 1',
    target: Duration(minutes: 10),
    logs: [
      TimerLog(id: 'log1', action: 'Started', timestamp: DateTime(2025, 4, 28), interval: Duration(minutes: 2)),
      TimerLog(id: 'log2', action: 'Paused', timestamp: DateTime(2025, 4, 29), interval: Duration(minutes: 3)),
    ],
    tags: ['tag1', 'tag2'],
  ),
  TimerModel(
    id: '2',
    name: 'Test Timer 2',
    interval: Duration(minutes: 15),
    description: 'A test timer 2',
    target: Duration(minutes: 20),
    logs: [
      TimerLog(id: 'log3', action: 'Started', timestamp: DateTime(2025, 4, 27), interval: Duration(minutes: 5)),
    ],
    tags: ['tag3'],
  ),
  TimerModel(
    id: '3',
    name: 'Test Timer 3',
    interval: Duration.zero,
    description: 'A test timer 3',
    target: Duration(minutes: 5),
    logs: [],
    tags: [],
  ),
  TimerModel(
    id: '4',
    name: 'Test Timer 4',
    interval: Duration(minutes: 8),
    description: 'A test timer 4',
    target: Duration(minutes: 10),
    logs: [
      TimerLog(id: 'log4', action: 'Started', timestamp: DateTime(2025, 4, 30), interval: Duration(minutes: 4)),
    ],
    tags: ['tag4'],
  ),
];

void main() {
  late MockTimerRepository mockRepository;
  late MockNotificationService mockNotificationService;
  late TimerListProvider provider;

  setUp(() {
    mockRepository = MockTimerRepository();
    mockNotificationService = MockNotificationService();
    provider = TimerListProvider(
      repository: mockRepository,
      notificationService: mockNotificationService,
    );
  });

  group('TimerListProvider Tests', () {
    test('addTimer adds a new timer to the list', () {
      // Arrange
      // Act
      provider.addTimer(testTimers[0]);

      // Assert
      expect(provider.timers.length, 1);
      expect(provider.timers.first.name, 'Test Timer 1');
    });

    test('filterTimersByTags', () {
      // TODO: Add test logic for filterTimersByTags
    });

    test('filterTimersByText', () {
      // TODO: Add test logic for filterTimersByText
    });

    test('getAllTags', () {
      // TODO: Add test logic for getAllTags
    });

    test('saveTimers', () {
      // TODO: Add test logic for saveTimers
    });

    test('clearTimers', () {
      // TODO: Add test logic for clearTimers
    });

    test('addTimer', () {
      // TODO: Add test logic for addTimer
    });

    test('removeTimer', () {
      // TODO: Add test logic for removeTimer
    });

    test('importTimersFromData', () {
      // TODO: Add test logic for importTimersFromData
    });

    test('convertToCSV', () {
      // TODO: Add test logic for convertToCSV
    });

    test('sortTimersByName', () {
      // TODO: Add test logic for sortTimersByName
    });

    test('sortTimersByInterval', () {
      // TODO: Add test logic for sortTimersByInterval
    });
  });
}
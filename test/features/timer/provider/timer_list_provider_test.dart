import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/notification/notification_service.dart';
import 'package:growth_gauge/features/timer/model/model.dart';
import 'package:growth_gauge/features/timer/provider/timer_list_provider.dart';
import 'package:growth_gauge/features/timer/repository/repository.dart';
import 'package:mockito/mockito.dart';

class MockTimerRepository extends Mock implements TimerRepository {}
class MockNotificationService extends Mock implements NotificationService {}

final testTimers = [
  TimerModel(
    id: '1',
    name: 'Test Timer 1',
    interval: const Duration(minutes: 5),
    description: 'A test timer 1',
    target: const Duration(minutes: 10),
    logs: [
      TimerLog(id: 'log1', action: 'Started', timestamp: DateTime(2025, 4, 28), interval: const Duration(minutes: 2)),
      TimerLog(id: 'log2', action: 'Paused', timestamp: DateTime(2025, 4, 29), interval: const Duration(minutes: 3)),
    ],
    tags: ['tag1', 'tag2'],
  ),
  TimerModel(
    id: '2',
    name: 'Test Timer 2',
    interval: const Duration(minutes: 15),
    description: 'A test timer 2',
    target: const Duration(minutes: 20),
    logs: [
      TimerLog(id: 'log3', action: 'Started', timestamp: DateTime(2025, 4, 27), interval: const Duration(minutes: 5)),
    ],
    tags: ['tag3'],
  ),
  TimerModel(
    id: '3',
    name: 'Test Timer 3',
    interval: Duration.zero,
    description: 'A test timer 3',
    target: const Duration(minutes: 5),
    logs: [],
    tags: [],
  ),
  TimerModel(
    id: '4',
    name: 'Test Timer 4',
    interval: const Duration(minutes: 8),
    description: 'A test timer 4',
    target: const Duration(minutes: 10),
    logs: [
      TimerLog(id: 'log4', action: 'Started', timestamp: DateTime(2025, 4, 30), interval: const Duration(minutes: 4)),
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

    when(mockRepository.getTimers()).thenAnswer((_) async => <TimerModel>[]);
    when(mockRepository.saveTimers(testTimers)).thenAnswer((_) => Future.value());
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
      // Arrange
      provider.addTimer(testTimers[0]);
      provider.addTimer(testTimers[1]);

      // Act
      provider.filterTimersByTags(['tag1']);

      // Assert
      expect(provider.filteredTimers.length, 1);
    });

    test('filterTimersByText', () {
      // Arrange
      provider.addTimer(testTimers[0]);
      provider.addTimer(testTimers[1]);

      // Act
      provider.filterTimersByText('Test Timer 1');

      // Assert
      expect(provider.filteredTimers.length, 1);
      expect(provider.filteredTimers.first.name, 'Test Timer 1');
    });

    test('getAllTags', () {
      // Arrange
      provider.addTimer(testTimers[0]);
      provider.addTimer(testTimers[1]);

      // Act
      final tags = provider.getAllTags();

      // Assert
      expect(tags, containsAll(['tag1', 'tag2', 'tag3']));
    });

    test('saveTimers', () async {
      // Arrange
      when(mockRepository.saveTimers(testTimers)).thenAnswer((_) async {});

      // Act
      await provider.saveTimers();

      // Assert
      verify(mockRepository.saveTimers(testTimers)).called(1);
    });

    test('clearTimers', () async {
      // Arrange
      provider.addTimer(testTimers[0]);

      // Act
      await provider.clearTimers();

      // Assert
      expect(provider.timers.isEmpty, true);
    });

    test('addTimer', () {
      // Act
      provider.addTimer(testTimers[0]);

      // Assert
      expect(provider.timers.length, 1);
    });

    test('removeTimer', () {
      // Arrange
      provider.addTimer(testTimers[0]);

      // Act
      provider.removeTimer(testTimers[0]);

      // Assert
      expect(provider.timers.isEmpty, true);
    });

    test('importTimersFromData', () {
      // Arrange
      final importedTimers = [testTimers[2], testTimers[3]];

      // Act
      provider.importTimersFromData(importedTimers);

      // Assert
      expect(provider.timers.length, 2);
      expect(provider.timers, containsAll(importedTimers));
    });

    test('convertToCSV', () {
      // Arrange
      provider.addTimer(testTimers[0]);

      // Act
      final csv = provider.convertToCSV();

      // Assert
      expect(csv, contains('Test Timer 1'));
    });

    test('sortTimersByName', () {
      // Arrange
      provider.addTimer(testTimers[1]);
      provider.addTimer(testTimers[0]);

      // Act
      provider.sortTimersByName();

      // Assert
      expect(provider.timers.first.name, 'Test Timer 1');
    });

    test('sortTimersByInterval', () {
      // Arrange
      provider.addTimer(testTimers[1]);
      provider.addTimer(testTimers[0]);

      // Act
      provider.sortTimersByInterval();

      // Assert
      expect(provider.timers.first.interval, const Duration(minutes: 5));
    });
  });
}

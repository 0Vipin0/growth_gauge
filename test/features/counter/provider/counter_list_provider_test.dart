import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/counter/model/model.dart';
import 'package:growth_gauge/features/counter/provider/counter_list_provider.dart';
import 'package:growth_gauge/features/counter/repository/repository.dart';
import 'package:growth_gauge/features/notification/notification_service.dart';
import 'package:mockito/mockito.dart';

class MockNotificationService extends Mock implements NotificationService {}

final testCounter = CounterModel(
  id: '1',
  name: 'Test Counter',
  count: 0,
  description: 'A test counter',
  target: 10,
  logs: [],
  tags: ['test'],
);

final testCounters = [
  CounterModel(
    id: '1',
    name: 'Test Counter 1',
    count: 5,
    description: 'A test counter 1',
    target: 10,
    logs: [
      CounterLog(
          id: 'log1', action: 'Incremented', timestamp: DateTime(2025, 4, 28)),
      CounterLog(
          id: 'log2', action: 'Decremented', timestamp: DateTime(2025, 4, 29)),
    ],
    tags: ['tag1', 'tag2'],
  ),
  CounterModel(
    id: '2',
    name: 'Test Counter 2',
    count: 15,
    description: 'A test counter 2',
    target: 20,
    logs: [
      CounterLog(
          id: 'log3', action: 'Incremented', timestamp: DateTime(2025, 4, 27)),
    ],
    tags: ['tag3'],
  ),
  CounterModel(
    id: '3',
    name: 'Test Counter 3',
    count: 0,
    description: 'A test counter 3',
    target: 5,
    logs: [],
    tags: [],
  ),
  CounterModel(
    id: '4',
    name: 'Test Counter 4',
    count: 8,
    description: 'A test counter 4',
    target: 10,
    logs: [
      CounterLog(
          id: 'log4', action: 'Incremented', timestamp: DateTime(2025, 4, 30)),
    ],
    tags: ['tag4'],
  ),
];

void main() {
  late InMemoryCounterRepository mockRepository;
  late MockNotificationService mockNotificationService;
  late CounterListProvider provider;

  setUp(() {
    mockRepository = InMemoryCounterRepository();
    mockNotificationService = MockNotificationService();
    provider = CounterListProvider(
      repository: mockRepository,
      notificationService: mockNotificationService,
    );
  });

  group('CounterListProvider Tests', () {
    test('addCounter adds a new counter to the list', () {
      // Arrange
      // Act
      provider.addCounter(testCounter);

      // Assert
      expect(provider.counters.length, 1);
      expect(provider.counters.first.name, 'Test Counter');
    });

    test('filterCountersByTags', () {
      // Arrange
      provider.addCounter(testCounters[0]);
      provider.addCounter(testCounters[1]);

      // Act
      provider.filterCountersByTags(['tag1']);

      // Assert
      expect(provider.filteredCounters.length, 1);
    });

    test('filterCountersByText', () {
      // Arrange
      provider.addCounter(testCounters[0]);
      provider.addCounter(testCounters[1]);

      // Act
      provider.filterCountersByText('Test Counter 1');

      // Assert
      expect(provider.filteredCounters.length, 1);
      expect(provider.filteredCounters.first.name, 'Test Counter 1');
    });

    test('getAllTags', () {
      // Arrange
      provider.addCounter(testCounters[0]);
      provider.addCounter(testCounters[1]);

      // Act
      final tags = provider.getAllTags();

      // Assert
      expect(tags, containsAll(['tag1', 'tag2', 'tag3']));
    });

    test('clearCounters', () async {
      // Arrange
      provider.addCounter(testCounters[0]);

      // Act
      await provider.clearCounters();

      // Assert
      expect(provider.counters.isEmpty, true);
    });

    test('addCounter', () {
      // Act
      provider.addCounter(testCounters[0]);

      // Assert
      expect(provider.counters.length, 1);
    });

    test('removeCounter', () {
      // Arrange
      provider.addCounter(testCounters[0]);

      // Act
      provider.removeCounter(testCounters[0]);

      // Assert
      expect(provider.counters.isEmpty, true);
    });

    test('importCountersFromData', () {
      // Arrange
      final importedCounters = [testCounters[2], testCounters[3]];

      // Act
      provider.importCountersFromData(importedCounters);

      // Assert
      expect(provider.counters.length, 2);
      expect(provider.counters, containsAll(importedCounters));
    });

    test('convertToCSV', () {
      // Arrange
      provider.addCounter(testCounters[0]);

      // Act
      final csv = provider.convertToCSV();

      // Assert
      expect(csv, contains('Test Counter 1'));
    });

    test('sortCountersByName', () {
      // Arrange
      provider.addCounter(testCounters[1]);
      provider.addCounter(testCounters[0]);

      // Act
      provider.sortCountersByName();

      // Assert
      expect(provider.counters.first.name, 'Test Counter 1');
    });

    test('sortCountersByCount', () {
      // Arrange
      provider.addCounter(testCounters[1]);
      provider.addCounter(testCounters[0]);

      // Act
      provider.sortCountersByCount();

      // Assert
      expect(provider.counters.first.count, 5);
    });

    test('addCounter adds a counter to the list', () {
      // Act
      provider.addCounter(testCounters[0]);

      // Assert
      expect(provider.counters.length, 1);
      expect(provider.counters.first.name, 'Test Counter 1');
    });

    test('removeCounter removes a counter from the list', () {
      // Arrange
      provider.addCounter(testCounters[0]);

      // Act
      provider.removeCounter(testCounters[0]);

      // Assert
      expect(provider.counters.isEmpty, true);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_project_name/features/counter/provider/counter_list_provider.dart';
import 'package:your_project_name/features/counter/repository/repository.dart';
import 'package:your_project_name/features/notification/notification_service.dart';

class MockCounterRepository extends Mock implements CounterRepository {}
class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late MockCounterRepository mockRepository;
  late MockNotificationService mockNotificationService;
  late CounterListProvider provider;

  setUp(() {
    mockRepository = MockCounterRepository();
    mockNotificationService = MockNotificationService();
    provider = CounterListProvider(
      repository: mockRepository,
      notificationService: mockNotificationService,
    );
  });

  group('CounterListProvider Tests', () {
    test('addCounter adds a new counter to the list', () {
      // Arrange
      final counter = CounterModel(id: '1', name: 'Test Counter', count: 0);

      // Act
      provider.addCounter(counter);

      // Assert
      expect(provider.counters.length, 1);
      expect(provider.counters.first.name, 'Test Counter');
    });

    // Add more tests for other methods
  });
}
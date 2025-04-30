import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:your_project_name/features/timer/provider/timer_list_provider.dart';
import 'package:your_project_name/features/timer/repository/repository.dart';
import 'package:your_project_name/features/notification/notification_service.dart';

class MockTimerRepository extends Mock implements TimerRepository {}
class MockNotificationService extends Mock implements NotificationService {}

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
      final timer = TimerModel(id: '1', name: 'Test Timer', interval: Duration.zero);

      // Act
      provider.addTimer(timer);

      // Assert
      expect(provider.timers.length, 1);
      expect(provider.timers.first.name, 'Test Timer');
    });

    // Add more tests for other methods
  });
}
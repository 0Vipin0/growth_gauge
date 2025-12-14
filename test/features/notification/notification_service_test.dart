import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/services/notification_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'notification_service_test.mocks.dart';

@GenerateMocks([NotificationServiceBase])
void main() {
  late MockNotificationServiceBase mockNotificationService;

  setUp(() {
    mockNotificationService = MockNotificationServiceBase();

    // Mocking Future<void> methods to return completed futures
    when(mockNotificationService.initializeTimeZone())
        .thenAnswer((_) => Future.value());
    when(mockNotificationService.initializeNotificationSettings())
        .thenAnswer((_) => Future.value());
    when(mockNotificationService.requestPlatformPermissions())
        .thenAnswer((_) => Future.value());
    when(mockNotificationService.isAndroidPermissionGranted())
        .thenAnswer((_) => Future.value());
    when(mockNotificationService.scheduleNotification(
      id: anyNamed('id'),
      title: anyNamed('title'),
      body: anyNamed('body'),
      scheduledTime: anyNamed('scheduledTime'),
      sound: anyNamed('sound'),
    )).thenAnswer((_) => Future.value());
    when(mockNotificationService.scheduleDailyNotification(
      id: anyNamed('id'),
      title: anyNamed('title'),
      body: anyNamed('body'),
      time: anyNamed('time'),
      sound: anyNamed('sound'),
    )).thenAnswer((_) => Future.value());

    // Initialize tz.local for timezone-related tests
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/New_York'));
  });

  test('initializeTimeZone should be called', () async {
    await mockNotificationService.initializeTimeZone();
    verify(mockNotificationService.initializeTimeZone()).called(1);
  });

  test('initializeNotificationSettings should be called', () async {
    await mockNotificationService.initializeNotificationSettings();
    verify(mockNotificationService.initializeNotificationSettings()).called(1);
  });

  test('requestPlatformPermissions should be called', () async {
    await mockNotificationService.requestPlatformPermissions();
    verify(mockNotificationService.requestPlatformPermissions()).called(1);
  });

  test('isAndroidPermissionGranted should be called', () async {
    await mockNotificationService.isAndroidPermissionGranted();
    verify(mockNotificationService.isAndroidPermissionGranted()).called(1);
  });

  test('scheduleNotification should be called with correct parameters',
      () async {
    final tz.TZDateTime scheduledTime =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
    await mockNotificationService.scheduleNotification(
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
      scheduledTime: scheduledTime,
      sound: 'test_sound',
    );
    verify(mockNotificationService.scheduleNotification(
      id: 1,
      title: 'Test Title',
      body: 'Test Body',
      scheduledTime: scheduledTime,
      sound: 'test_sound',
    )).called(1);
  });

  test('scheduleDailyNotification should be called with correct parameters',
      () async {
    final TimeOfDay time = TimeOfDay.now();
    await mockNotificationService.scheduleDailyNotification(
      id: 1,
      title: 'Daily Test Title',
      body: 'Daily Test Body',
      time: time,
      sound: 'daily_test_sound',
    );
    verify(mockNotificationService.scheduleDailyNotification(
      id: 1,
      title: 'Daily Test Title',
      body: 'Daily Test Body',
      time: time,
      sound: 'daily_test_sound',
    )).called(1);
  });
}

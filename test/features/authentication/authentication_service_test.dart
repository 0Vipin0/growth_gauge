import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/authentication/authentication_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_service_test.mocks.dart';

@GenerateMocks([AuthenticationServiceBase])
void main() {
  group('AuthenticationServiceBase', () {
    late AuthenticationServiceBase authService;

    setUp(() {
      authService = MockAuthenticationServiceBase();
    });

    test('canAuthenticateWithBiometrics should return true', () async {
      when(authService.canAuthenticateWithBiometrics())
          .thenAnswer((_) async => true);
      final result = await authService.canAuthenticateWithBiometrics();
      expect(result, true);
    });

    test('authenticateWithBiometrics should return true', () async {
      when(authService.authenticateWithBiometrics())
          .thenAnswer((_) async => true);
      final result = await authService.authenticateWithBiometrics();
      expect(result, true);
    });

    test('savePin should complete without errors', () {
      when(authService.savePin('1234')).thenAnswer((_) async {});
      expect(authService.savePin('1234'), completes);
    });

    test('authenticateWithPin should return true for correct pin', () async {
      when(authService.authenticateWithPin('1234'))
          .thenAnswer((_) async => true);
      final result = await authService.authenticateWithPin('1234');
      expect(result, true);
    });

    test('getSavedPin should return a pin', () async {
      when(authService.getSavedPin()).thenAnswer((_) async => '1234');
      final result = await authService.getSavedPin();
      expect(result, '1234');
    });
  });
}

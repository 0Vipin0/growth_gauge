import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/error/failures.dart';
import 'package:growth_gauge/core/error/result.dart';

void main() {
  group('Result', () {
    test('Success holds data and returns true for isSuccess', () {
      const result = Result<int, Failure>.success(42);

      expect(result.isSuccess, isTrue);
      expect(result.isError, isFalse);
      expect(result.dataOrNull, equals(42));
      expect(result.errorOrNull, isNull);

      final mapped = result.map((data) => data * 2);
      expect(mapped.dataOrNull, equals(84));

      final value = result.when(
        success: (data) => 'success $data',
        error: (failure) => 'error',
      );
      expect(value, equals('success 42'));
    });

    test('Error holds failure and returns true for isError', () {
      const failure = ValidationFailure('Invalid rep count', 'reps');
      const result = Result<int, Failure>.error(failure);

      expect(result.isSuccess, isFalse);
      expect(result.isError, isTrue);
      expect(result.dataOrNull, isNull);
      expect(result.errorOrNull, equals(failure));

      final mapped = result.map((data) => data * 2);
      expect(mapped.isError, isTrue);
      expect(mapped.errorOrNull, equals(failure));

      final value = result.when(
        success: (data) => 'success',
        error: (f) => f.message,
      );
      expect(value, equals('Invalid rep count'));
    });

    test('flatMap chains operations correctly', () {
      const result = Result<int, Failure>.success(10);
      final flatMapped = result.flatMap(
        (data) => Result<String, Failure>.success('Value: $data'),
      );

      expect(flatMapped.dataOrNull, equals('Value: 10'));

      const errorResult = Result<int, Failure>.error(
        DatabaseFailure('Disk error'),
      );
      final errorChain = errorResult.flatMap(
        (data) => Result<String, Failure>.success('Value: $data'),
      );
      expect(errorChain.isError, isTrue);
    });

    test('Failures equality and toString behavior', () {
      const f1 = NotFoundFailure('Not found', '123');
      const f2 = NotFoundFailure('Not found', '123');
      const f3 = ConflictFailure('Conflict', '123');

      expect(f1, equals(f2));
      expect(f1, isNot(equals(f3)));
      expect(f1.toString(), contains('NotFoundFailure: Not found'));
    });
  });
}

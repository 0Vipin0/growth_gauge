import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/ids/unique_id.dart';

void main() {
  group('UniqueId', () {
    test('generate() creates a valid UUIDv4', () {
      final id = UniqueId.generate();

      expect(id.value.isNotEmpty, isTrue);
      expect(id.isUuidV4, isTrue);
      expect(id.toString(), equals(id.value));
    });

    test('from() preserves valid custom IDs', () {
      final customId = UniqueId.from('user-001');

      expect(customId.value, equals('user-001'));
      expect(customId.isUuidV4, isFalse);
    });

    test(
      'from() throws ArgumentError for empty or whitespace-only strings',
      () {
        expect(() => UniqueId.from(''), throwsArgumentError);
        expect(() => UniqueId.from('   '), throwsArgumentError);
      },
    );

    test('equality holds for matching values', () {
      final id1 = UniqueId.from('test-id-123');
      final id2 = UniqueId.from('test-id-123');
      final id3 = UniqueId.from('other-id-456');

      expect(id1, equals(id2));
      expect(id1.hashCode, equals(id2.hashCode));
      expect(id1, isNot(equals(id3)));
    });
  });
}

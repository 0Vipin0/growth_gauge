import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/time/app_clock.dart';

void main() {
  group('AppClock', () {
    test('nowUtc() always produces DateTime with isUtc true', () {
      final now = AppClock.nowUtc();
      expect(now.isUtc, isTrue);
    });

    test('nowIsoUtc() produces ISO-8601 UTC timestamp', () {
      final iso = AppClock.nowIsoUtc();
      expect(iso, contains('T'));
      expect(iso.endsWith('Z'), isTrue);

      final parsed = DateTime.parse(iso);
      expect(parsed.isUtc, isTrue);
    });

    test('deterministic clock testing using withClock', () {
      final fixedDate = DateTime.utc(2026, 9, 24, 9, 15);

      withClock(Clock.fixed(fixedDate), () {
        expect(AppClock.nowUtc(), equals(fixedDate));
        expect(AppClock.nowIsoUtc(), equals('2026-09-24T09:15:00.000Z'));
      });
    });

    test('parseIsoUtc and formatIsoUtc roundtrip', () {
      const sample = '2026-09-24T09:15:00.000Z';
      final parsed = AppClock.parseIsoUtc(sample);

      expect(parsed.isUtc, isTrue);
      expect(parsed.year, equals(2026));
      expect(parsed.month, equals(9));
      expect(parsed.day, equals(24));
      expect(parsed.hour, equals(9));
      expect(parsed.minute, equals(15));
      expect(AppClock.formatIsoUtc(parsed), equals(sample));
    });
  });
}

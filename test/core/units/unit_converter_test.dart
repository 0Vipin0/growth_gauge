import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/core/units/unit_converter.dart';
import 'package:growth_gauge/core/units/unit_types.dart';

void main() {
  group('UnitConverter', () {
    test('weight conversions roundtrip with minimal floating-point deviation', () {
      final weights = [0.0, 20.0, 60.0, 82.5, 100.0, 142.5, 225.0];

      for (final kg in weights) {
        final lb = UnitConverter.kgToLb(kg);
        final roundtripKg = UnitConverter.lbToKg(lb);
        expect(roundtripKg, closeTo(kg, 1e-6));
      }
    });

    test('weightToCanonical and weightFromCanonical obey unit selection', () {
      expect(UnitConverter.weightFromCanonical(100.0, WeightUnit.kilograms), equals(100.0));
      expect(UnitConverter.weightFromCanonical(100.0, WeightUnit.pounds), closeTo(220.462, 0.01));

      expect(UnitConverter.weightToCanonical(100.0, WeightUnit.kilograms), equals(100.0));
      expect(UnitConverter.weightToCanonical(220.462262, WeightUnit.pounds), closeTo(100.0, 0.01));
    });

    test('formatWeight produces clean human-readable output', () {
      expect(UnitConverter.formatWeight(100.0, WeightUnit.kilograms), equals('100 kg'));
      expect(UnitConverter.formatWeight(100.5, WeightUnit.kilograms), equals('100.5 kg'));
      expect(UnitConverter.formatWeight(50.0, WeightUnit.pounds), equals('110.2 lb'));
    });

    test('distance conversions roundtrip correctly', () {
      final distancesMeters = [0.0, 100.0, 400.0, 1000.0, 5000.0, 42195.0];

      for (final m in distancesMeters) {
        final km = UnitConverter.metersToKm(m);
        expect(UnitConverter.kmToMeters(km), closeTo(m, 1e-6));

        final miles = UnitConverter.metersToMiles(m);
        expect(UnitConverter.milesToMeters(miles), closeTo(m, 1e-6));
      }
    });

    test('height conversions (cm to feet/inches) roundtrip accurately', () {
      // 180 cm ≈ 5 feet 10.86 inches
      final (feet, inches) = UnitConverter.cmToFeetAndInches(180.0);
      expect(feet, equals(5));
      expect(inches, closeTo(10.866, 0.01));

      final roundtripCm = UnitConverter.feetAndInchesToCm(feet, inches);
      expect(roundtripCm, closeTo(180.0, 1e-6));
    });

    test('temperature conversions', () {
      expect(UnitConverter.celsiusToFahrenheit(0.0), equals(32.0));
      expect(UnitConverter.celsiusToFahrenheit(100.0), equals(212.0));
      expect(UnitConverter.fahrenheitToCelsius(32.0), equals(0.0));
      expect(UnitConverter.fahrenheitToCelsius(212.0), equals(100.0));
    });
  });
}

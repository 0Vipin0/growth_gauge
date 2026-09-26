import 'unit_types.dart';

/// Provides mathematically exact bidirectional conversions between
/// canonical domain units (kg, m, cm, °C) and display units.
class UnitConverter {
  static const double _lbPerKg = 2.2046226218487757;
  static const double _kgPerLb = 0.45359237;
  static const double _metersPerMile = 1609.344;
  static const double _cmPerInch = 2.54;

  const UnitConverter._();

  // --- Weight Conversions (Canonical: Kilograms) ---

  /// Converts canonical kilograms to pounds.
  static double kgToLb(double kg) => kg * _lbPerKg;

  /// Converts pounds to canonical kilograms.
  static double lbToKg(double lb) => lb * _kgPerLb;

  /// Converts canonical weight in kg to target [WeightUnit].
  static double weightFromCanonical(double kg, WeightUnit targetUnit) {
    return switch (targetUnit) {
      WeightUnit.kilograms => kg,
      WeightUnit.pounds => kgToLb(kg),
    };
  }

  /// Converts display weight to canonical kilograms.
  static double weightToCanonical(double value, WeightUnit sourceUnit) {
    return switch (sourceUnit) {
      WeightUnit.kilograms => value,
      WeightUnit.pounds => lbToKg(value),
    };
  }

  /// Formats weight with unit symbol and decimal precision.
  static String formatWeight(double kg, WeightUnit unit, {int decimals = 1}) {
    final val = weightFromCanonical(kg, unit);
    // If integer, omit trailing .0
    if (val == val.roundToDouble()) {
      return '${val.toInt()} ${unit.symbol}';
    }
    return '${val.toStringAsFixed(decimals)} ${unit.symbol}';
  }

  // --- Distance Conversions (Canonical: Meters) ---

  /// Converts canonical meters to kilometers.
  static double metersToKm(double meters) => meters / 1000.0;

  /// Converts kilometers to canonical meters.
  static double kmToMeters(double km) => km * 1000.0;

  /// Converts canonical meters to miles.
  static double metersToMiles(double meters) => meters / _metersPerMile;

  /// Converts miles to canonical meters.
  static double milesToMeters(double miles) => miles * _metersPerMile;

  /// Converts canonical distance in meters to target [DistanceUnit].
  static double distanceFromCanonical(double meters, DistanceUnit targetUnit) {
    return switch (targetUnit) {
      DistanceUnit.meters => meters,
      DistanceUnit.kilometers => metersToKm(meters),
      DistanceUnit.miles => metersToMiles(meters),
    };
  }

  /// Converts display distance to canonical meters.
  static double distanceToCanonical(double value, DistanceUnit sourceUnit) {
    return switch (sourceUnit) {
      DistanceUnit.meters => value,
      DistanceUnit.kilometers => kmToMeters(value),
      DistanceUnit.miles => milesToMeters(value),
    };
  }

  // --- Height Conversions (Canonical: Centimeters) ---

  /// Converts centimeters to total inches.
  static double cmToInches(double cm) => cm / _cmPerInch;

  /// Converts total inches to centimeters.
  static double inchesToCm(double inches) => inches * _cmPerInch;

  /// Converts centimeters to (feet, inches).
  static (int feet, double inches) cmToFeetAndInches(double cm) {
    final totalInches = cmToInches(cm);
    final feet = totalInches ~/ 12;
    final remainingInches = totalInches - (feet * 12);
    return (feet, remainingInches);
  }

  /// Converts (feet, inches) to canonical centimeters.
  static double feetAndInchesToCm(int feet, double inches) {
    final totalInches = (feet * 12) + inches;
    return inchesToCm(totalInches);
  }

  // --- Temperature Conversions (Canonical: Celsius) ---

  /// Converts Celsius to Fahrenheit.
  static double celsiusToFahrenheit(double c) => (c * 9.0 / 5.0) + 32.0;

  /// Converts Fahrenheit to Celsius.
  static double fahrenheitToCelsius(double f) => (f - 32.0) * 5.0 / 9.0;
}

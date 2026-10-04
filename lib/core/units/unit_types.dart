/// Supported weight units for presentation.
enum WeightUnit(final String symbol) {
  kilograms('kg'),
  pounds('lb');

  static WeightUnit fromString(String val) {
    return switch (val.trim().toLowerCase()) {
      'lb' || 'lbs' || 'pounds' => WeightUnit.pounds,
      _ => WeightUnit.kilograms,
    };
  }
}

/// Supported distance units for presentation.
enum DistanceUnit(final String symbol) {
  meters('m'),
  kilometers('km'),
  miles('mi');

  static DistanceUnit fromString(String val) {
    return switch (val.trim().toLowerCase()) {
      'km' || 'kilometers' => DistanceUnit.kilometers,
      'mi' || 'miles' => DistanceUnit.miles,
      _ => DistanceUnit.meters,
    };
  }
}

/// Supported height units for presentation.
enum HeightUnit(final String symbol) {
  centimeters('cm'),
  feetAndInches('ft_in');

  static HeightUnit fromString(String val) {
    return switch (val.trim().toLowerCase()) {
      'ft' || 'ft_in' || 'feet' || 'inches' => HeightUnit.feetAndInches,
      _ => HeightUnit.centimeters,
    };
  }
}

/// Supported temperature units.
enum TemperatureUnit(final String symbol) {
  celsius('°C'),
  fahrenheit('°F');

  static TemperatureUnit fromString(String val) {
    return switch (val.trim().toLowerCase()) {
      'f' || 'fahrenheit' => TemperatureUnit.fahrenheit,
      _ => TemperatureUnit.celsius,
    };
  }
}

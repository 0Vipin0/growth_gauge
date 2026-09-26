/// Supported weight units for presentation.
enum WeightUnit {
  kilograms('kg'),
  pounds('lb');

  final String symbol;
  const WeightUnit(this.symbol);

  static WeightUnit fromString(String val) {
    return switch (val.trim().toLowerCase()) {
      'lb' || 'lbs' || 'pounds' => WeightUnit.pounds,
      _ => WeightUnit.kilograms,
    };
  }
}

/// Supported distance units for presentation.
enum DistanceUnit {
  meters('m'),
  kilometers('km'),
  miles('mi');

  final String symbol;
  const DistanceUnit(this.symbol);

  static DistanceUnit fromString(String val) {
    return switch (val.trim().toLowerCase()) {
      'km' || 'kilometers' => DistanceUnit.kilometers,
      'mi' || 'miles' => DistanceUnit.miles,
      _ => DistanceUnit.meters,
    };
  }
}

/// Supported height units for presentation.
enum HeightUnit {
  centimeters('cm'),
  feetAndInches('ft_in');

  final String symbol;
  const HeightUnit(this.symbol);

  static HeightUnit fromString(String val) {
    return switch (val.trim().toLowerCase()) {
      'ft' || 'ft_in' || 'feet' || 'inches' => HeightUnit.feetAndInches,
      _ => HeightUnit.centimeters,
    };
  }
}

/// Supported temperature units.
enum TemperatureUnit {
  celsius('°C'),
  fahrenheit('°F');

  final String symbol;
  const TemperatureUnit(this.symbol);

  static TemperatureUnit fromString(String val) {
    return switch (val.trim().toLowerCase()) {
      'f' || 'fahrenheit' => TemperatureUnit.fahrenheit,
      _ => TemperatureUnit.celsius,
    };
  }
}

enum DurationInterval {
  tenSeconds,
  thirtySeconds,
  minute,
  twoMinutes,
}

extension DurationIntervalExtension on DurationInterval {
  String getUnitLabel() {
    switch (this) {
      case DurationInterval.tenSeconds:
        return '10-second units';
      case DurationInterval.thirtySeconds:
        return '30-second units';
      case DurationInterval.minute:
        return 'minutes';
      case DurationInterval.twoMinutes:
        return '2-minute units';
    }
  }
}

import 'package:clock/clock.dart';

/// Provides standardized UTC time handling and deterministic clock testing.
// This class is a namespace for the shared clock helpers.
// ignore: avoid_classes_with_only_static_members
class const AppClock() {
  /// Returns current system time forced to UTC.
  static DateTime nowUtc() {
    return clock.now().toUtc();
  }

  /// Returns current system time as an ISO-8601 UTC string (RFC 3339 format).
  static String nowIsoUtc() {
    return nowUtc().toIso8601String();
  }

  /// Formats a given [DateTime] to a standardized ISO-8601 UTC string.
  static String formatIsoUtc(DateTime dateTime) {
    return dateTime.toUtc().toIso8601String();
  }

  /// Safely parses an ISO-8601 timestamp string into a UTC [DateTime].
  static DateTime parseIsoUtc(String isoString) {
    final parsed = DateTime.parse(isoString.trim());
    return parsed.toUtc();
  }
}

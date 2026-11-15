import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/features/analytics/infrastructure/analytics_dao.dart';

void main() {
  test('one-year muscle volume query stays under 15 ms at ten-year scale', () async {
    final db = AppDatabase.inMemory();
    addTearDown(db.close);
    final dao = AnalyticsDao(db);
    final now = DateTime.now().toUtc();
    final rows = <MuscleVolumeBreakdownsCompanion>[];

    // Model ten years of weekly summaries across 20 muscle groups.
    for (var week = 0; week < 520; week++) {
      final weekStart = now.subtract(Duration(days: week * 7));
      for (var muscle = 0; muscle < 20; muscle++) {
        rows.add(
          MuscleVolumeBreakdownsCompanion.insert(
            id: 'week-$week-muscle-$muscle',
            userId: 'benchmark-user',
            muscleGroup: 'group-$muscle',
            isoYear: 2017 + (520 - week) ~/ 52,
            isoWeek: (week % 52) + 1,
            weekStartDate: weekStart,
            totalVolumeKg: 12000.0 + muscle * 250.0,
            totalSets: 40 + muscle,
          ),
        );
      }
    }

    await db.batch((batch) {
      batch.insertAll(db.muscleVolumeBreakdowns, rows);
    });

    // Warm the query path, then collect enough samples to avoid relying on a
    // single scheduler or SQLite page-cache outlier.
    final initial = await dao
        .watchWeeklyMuscleVolume('benchmark-user', weeks: 52)
        .first;
    final samples = <int>[];
    for (var i = 0; i < 50; i++) {
      final stopwatch = Stopwatch()..start();
      await dao.watchWeeklyMuscleVolume('benchmark-user', weeks: 52).first;
      stopwatch.stop();
      samples.add(stopwatch.elapsedMicroseconds);
    }
    samples.sort();
    final medianMs = samples[samples.length ~/ 2] / 1000;
    final p95Ms = samples[(samples.length * 0.95).floor()] / 1000;

    // There are 20 summaries per week. The cutoff includes the boundary week.
    expect(initial.length, inInclusiveRange(1040, 1060));
    // The acceptance threshold is applied to the median to reduce timing
    // sensitivity while still catching a table scan or unbounded query.
    expect(medianMs, lessThan(15));
    // ignore: avoid_print
    print(
      'Analytics 52-week volume query: median ${medianMs.toStringAsFixed(2)} ms, '
      'p95 ${p95Ms.toStringAsFixed(2)} ms; ${initial.length} rows from '
      '${rows.length} stored rows.',
    );
  });
}

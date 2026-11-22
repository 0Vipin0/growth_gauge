import 'dart:convert';

import '../../../core/concurrency/isolate_runner.dart';
import '../../../core/database/app_database.dart';
import '../../catalog/domain/exercise.dart';
import '../../session/domain/workout_session.dart';

class ExportCsvUseCase({
  required final AppDatabase database,
  final IsolateRunner isolateRunner = const IsolateRunner(),
}) {
  final AppDatabase _database = database;
  final IsolateRunner _isolateRunner = isolateRunner;

  Future<String> call() async {
    final sessionRows = await (_database.select(
      _database.documents,
    )..where((row) => row.collection.equals('workout_sessions'))).get();
    final exerciseRows = await (_database.select(
      _database.documents,
    )..where((row) => row.collection.equals('exercises'))).get();

    final sessionsJson = sessionRows
        .map((r) => r.jsonData)
        .toList(growable: false);
    final exercisesJson = exerciseRows
        .map((r) => r.jsonData)
        .toList(growable: false);

    return await _isolateRunner.run(_generateCsvContent, (
      sessionsJson,
      exercisesJson,
    ));
  }
}

String _generateCsvContent((List<String>, List<String>) message) {
  final (sessionsJson, exercisesJson) = message;

  final exerciseNames = <String, String>{};
  for (final raw in exercisesJson) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        final exercise = Exercise.fromJson(decoded);
        exerciseNames[exercise.id] = exercise.name;
      }
    } catch (_) {
      // Ignore corrupted exercise documents in lookup
    }
  }

  final sessions = <WorkoutSession>[];
  for (final raw in sessionsJson) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        sessions.add(WorkoutSession.fromJson(decoded));
      }
    } catch (_) {
      // Ignore invalid session JSON
    }
  }

  sessions.sort((a, b) {
    final aDate = a.startedAt ?? a.createdAt;
    final bDate = b.startedAt ?? b.createdAt;
    return aDate.compareTo(bDate);
  });

  const headers = [
    'session_id',
    'session_date',
    'session_status',
    'template_name',
    'session_mood',
    'session_rpe',
    'session_notes',
    'block_name',
    'exercise_id',
    'exercise_name',
    'set_number',
    'set_type',
    'set_status',
    'target_weight_kg',
    'actual_weight_kg',
    'target_reps',
    'actual_reps',
    'target_duration_seconds',
    'actual_duration_seconds',
    'target_distance_meters',
    'actual_distance_meters',
    'target_calories',
    'actual_calories',
    'rpe',
    'rir',
    'planned_rest_seconds',
    'actual_rest_seconds',
    'set_notes',
  ];

  final buffer = StringBuffer();
  buffer.write('${headers.join(',')}\r\n');

  for (final session in sessions) {
    final sessionDate = (session.startedAt ?? session.createdAt)
        .toUtc()
        .toIso8601String();
    final sessionStatus = session.status.name;
    final templateName = session.templateName;
    final sessionMood = session.sessionMood?.name ?? '';
    final sessionRpe = session.sessionRpe?.toString() ?? '';
    final sessionNotes = session.sessionNotes ?? '';

    var hasSets = false;

    for (final block in session.blocks) {
      final blockName = block.name;
      for (final item in block.items) {
        final exerciseId = item.exerciseId;
        final exerciseName = exerciseNames[exerciseId] ?? exerciseId;

        for (final set in item.sets) {
          hasSets = true;
          final row = [
            session.id,
            sessionDate,
            sessionStatus,
            templateName,
            sessionMood,
            sessionRpe,
            sessionNotes,
            blockName,
            exerciseId,
            exerciseName,
            set.setNumber,
            set.setType.name,
            set.status.name,
            set.targetWeight ?? '',
            set.actualWeight ?? '',
            set.targetReps ?? '',
            set.actualReps ?? '',
            set.targetDurationSeconds ?? '',
            set.actualDurationSeconds ?? '',
            set.targetDistanceMeters ?? '',
            set.actualDistanceMeters ?? '',
            set.targetCalories ?? '',
            set.actualCalories ?? '',
            set.rpe ?? '',
            set.rir ?? '',
            set.plannedRestSeconds,
            set.actualRestSeconds ?? '',
            set.notes ?? '',
          ];
          buffer.write('${row.map(_escapeCsvField).join(',')}\r\n');
        }
      }
    }

    if (!hasSets) {
      final row = [
        session.id,
        sessionDate,
        sessionStatus,
        templateName,
        sessionMood,
        sessionRpe,
        sessionNotes,
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
      ];
      buffer.write('${row.map(_escapeCsvField).join(',')}\r\n');
    }
  }

  return buffer.toString();
}

String _escapeCsvField(Object? value) {
  if (value == null) return '';
  final str = value.toString();
  if (str.contains(',') ||
      str.contains('"') ||
      str.contains('\n') ||
      str.contains('\r')) {
    return '"${str.replaceAll('"', '""')}"';
  }
  return str;
}

import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/concurrency/isolate_runner.dart';
import '../../../core/database/app_database.dart';
import '../../../core/ids/unique_id.dart';
import '../../catalog/domain/exercise.dart';
import '../../session/domain/workout_session.dart';
import '../../template/domain/workout_template.dart';
import '../../template/domain/workout_template_revision.dart';
import '../../user/domain/equipment_inventory.dart';
import '../../user/domain/training_goal.dart';
import '../../user/domain/training_profile.dart';
import '../../user/domain/user_account.dart';
import '../../user/domain/user_measurement.dart';
import '../../user/domain/user_profile.dart';
import '../../user/domain/workout_preferences.dart';
import '../domain/conflict_strategy.dart';
import '../domain/export_envelope.dart';
import '../domain/import_report.dart';
import '../migration/checksum_validator.dart';
import '../migration/migration_registry.dart';

class ImportDataUseCase({
  required final AppDatabase database,
  required final MigrationRegistry migrations,
  final Future<int> Function()? rebuildAnalytics,
  final ChecksumValidator? checksumValidator,
  final IsolateRunner isolateRunner = const IsolateRunner(),
}) {
  final AppDatabase _database = database;
  final MigrationRegistry _migrations = migrations;
  final Future<int> Function()? _rebuildAnalytics = rebuildAnalytics;
  final ChecksumValidator _checksumValidator =
      checksumValidator ?? const ChecksumValidator();
  final IsolateRunner _isolateRunner = isolateRunner;

  Future<ImportReport> call(
    String json, {
    ConflictStrategy strategy = ConflictStrategy.keepExisting,
  }) async {
    final (raw, manifest) = await _isolateRunner.run(_decodeAndValidateImport, (
      json,
      _checksumValidator,
    ));
    final sourceVersion = manifest['formatVersion'];
    if (sourceVersion is! int || sourceVersion < 1) {
      throw const FormatException('Unsupported export format version.');
    }
    final migrated = _migrations.migrate(
      raw,
      fromVersion: sourceVersion,
      toVersion: 3,
    );
    final envelope = ExportEnvelope.fromJson({
      'manifest': manifest,
      ...migrated,
    });
    final documents = _prepareDocuments(envelope);
    var imported = 0;
    var skipped = 0;
    var overwritten = 0;
    var duplicated = 0;
    var changedSessions = false;

    await _database.transaction(() async {
      final duplicateIds = <String, String>{};
      if (strategy == ConflictStrategy.duplicateWithNewId) {
        for (final document in documents) {
          final existing =
              await (_database.select(_database.documents)..where(
                    (row) =>
                        row.collection.equals(document.collection) &
                        row.id.equals(document.id),
                  ))
                  .getSingleOrNull();
          if (existing == null) continue;
          duplicateIds.putIfAbsent(document.id, _newId);
          _collectDuplicateIds(document.data, duplicateIds);
        }
      }

      for (final document in documents) {
        final collection = document.collection;
        var id = document.id;
        final existing =
            await (_database.select(_database.documents)..where(
                  (row) =>
                      row.collection.equals(collection) & row.id.equals(id),
                ))
                .getSingleOrNull();
        if (existing != null) {
          switch (strategy) {
            case ConflictStrategy.keepExisting:
              skipped++;
              continue;
            case ConflictStrategy.overwrite:
              overwritten++;
            case ConflictStrategy.duplicateWithNewId:
              final remapped = _rewriteIds(document.data, duplicateIds);
              id = duplicateIds[document.id] ?? _newId();
              while (await (_database.select(_database.documents)..where(
                        (row) =>
                            row.collection.equals(collection) &
                            row.id.equals(id),
                      ))
                      .getSingleOrNull() !=
                  null) {
                id = _newId();
                duplicateIds[document.id] = id;
              }
              if (remapped.containsKey('id')) remapped['id'] = id;
              if (!remapped.containsKey('id') &&
                  remapped.containsKey('userId')) {
                remapped['userId'] = id;
              }
              document.data = remapped;
              duplicated++;
          }
        }
        final now = DateTime.now().toUtc();
        await _database
            .into(_database.documents)
            .insertOnConflictUpdate(
              DocumentsCompanion(
                collection: Value(collection),
                id: Value(id),
                jsonData: Value(jsonEncode(document.data)),
                schemaVersion: const Value(1),
                createdAt: Value(_date(document.data['createdAt']) ?? now),
                updatedAt: Value(_date(document.data['updatedAt']) ?? now),
              ),
            );
        imported++;
        if (collection == 'workout_sessions') changedSessions = true;
      }
    });

    final sessionsRebuilt = changedSessions
        ? await (_rebuildAnalytics?.call() ?? Future<int>.value(0))
        : 0;
    return ImportReport(
      imported: imported,
      skipped: skipped,
      overwritten: overwritten,
      duplicated: duplicated,
      analyticsSessionsRebuilt: sessionsRebuilt,
    );
  }

  List<_PortableDocument> _prepareDocuments(ExportEnvelope envelope) {
    const collectionNames = {
      'users': 'user_accounts',
      'profiles': 'profiles',
      'trainingProfiles': 'training_profiles',
      'preferences': 'preferences',
      'goals': 'goals',
      'equipment': 'equipment_inventories',
      'exercises': 'exercises',
      'templates': 'workout_templates',
      'revisions': 'workout_template_revisions',
      'sessions': 'workout_sessions',
      'measurements': 'measurements',
    };
    final result = <_PortableDocument>[];
    for (final entry in envelope.payload.entries) {
      final collection = collectionNames[entry.key]!;
      if (entry.key == 'equipment') {
        if (entry.value.every((item) => item.containsKey('ownedEquipment'))) {
          for (final raw in entry.value) {
            final data = Map<String, dynamic>.from(raw);
            _validateTypedDocument(entry.key, data);
            result.add(
              _PortableDocument(collection, _entityId(collection, data), data),
            );
          }
          continue;
        }
        final byUser = <String, List<Map<String, dynamic>>>{};
        for (final item in entry.value) {
          final userId = item['userId']?.toString() ?? '';
          if (userId.isNotEmpty) byUser.putIfAbsent(userId, () => []).add(item);
        }
        for (final items in byUser.values) {
          final data = _inventoryFromEquipmentRows(items);
          result.add(
            _PortableDocument(collection, _entityId(collection, data), data),
          );
        }
        continue;
      }
      for (final raw in entry.value) {
        final data = _normalizeExternalDocument(entry.key, raw);
        _validateTypedDocument(entry.key, data);
        final id = _entityId(collection, data);
        if (id.isEmpty) {
          throw FormatException('${entry.key} contains an item without an ID.');
        }
        result.add(_PortableDocument(collection, id, data));
      }
    }
    return result;
  }

  Map<String, dynamic> _normalizeExternalDocument(
    String key,
    Map<String, dynamic> input,
  ) {
    final value = Map<String, dynamic>.from(input);
    switch (key) {
      case 'profiles':
        final units = value.remove('unitPreferences');
        if (units is Map) {
          value['weightUnit'] = _weightUnit(units['weight']);
          value['distanceUnit'] = _distanceUnit(units['distance']);
          value['temperatureUnit'] = _temperatureUnit(units['temperature']);
        }
        value.putIfAbsent(
          'createdAt',
          () => _accountCreatedAt(value['userId']),
        );
        value.putIfAbsent('updatedAt', () => value['createdAt']);
      case 'trainingProfiles':
        value['preferredTrainingDays'] = _weekDays(
          value['preferredTrainingDays'],
        );
        value.putIfAbsent(
          'updatedAt',
          () => DateTime.now().toUtc().toIso8601String(),
        );
      case 'goals':
        value.putIfAbsent('currentValue', () => value['startValue'] ?? 0);
        value.putIfAbsent(
          'createdAt',
          () => value['startDate'] ?? DateTime.now().toUtc().toIso8601String(),
        );
      case 'exercises':
        if (value.containsKey('executionProfile')) {
          value['execution'] = value.remove('executionProfile');
        }
        if (value.containsKey('equipmentProfile')) {
          value['equipment'] = value.remove('equipmentProfile');
        }
        _normalizeMuscles(value);
        _normalizeExerciseEquipment(value);
      case 'revisions':
        _normalizeRevision(value);
      case 'sessions':
        _normalizeSession(value);
    }
    return value;
  }

  void _validateTypedDocument(String key, Map<String, dynamic> value) {
    switch (key) {
      case 'users':
        UserAccount.fromJson(value);
      case 'profiles':
        UserProfile.fromJson(value);
      case 'trainingProfiles':
        TrainingProfile.fromJson(value);
      case 'preferences':
        WorkoutPreferences.fromJson(value);
      case 'goals':
        TrainingGoal.fromJson(value);
      case 'equipment':
        EquipmentInventory.fromJson(value);
      case 'exercises':
        Exercise.fromJson(value);
      case 'templates':
        WorkoutTemplate.fromJson(value);
      case 'revisions':
        WorkoutTemplateRevision.fromJson(value);
      case 'sessions':
        WorkoutSession.fromJson(value);
      case 'measurements':
        UserMeasurement.fromJson(value);
    }
  }

  void _normalizeRevision(Map<String, dynamic> revision) {
    final blocks = revision['blocks'];
    if (blocks is! List) return;
    revision['blocks'] = blocks.map((rawBlock) {
      final block = Map<String, dynamic>.from(rawBlock as Map);
      final items = block['items'];
      if (items is List) {
        block['items'] = items.map((rawItem) {
          final item = Map<String, dynamic>.from(rawItem as Map);
          final targets = item.remove('targets') ?? item['targetSets'];
          if (targets is List) {
            item['targetSets'] = targets.map((rawTarget) {
              final target = Map<String, dynamic>.from(rawTarget as Map);
              final actual = target.remove('target');
              if (actual is Map) {
                target['targetWeight'] = actual['weight'];
                target['targetReps'] = actual['repetitions'] ?? actual['reps'];
                target['targetDurationSeconds'] = actual['durationSeconds'];
                target['targetDistanceMeters'] = actual['distanceMeters'];
                target['targetCalories'] = actual['calories'];
              }
              final intensity = target.remove('intensity');
              if (intensity is Map) {
                target['targetRpe'] = intensity['targetRpe'];
                target['targetRir'] = intensity['targetRir'];
              }
              final rest = target.remove('rest');
              if (rest is Map) {
                target['plannedRestSeconds'] = rest['plannedSeconds'];
              }
              target['id'] ??= '${item['id']}-set-${target['setNumber'] ?? 1}';
              return target;
            }).toList();
          }
          return item;
        }).toList();
      }
      return block;
    }).toList();
  }

  void _normalizeSession(Map<String, dynamic> session) {
    session.putIfAbsent(
      'createdAt',
      () => session['startedAt'] ?? DateTime.now().toUtc().toIso8601String(),
    );
    session.putIfAbsent('templateName', () => 'Imported workout');
    final rawSets = session.remove('executionSets');
    if (rawSets is! List) return;
    final grouped = <String, List<Map<String, dynamic>>>{};
    for (final raw in rawSets) {
      final set = Map<String, dynamic>.from(raw as Map);
      final exerciseId = set['exerciseId']?.toString() ?? 'unknown-exercise';
      final actual = set.remove('actual');
      if (actual is Map) {
        set['actualWeight'] = actual['weight'];
        set['actualReps'] = actual['repetitions'] ?? actual['reps'];
        set['actualDurationSeconds'] = actual['durationSeconds'];
        set['actualDistanceMeters'] = actual['distance'];
        set['actualCalories'] = actual['calories'];
      }
      final intensity = set.remove('intensity');
      if (intensity is Map) {
        set['rpe'] = intensity['rpe'];
        set['rir'] = intensity['rir'];
      }
      set['status'] = _sessionSetStatus(set['status']);
      set['setType'] = _upperEnum(set['setType']);
      grouped.putIfAbsent(exerciseId, () => []).add(set);
    }
    session['blocks'] = grouped.entries
        .map(
          (entry) => {
            'id': 'import-block-${entry.key}',
            'sourceTemplateBlockId': 'import-block-${entry.key}',
            'name': entry.key,
            'items': [
              {
                'id': 'import-item-${entry.key}',
                'sourceTemplateItemId': 'import-item-${entry.key}',
                'exerciseId': entry.key,
                'order': grouped.keys.toList().indexOf(entry.key),
                'sets': entry.value,
              },
            ],
          },
        )
        .toList();
    for (final key in ['status']) {
      session[key] = _sessionStatus(session[key]);
    }
    final interruptions = session['interruptions'];
    if (interruptions is List) {
      session['interruptions'] = interruptions.map((raw) {
        final interruption = Map<String, dynamic>.from(raw as Map);
        interruption['reason'] = _lowerEnum(interruption['reason']);
        return interruption;
      }).toList();
    }
    final rests = session['restIntervals'];
    if (rests is List) {
      session['restIntervals'] = rests.map((raw) {
        final rest = Map<String, dynamic>.from(raw as Map);
        final start =
            DateTime.tryParse(session['startedAt']?.toString() ?? '') ??
            DateTime.now().toUtc();
        rest['executionSetId'] = rest.remove('precedingSetId') ?? 'unknown-set';
        rest['startedAt'] ??= start.toIso8601String();
        rest['endedAt'] ??= start
            .add(
              Duration(
                seconds: (rest['actualDurationSeconds'] as num?)?.toInt() ?? 0,
              ),
            )
            .toIso8601String();
        rest.remove('reason');
        rest.remove('status');
        return rest;
      }).toList();
    }
  }

  Map<String, dynamic> _inventoryFromEquipmentRows(
    List<Map<String, dynamic>> rows,
  ) => {
    'userId': rows.first['userId'],
    'ownedEquipment': rows
        .where((row) => row['available'] != false)
        .map((row) => _equipmentEnum(row['equipmentType']))
        .toSet()
        .toList(),
    'updatedAt': DateTime.now().toUtc().toIso8601String(),
  };

  void _normalizeMuscles(Map<String, dynamic> exercise) {
    final classification = exercise['classification'];
    if (classification is! Map) return;
    for (final key in ['primaryMuscles', 'secondaryMuscles']) {
      final muscles = classification[key];
      if (muscles is List) {
        classification[key] = muscles.map((value) {
          final name = value.toString();
          return switch (name) {
            'QUADRICEPS' => 'QUADS',
            'HAMSTRINGS' => 'HAMSTRINGS',
            'LATISSIMUS_DORSI' => 'LATS',
            'RHOMBOIDS' => 'TRAPS',
            'ERECTOR_SPINAE' || 'LOWER_BACK' => 'LOWER_BACK',
            _ => name,
          };
        }).toList();
      }
    }
  }

  void _normalizeExerciseEquipment(Map<String, dynamic> exercise) {
    final equipment = exercise['equipment'];
    if (equipment is! Map) return;
    for (final key in ['requiredEquipment', 'optionalEquipment']) {
      final items = equipment[key];
      if (items is List) equipment[key] = items.map(_equipmentEnum).toList();
    }
  }

  String _weightUnit(Object? value) =>
      value?.toString().toLowerCase() == 'lb' ? 'pounds' : 'kilograms';
  String _distanceUnit(Object? value) =>
      switch (value?.toString().toLowerCase()) {
        'mi' || 'miles' => 'miles',
        'm' || 'meters' => 'meters',
        _ => 'kilometers',
      };
  String _temperatureUnit(Object? value) =>
      value?.toString().toLowerCase() == 'fahrenheit'
      ? 'fahrenheit'
      : 'celsius';
  String _equipmentEnum(Object? value) => switch (value?.toString()) {
    'SQUAT_RACK' || 'OLYMPIC_BAR' => 'BARBELL',
    'CABLE_MACHINE' => 'CABLE',
    'DUMBBELLS' => 'DUMBBELL',
    'PULLUP_BAR' => 'PULL_UP_BAR',
    final name => name ?? 'BODYWEIGHT',
  };
  List<int> _weekDays(Object? value) {
    if (value is! List) return const [];
    const days = {
      'MONDAY': 1,
      'TUESDAY': 2,
      'WEDNESDAY': 3,
      'THURSDAY': 4,
      'FRIDAY': 5,
      'SATURDAY': 6,
      'SUNDAY': 7,
    };
    return value
        .map((day) => day is num ? day.toInt() : days[day.toString()] ?? 1)
        .toList();
  }

  String _upperEnum(Object? value) {
    final text = value?.toString() ?? '';
    return text
        .replaceAllMapped(
          RegExp('([a-z0-9])([A-Z])'),
          (match) => '${match[1]}_${match[2]}',
        )
        .toUpperCase();
  }

  String _lowerEnum(Object? value) {
    final text = value?.toString().toLowerCase() ?? '';
    final camel = text
        .split('_')
        .asMap()
        .entries
        .map(
          (entry) => entry.key == 0
              ? entry.value
              : '${entry.value[0].toUpperCase()}${entry.value.substring(1)}',
        )
        .join();
    return camel;
  }

  String _sessionStatus(Object? value) => _lowerEnum(value);
  String _sessionSetStatus(Object? value) => _lowerEnum(value);
  DateTime? _date(Object? value) =>
      DateTime.tryParse(value?.toString() ?? '')?.toUtc();
  String _accountCreatedAt(Object? userId) =>
      DateTime.now().toUtc().toIso8601String();
  String _newId() => UniqueId.generate().value;
  String _entityId(String collection, Map<String, dynamic> value) =>
      (value['id'] ?? value['userId'] ?? '').toString();
  void _collectDuplicateIds(Object? value, Map<String, String> ids) {
    if (value is Map) {
      final id = value['id'];
      if (id is String && id.isNotEmpty) ids.putIfAbsent(id, _newId);
      for (final child in value.values) {
        _collectDuplicateIds(child, ids);
      }
    } else if (value is List) {
      for (final child in value) {
        _collectDuplicateIds(child, ids);
      }
    }
  }

  Map<String, dynamic> _rewriteIds(
    Map<String, dynamic> source,
    Map<String, String> ids,
  ) {
    Object? rewrite(Object? value) {
      if (value is Map) {
        return <String, dynamic>{
          for (final entry in value.entries)
            entry.key.toString(): rewrite(entry.value),
        };
      }
      if (value is List) return value.map(rewrite).toList();
      if (value is String) return ids[value] ?? value;
      return value;
    }

    return Map<String, dynamic>.from(rewrite(source)! as Map);
  }
}

class _PortableDocument(
  final String collection,
  final String id,
  Map<String, dynamic> data,
) {
  Map<String, dynamic> data = data;
}

(Map<String, dynamic>, Map<String, dynamic>) _decodeAndValidateImport(
  (String, ChecksumValidator) message,
) {
  final decoded = jsonDecode(message.$1);
  if (decoded is! Map<String, dynamic> || decoded['manifest'] is! Map) {
    throw const FormatException(
      'The selected file is not a Growth Gauge export.',
    );
  }
  final raw = Map<String, dynamic>.from(decoded);
  final manifest = Map<String, dynamic>.from(raw.remove('manifest') as Map);
  final expected = manifest['checksum']?.toString() ?? '';
  if (!message.$2.validates(raw, expected)) {
    throw const FormatException('Export checksum does not match its payload.');
  }
  return (raw, manifest);
}

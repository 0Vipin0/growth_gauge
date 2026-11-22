import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/features/catalog/domain/exercise.dart';
import 'package:growth_gauge/features/portability/application/export_csv_use_case.dart';
import 'package:growth_gauge/features/portability/application/export_data_use_case.dart';
import 'package:growth_gauge/features/portability/application/import_data_use_case.dart';
import 'package:growth_gauge/features/portability/application/portability_cubit.dart';
import 'package:growth_gauge/features/portability/domain/conflict_strategy.dart';
import 'package:growth_gauge/features/portability/domain/import_report.dart';
import 'package:growth_gauge/features/portability/infrastructure/file_storage_service.dart';
import 'package:growth_gauge/features/portability/migration/checksum_validator.dart';
import 'package:growth_gauge/features/portability/migration/migration_registry.dart';
import 'package:growth_gauge/features/portability/migration/migration_step.dart';
import 'package:growth_gauge/features/portability/migration/steps/migration_v1_to_v2.dart';
import 'package:growth_gauge/features/portability/migration/steps/migration_v2_to_v3.dart';
import 'package:growth_gauge/features/portability/presentation/screens/backup_restore_screen.dart';
import 'package:growth_gauge/features/session/domain/execution_set.dart';
import 'package:growth_gauge/features/session/domain/session_block.dart';
import 'package:growth_gauge/features/session/domain/session_enums.dart';
import 'package:growth_gauge/features/session/domain/session_item.dart';
import 'package:growth_gauge/features/session/domain/workout_session.dart';
import 'package:growth_gauge/features/template/domain/template_enums.dart';

void main() {
  group('Portability', () {
    late AppDatabase database;

    setUp(() => database = AppDatabase.inMemory());
    tearDown(() => database.close());

    test(
      'export includes every portable collection and a valid checksum',
      () async {
        final envelope = await ExportDataUseCase(database: database)();
        final json = envelope.toJson();
        final payload = Map<String, dynamic>.from(json)..remove('manifest');

        expect(
          payload.keys,
          containsAll([
            'users',
            'profiles',
            'trainingProfiles',
            'preferences',
            'goals',
            'equipment',
            'exercises',
            'templates',
            'revisions',
            'sessions',
            'measurements',
          ]),
        );
        expect(
          const ChecksumValidator().validates(
            payload,
            envelope.manifest.checksum,
          ),
          isTrue,
        );
      },
    );

    test('checksum detects payload changes', () {
      const validator = ChecksumValidator();
      final payload = <String, dynamic>{
        'users': [
          {'id': 'u1'},
        ],
      };
      final checksum = validator.checksum(payload);

      expect(validator.validates(payload, checksum), isTrue);
      expect(
        validator.validates({
          'users': [
            {'id': 'u2'},
          ],
        }, checksum),
        isFalse,
      );
    });

    test('migrations run sequentially from v1 to v3', () {
      final result = MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()])
          .migrate(
            {'users': <dynamic>[], 'templateRevisions': <dynamic>[]},
            fromVersion: 1,
            toVersion: 3,
          );

      expect(result['equipment'], isEmpty);
      expect(result['measurements'], isEmpty);
      expect(result['revisions'], isEmpty);
      expect(result.containsKey('templateRevisions'), isFalse);
    });

    test('migration registry rejects unsupported version paths', () {
      expect(
        () =>
            MigrationRegistry([])
                .migrate(const {}, fromVersion: 1, toVersion: 3),
        throwsFormatException,
      );
      expect(
        () =>
            MigrationRegistry([])
                .migrate(const {}, fromVersion: 4, toVersion: 3),
        throwsFormatException,
      );
      expect(
        () =>
            MigrationRegistry([_InvalidMigrationStep()])
                .migrate(const {}, fromVersion: 1, toVersion: 2),
        throwsFormatException,
      );
    });

    test(
      'import applies conflict strategies and keeps records valid',
      () async {
        const validator = ChecksumValidator();
        final payload = <String, dynamic>{
          'users': [
            {
              'id': 'user-1',
              'status': 'ACTIVE',
              'createdAt': '2026-01-01T00:00:00.000Z',
              'updatedAt': '2026-01-01T00:00:00.000Z',
            },
          ],
        };
        final input = jsonEncode({
          'manifest': {
            'formatVersion': 3,
            'exportedAt': '2026-01-01T00:00:00.000Z',
            'checksum': validator.checksum(payload),
          },
          ...payload,
        });
        final importer = ImportDataUseCase(
          database: database,
          migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
        );

        final first = await importer(input);
        final skipped = await importer(input);
        final copied = await importer(
          input,
          strategy: ConflictStrategy.duplicateWithNewId,
        );
        final updatedPayload = <String, dynamic>{
          'users': [
            {
              'id': 'user-1',
              'status': 'SUSPENDED',
              'createdAt': '2026-01-01T00:00:00.000Z',
              'updatedAt': '2026-01-02T00:00:00.000Z',
            },
          ],
        };
        final overwritten = await importer(
          jsonEncode({
            'manifest': {
              'formatVersion': 3,
              'exportedAt': '2026-01-02T00:00:00.000Z',
              'checksum': validator.checksum(updatedPayload),
            },
            ...updatedPayload,
          }),
          strategy: ConflictStrategy.overwrite,
        );
        final updatedDocument = await (database.select(
          database.documents,
        )..where((row) => row.id.equals('user-1'))).getSingle();

        expect(first.imported, 1);
        expect(skipped.skipped, 1);
        expect(copied.duplicated, 1);
        expect(overwritten.overwritten, 1);
        expect(
          (jsonDecode(updatedDocument.jsonData)
              as Map<String, dynamic>)['status'],
          'SUSPENDED',
        );
        expect(await database.select(database.documents).get(), hasLength(2));
      },
    );

    test(
      'imports typed equipment inventories as individual documents',
      () async {
        final payload = <String, dynamic>{
          'equipment': [
            {
              'userId': 'equipment-user',
              'ownedEquipment': ['DUMBBELL'],
              'updatedAt': '2026-01-01T00:00:00.000Z',
            },
          ],
        };
        final input = jsonEncode({
          'manifest': {
            'formatVersion': 3,
            'exportedAt': '2026-01-01T00:00:00.000Z',
            'checksum': const ChecksumValidator().checksum(payload),
          },
          ...payload,
        });
        final importer = ImportDataUseCase(
          database: database,
          migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
        );

        final report = await importer(input);
        final document = await database.select(database.documents).getSingle();

        expect(report.imported, 1);
        expect(document.collection, 'equipment_inventories');
        expect(document.id, 'equipment-user');
      },
    );

    test('tampered payload is rejected before writing documents', () async {
      const validator = ChecksumValidator();
      final payload = <String, dynamic>{'users': <dynamic>[]};
      final input = jsonEncode({
        'manifest': {
          'formatVersion': 3,
          'exportedAt': '2026-01-01T00:00:00.000Z',
          'checksum': validator.checksum(payload),
        },
        'users': [
          {
            'id': 'changed',
            'createdAt': '2026-01-01T00:00:00.000Z',
            'updatedAt': '2026-01-01T00:00:00.000Z',
          },
        ],
      });
      final importer = ImportDataUseCase(
        database: database,
        migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
      );

      await expectLater(importer(input), throwsFormatException);
      expect(await database.select(database.documents).get(), isEmpty);
    });

    test(
      'unsupported future export version is rejected before writing',
      () async {
        const validator = ChecksumValidator();
        final payload = <String, dynamic>{'users': <dynamic>[]};
        final input = jsonEncode({
          'manifest': {
            'formatVersion': 4,
            'exportedAt': '2026-01-01T00:00:00.000Z',
            'checksum': validator.checksum(payload),
          },
          ...payload,
        });
        final importer = ImportDataUseCase(
          database: database,
          migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
        );

        await expectLater(importer(input), throwsFormatException);
        expect(await database.select(database.documents).get(), isEmpty);
      },
    );

    test(
      'document with an empty owner ID is rejected before writing',
      () async {
        final payload = <String, dynamic>{
          'profiles': [
            {'userId': ''},
          ],
        };
        final input = jsonEncode({
          'manifest': {
            'formatVersion': 3,
            'exportedAt': '2026-01-01T00:00:00.000Z',
            'checksum': const ChecksumValidator().checksum(payload),
          },
          ...payload,
        });
        final importer = ImportDataUseCase(
          database: database,
          migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
        );

        await expectLater(importer(input), throwsFormatException);
        expect(await database.select(database.documents).get(), isEmpty);
      },
    );

    test(
      'invalid typed document rejects the whole import before writes',
      () async {
        const validator = ChecksumValidator();
        final payload = <String, dynamic>{
          'users': [
            {
              'id': 'valid-user',
              'status': 'ACTIVE',
              'createdAt': '2026-01-01T00:00:00.000Z',
              'updatedAt': '2026-01-01T00:00:00.000Z',
            },
          ],
          'profiles': [
            {'userId': 'valid-user', 'weightUnit': 'stones'},
          ],
        };
        final input = jsonEncode({
          'manifest': {
            'formatVersion': 3,
            'exportedAt': '2026-01-01T00:00:00.000Z',
            'checksum': validator.checksum(payload),
          },
          ...payload,
        });
        final importer = ImportDataUseCase(
          database: database,
          migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
        );

        await expectLater(
          importer(input),
          throwsA(
            anyOf(
              isA<FormatException>(),
              isA<TypeError>(),
              isA<ArgumentError>(),
            ),
          ),
        );
        expect(await database.select(database.documents).get(), isEmpty);
      },
    );

    test(
      'reference fixture imports after computing its example checksum',
      () async {
        final fixture = Map<String, dynamic>.from(
          jsonDecode(File('docs/persona-worked-xample.json').readAsStringSync())
              as Map,
        );
        final manifest = Map<String, dynamic>.from(fixture['manifest'] as Map);
        final payload = Map<String, dynamic>.from(fixture)..remove('manifest');
        manifest['checksum'] = const ChecksumValidator().checksum(payload);
        fixture['manifest'] = manifest;
        var rebuilt = false;
        final importer = ImportDataUseCase(
          database: database,
          migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
          rebuildAnalytics: () async {
            rebuilt = true;
            return 1;
          },
        );

        final report = await importer(jsonEncode(fixture));

        expect(report.imported, greaterThan(0));
        expect(rebuilt, isTrue);
        expect(report.analyticsSessionsRebuilt, 1);
        expect(
          await (database.select(
            database.documents,
          )..where((row) => row.collection.equals('user_accounts'))).get(),
          hasLength(1),
        );

        final duplicateReport = await importer(
          jsonEncode(fixture),
          strategy: ConflictStrategy.duplicateWithNewId,
        );
        final revisions =
            await (database.select(database.documents)..where(
                  (row) => row.collection.equals('workout_template_revisions'),
                ))
                .get();
        final sourceRevision = revisions.singleWhere(
          (row) => row.id == 'revision-002',
        );
        final duplicateRevision = revisions.firstWhere(
          (row) => !{'revision-001', 'revision-002'}.contains(row.id),
        );
        final sourceData =
            jsonDecode(sourceRevision.jsonData) as Map<String, dynamic>;
        final duplicateData =
            jsonDecode(duplicateRevision.jsonData) as Map<String, dynamic>;
        final sourceBlocks = sourceData['blocks'] as List<dynamic>;
        final duplicateBlocks = duplicateData['blocks'] as List<dynamic>;
        final sourceBlock = Map<String, dynamic>.from(
          sourceBlocks.first as Map,
        );
        final duplicateBlock = Map<String, dynamic>.from(
          duplicateBlocks.first as Map,
        );
        final sourceBlockId = sourceBlock['id'];
        final duplicateBlockId = duplicateBlock['id'];
        final templates = await (database.select(
          database.documents,
        )..where((row) => row.collection.equals('workout_templates'))).get();
        final copiedTemplate = templates.firstWhere(
          (row) => row.id != 'template-lower-A',
        );
        final copiedTemplateData =
            jsonDecode(copiedTemplate.jsonData) as Map<String, dynamic>;
        final users = await (database.select(
          database.documents,
        )..where((row) => row.collection.equals('user_accounts'))).get();
        final copiedUser = users.firstWhere((row) => row.id != 'user-001');
        final copiedRevision = revisions.firstWhere((row) {
          final data = jsonDecode(row.jsonData) as Map<String, dynamic>;
          return data['templateId'] == copiedTemplate.id &&
              data['revisionNumber'] == 2;
        });
        expect(duplicateReport.duplicated, greaterThan(0));
        expect(duplicateRevision.id, isNot(sourceRevision.id));
        expect(duplicateBlockId, isNot(sourceBlockId));
        expect(copiedTemplateData['currentRevisionId'], copiedRevision.id);
        expect(copiedTemplateData['createdById'], copiedUser.id);
      },
    );

    group('CSV Export', () {
      test('exports CSV headers when database contains no sessions', () async {
        final exporter = ExportCsvUseCase(database: database);
        final csv = await exporter();

        expect(
          csv,
          startsWith(
            'session_id,session_date,session_status,template_name,session_mood,'
            'session_rpe,session_notes,block_name,exercise_id,exercise_name,'
            'set_number,set_type,set_status,target_weight_kg,actual_weight_kg,'
            'target_reps,actual_reps,target_duration_seconds,actual_duration_seconds,'
            'target_distance_meters,actual_distance_meters,target_calories,'
            'actual_calories,rpe,rir,planned_rest_seconds,actual_rest_seconds,set_notes\r\n',
          ),
        );
      });

      test(
        'exports session with sets and resolves exercise catalog names',
        () async {
          final exercise = Exercise(
            id: 'ex-bench-01',
            name: 'Barbell Bench Press',
            createdAt: DateTime.parse('2026-01-01T00:00:00Z'),
            updatedAt: DateTime.parse('2026-01-01T00:00:00Z'),
          );
          await database
              .into(database.documents)
              .insert(
                DocumentsCompanion(
                  collection: const Value('exercises'),
                  id: const Value('ex-bench-01'),
                  jsonData: Value(jsonEncode(exercise.toJson())),
                  schemaVersion: const Value(1),
                  createdAt: Value(DateTime.parse('2026-01-01T00:00:00Z')),
                  updatedAt: Value(DateTime.parse('2026-01-01T00:00:00Z')),
                ),
              );

          final session = WorkoutSession(
            id: 'session-01',
            userId: 'user-01',
            templateId: 'tmpl-push',
            templateRevisionId: 'rev-01',
            templateName: 'Push Day A',
            status: SessionStatus.completed,
            startedAt: DateTime.parse('2026-01-02T10:00:00Z'),
            completedAt: DateTime.parse('2026-01-02T11:00:00Z'),
            createdAt: DateTime.parse('2026-01-02T10:00:00Z'),
            sessionMood: SessionMood.energetic,
            sessionRpe: 8.5,
            sessionNotes: 'Chest felt pumped',
            blocks: [
              SessionBlock(
                id: 'block-01',
                sourceTemplateBlockId: 'src-01',
                name: 'Chest Main',
                items: [
                  SessionItem(
                    id: 'item-01',
                    sourceTemplateItemId: 'src-item-01',
                    exerciseId: 'ex-bench-01',
                    order: 0,
                    sets: [
                      const ExecutionSet(
                        id: 'set-01',
                        setNumber: 1,
                        setType: SetType.warmup,
                        status: ExecutionSetStatus.completed,
                        targetWeight: 60.0,
                        actualWeight: 60.0,
                        targetReps: 10,
                        actualReps: 10,
                        plannedRestSeconds: 90,
                        actualRestSeconds: 85,
                      ),
                      const ExecutionSet(
                        id: 'set-02',
                        setNumber: 2,
                        setType: SetType.working,
                        status: ExecutionSetStatus.completed,
                        targetWeight: 100.0,
                        actualWeight: 100.0,
                        targetReps: 5,
                        actualReps: 5,
                        rpe: 8.5,
                        rir: 2,
                        plannedRestSeconds: 180,
                        actualRestSeconds: 175,
                        notes: 'Smooth lockouts',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
          await database
              .into(database.documents)
              .insert(
                DocumentsCompanion(
                  collection: const Value('workout_sessions'),
                  id: const Value('session-01'),
                  jsonData: Value(jsonEncode(session.toJson())),
                  schemaVersion: const Value(1),
                  createdAt: Value(DateTime.parse('2026-01-02T10:00:00Z')),
                  updatedAt: Value(DateTime.parse('2026-01-02T11:00:00Z')),
                ),
              );

          final exporter = ExportCsvUseCase(database: database);
          final csv = await exporter();

          expect(csv, contains('session-01'));
          expect(csv, contains('Push Day A'));
          expect(csv, contains('energetic'));
          expect(csv, contains('8.5'));
          expect(csv, contains('Chest felt pumped'));
          expect(csv, contains('Chest Main'));
          expect(csv, contains('ex-bench-01'));
          expect(csv, contains('Barbell Bench Press'));
          expect(csv, contains('warmup'));
          expect(csv, contains('working'));
          expect(csv, contains('100.0'));
          expect(csv, contains('Smooth lockouts'));
        },
      );

      test('exports session without sets as a session metadata row', () async {
        final session = WorkoutSession(
          id: 'session-empty',
          userId: 'user-01',
          templateId: 'tmpl-cardio',
          templateRevisionId: 'rev-cardio',
          templateName: 'Cardio Core',
          status: SessionStatus.draft,
          createdAt: DateTime.parse('2026-01-03T10:00:00Z'),
          blocks: const [],
        );
        await database
            .into(database.documents)
            .insert(
              DocumentsCompanion(
                collection: const Value('workout_sessions'),
                id: const Value('session-empty'),
                jsonData: Value(jsonEncode(session.toJson())),
                schemaVersion: const Value(1),
                createdAt: Value(DateTime.parse('2026-01-03T10:00:00Z')),
                updatedAt: Value(DateTime.parse('2026-01-03T10:00:00Z')),
              ),
            );

        final exporter = ExportCsvUseCase(database: database);
        final csv = await exporter();

        expect(csv, contains('session-empty'));
        expect(csv, contains('Cardio Core'));
        expect(csv, contains('draft'));
      });

      test('escapes commas, quotes, and newlines following RFC 4180', () async {
        final session = WorkoutSession(
          id: 'session-esc',
          userId: 'user-01',
          templateId: 'tmpl-esc',
          templateRevisionId: 'rev-esc',
          templateName: 'Heavy "Arms", Core & Back',
          status: SessionStatus.completed,
          createdAt: DateTime.parse('2026-01-04T10:00:00Z'),
          sessionNotes: 'Notes with, commas and "quotes"\nand newlines',
          blocks: [
            SessionBlock(
              id: 'block-esc',
              sourceTemplateBlockId: 'src-esc',
              name: 'Block 1, Primary',
              items: [
                const SessionItem(
                  id: 'item-esc',
                  sourceTemplateItemId: 'src-item-esc',
                  exerciseId: 'ex-unlisted',
                  order: 0,
                  sets: [
                    ExecutionSet(
                      id: 'set-esc',
                      setNumber: 1,
                      notes: 'Set note with "quotes" and, commas',
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
        await database
            .into(database.documents)
            .insert(
              DocumentsCompanion(
                collection: const Value('workout_sessions'),
                id: const Value('session-esc'),
                jsonData: Value(jsonEncode(session.toJson())),
                schemaVersion: const Value(1),
                createdAt: Value(DateTime.parse('2026-01-04T10:00:00Z')),
                updatedAt: Value(DateTime.parse('2026-01-04T10:00:00Z')),
              ),
            );

        final exporter = ExportCsvUseCase(database: database);
        final csv = await exporter();

        expect(csv, contains('"Heavy ""Arms"", Core & Back"'));
        expect(
          csv,
          contains('"Notes with, commas and ""quotes""\nand newlines"'),
        );
        expect(csv, contains('"Block 1, Primary"'));
        expect(csv, contains('"Set note with ""quotes"" and, commas"'));
        expect(csv, contains('ex-unlisted,ex-unlisted'));
      });
    });

    group('PortabilityCubit', () {
      late FakeFileStorageService fileStorage;
      late ExportDataUseCase exportData;
      late ExportCsvUseCase exportCsv;
      late ImportDataUseCase importData;

      setUp(() {
        fileStorage = FakeFileStorageService();
        exportData = ExportDataUseCase(database: database);
        exportCsv = ExportCsvUseCase(database: database);
        importData = ImportDataUseCase(
          database: database,
          migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
        );
      });

      test('exportBackup saves json and emits success message', () async {
        final cubit = PortabilityCubit(
          exportData: exportData,
          importData: importData,
          exportCsvUseCase: exportCsv,
          fileStorage: fileStorage,
        );

        await cubit.exportBackup();

        expect(fileStorage.savedJson, isNotNull);
        expect(cubit.state.isBusy, isFalse);
        expect(cubit.state.message, 'Backup saved.');
        expect(cubit.state.error, isNull);
        await cubit.close();
      });

      test(
        'exportBackup reports cancellation when picker returns null',
        () async {
          fileStorage.saveJsonResult = null;
          final cubit = PortabilityCubit(
            exportData: exportData,
            importData: importData,
            exportCsvUseCase: exportCsv,
            fileStorage: fileStorage,
          );

          await cubit.exportBackup();

          expect(cubit.state.isBusy, isFalse);
          expect(cubit.state.message, 'Export cancelled.');
          await cubit.close();
        },
      );

      test('exportBackup captures errors', () async {
        fileStorage.shouldThrowOnSave = true;
        final cubit = PortabilityCubit(
          exportData: exportData,
          importData: importData,
          exportCsvUseCase: exportCsv,
          fileStorage: fileStorage,
        );

        await cubit.exportBackup();

        expect(cubit.state.isBusy, isFalse);
        expect(cubit.state.error, contains('Could not export backup'));
        await cubit.close();
      });

      test('exportCsv saves csv and emits success message', () async {
        final cubit = PortabilityCubit(
          exportData: exportData,
          importData: importData,
          exportCsvUseCase: exportCsv,
          fileStorage: fileStorage,
        );

        await cubit.exportCsv();

        expect(fileStorage.savedCsv, isNotNull);
        expect(fileStorage.savedCsv, contains('session_id,session_date'));
        expect(cubit.state.isBusy, isFalse);
        expect(cubit.state.message, 'CSV export saved.');
        await cubit.close();
      });

      test('exportCsv reports cancellation when picker returns null', () async {
        fileStorage.saveCsvResult = null;
        final cubit = PortabilityCubit(
          exportData: exportData,
          importData: importData,
          exportCsvUseCase: exportCsv,
          fileStorage: fileStorage,
        );

        await cubit.exportCsv();

        expect(cubit.state.isBusy, isFalse);
        expect(cubit.state.message, 'CSV export cancelled.');
        await cubit.close();
      });

      test('importBackup completes with report on valid backup', () async {
        final envelope = await exportData();
        fileStorage.jsonToPick = jsonEncode(envelope.toJson());
        final cubit = PortabilityCubit(
          exportData: exportData,
          importData: importData,
          exportCsvUseCase: exportCsv,
          fileStorage: fileStorage,
        );

        await cubit.importBackup(ConflictStrategy.keepExisting);

        expect(cubit.state.isBusy, isFalse);
        expect(cubit.state.message, 'Import completed.');
        expect(cubit.state.report, isNotNull);
        await cubit.close();
      });

      test(
        'importBackup reports cancellation when picker returns null',
        () async {
          fileStorage.jsonToPick = null;
          final cubit = PortabilityCubit(
            exportData: exportData,
            importData: importData,
            exportCsvUseCase: exportCsv,
            fileStorage: fileStorage,
          );

          await cubit.importBackup(ConflictStrategy.keepExisting);

          expect(cubit.state.isBusy, isFalse);
          expect(cubit.state.message, 'Import cancelled.');
          await cubit.close();
        },
      );

      test('importBackup captures format error on corrupt json', () async {
        fileStorage.jsonToPick = '{not-valid-json';
        final cubit = PortabilityCubit(
          exportData: exportData,
          importData: importData,
          exportCsvUseCase: exportCsv,
          fileStorage: fileStorage,
        );

        await cubit.importBackup(ConflictStrategy.keepExisting);

        expect(cubit.state.isBusy, isFalse);
        expect(cubit.state.error, contains('Could not import backup'));
        await cubit.close();
      });
    });

    group('BackupRestoreScreen widget', () {
      late FakeFileStorageService fileStorage;
      late ExportDataUseCase exportData;
      late ExportCsvUseCase exportCsv;
      late ImportDataUseCase importData;
      late PortabilityCubit cubit;

      setUp(() {
        fileStorage = FakeFileStorageService();
        exportData = ExportDataUseCase(database: database);
        exportCsv = ExportCsvUseCase(database: database);
        importData = ImportDataUseCase(
          database: database,
          migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
        );
        cubit = PortabilityCubit(
          exportData: exportData,
          importData: importData,
          exportCsvUseCase: exportCsv,
          fileStorage: fileStorage,
        );
      });

      tearDown(() async => await cubit.close());

      testWidgets('renders all action buttons and description', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<PortabilityCubit>.value(
              value: cubit,
              child: const BackupRestoreScreen(),
            ),
          ),
        );

        expect(find.text('Backup and restore'), findsOneWidget);
        expect(find.text('Export backup'), findsOneWidget);
        expect(find.text('Export CSV'), findsOneWidget);
        expect(find.text('Import backup'), findsOneWidget);
        expect(
          find.textContaining(
            'export activity sessions to CSV for spreadsheets',
          ),
          findsOneWidget,
        );
      });

      testWidgets('tapping Export backup triggers cubit exportBackup', (
        tester,
      ) async {
        final trackingCubit = _TrackingPortabilityCubit(
          exportData: exportData,
          importData: importData,
          exportCsvUseCase: exportCsv,
          fileStorage: fileStorage,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<PortabilityCubit>.value(
              value: trackingCubit,
              child: const BackupRestoreScreen(),
            ),
          ),
        );

        await tester.tap(find.text('Export backup'));
        await tester.pump();

        expect(trackingCubit.exportBackupCalled, isTrue);
        await trackingCubit.close();
      });

      testWidgets('tapping Export CSV triggers cubit exportCsv', (
        tester,
      ) async {
        final trackingCubit = _TrackingPortabilityCubit(
          exportData: exportData,
          importData: importData,
          exportCsvUseCase: exportCsv,
          fileStorage: fileStorage,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<PortabilityCubit>.value(
              value: trackingCubit,
              child: const BackupRestoreScreen(),
            ),
          ),
        );

        await tester.tap(find.text('Export CSV'));
        await tester.pump();

        expect(trackingCubit.exportCsvCalled, isTrue);
        await trackingCubit.close();
      });

      testWidgets('renders progress indicator when busy', (tester) async {
        cubit.emit(const PortabilityState(isBusy: true));
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<PortabilityCubit>.value(
              value: cubit,
              child: const BackupRestoreScreen(),
            ),
          ),
        );

        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      });

      testWidgets('displays message when state has message', (tester) async {
        cubit.emit(const PortabilityState(message: 'Backup saved.'));
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<PortabilityCubit>.value(
              value: cubit,
              child: const BackupRestoreScreen(),
            ),
          ),
        );

        expect(find.text('Backup saved.'), findsOneWidget);
      });

      testWidgets('displays error when state has error', (tester) async {
        cubit.emit(
          const PortabilityState(error: 'Could not export backup: Disk full'),
        );
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<PortabilityCubit>.value(
              value: cubit,
              child: const BackupRestoreScreen(),
            ),
          ),
        );

        expect(find.text('Could not export backup: Disk full'), findsOneWidget);
      });

      testWidgets('displays import report summary when report present', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<PortabilityCubit>.value(
              value: cubit,
              child: const BackupRestoreScreen(),
            ),
          ),
        );

        cubit.emit(
          const PortabilityState(
            message: 'Import completed.',
            report: ImportReport(
              imported: 4,
              skipped: 1,
              overwritten: 2,
              duplicated: 0,
              analyticsSessionsRebuilt: 3,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Import Summary'), findsOneWidget);
        expect(
          find.text(
            'Imported 4, skipped 1, overwritten 2, duplicated 0. Analytics sessions rebuilt: 3.',
          ),
          findsOneWidget,
        );
      });
    });
  });
}

class FakeFileStorageService extends FileStorageService {
  String? jsonToPick;
  String? savedJson;
  String? savedCsv;
  Uri? saveJsonResult = Uri.parse('file:///backup.json');
  Uri? saveCsvResult = Uri.parse('file:///export.csv');
  bool shouldThrowOnSave = false;

  @override
  Future<String?> pickJson() async => jsonToPick;

  @override
  Future<Uri?> saveJson(
    String contents, {
    String fileName = 'growth-gauge-backup.json',
  }) async {
    if (shouldThrowOnSave) throw Exception('Disk full');
    savedJson = contents;
    return saveJsonResult;
  }

  @override
  Future<Uri?> saveCsv(
    String contents, {
    String fileName = 'growth-gauge-activities.csv',
  }) async {
    if (shouldThrowOnSave) throw Exception('Disk full');
    savedCsv = contents;
    return saveCsvResult;
  }
}

class _InvalidMigrationStep() implements MigrationStep {
  @override
  int get sourceVersion => 1;

  @override
  int get targetVersion => 1;

  @override
  Map<String, dynamic> migrate(Map<String, dynamic> payload) => payload;
}

class _TrackingPortabilityCubit extends PortabilityCubit {
  bool exportBackupCalled = false;
  bool exportCsvCalled = false;

  _TrackingPortabilityCubit({
    required super.exportData,
    required super.importData,
    super.exportCsvUseCase,
    required super.fileStorage,
  });

  @override
  Future<void> exportBackup() async {
    exportBackupCalled = true;
  }

  @override
  Future<void> exportCsv() async {
    exportCsvCalled = true;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/features/portability/application/export_data_use_case.dart';
import 'package:growth_gauge/features/portability/application/import_data_use_case.dart';
import 'package:growth_gauge/features/portability/domain/conflict_strategy.dart';
import 'package:growth_gauge/features/portability/migration/checksum_validator.dart';
import 'package:growth_gauge/features/portability/migration/migration_registry.dart';
import 'package:growth_gauge/features/portability/migration/steps/migration_v1_to_v2.dart';
import 'package:growth_gauge/features/portability/migration/steps/migration_v2_to_v3.dart';

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

        expect(first.imported, 1);
        expect(skipped.skipped, 1);
        expect(copied.duplicated, 1);
        expect(await database.select(database.documents).get(), hasLength(2));
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
  });
}

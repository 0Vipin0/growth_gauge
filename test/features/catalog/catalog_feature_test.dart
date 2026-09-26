import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/error/failures.dart';
import 'package:growth_gauge/features/catalog/application/catalog_use_cases.dart';
import 'package:growth_gauge/features/catalog/domain/exercise_enums.dart';
import 'package:growth_gauge/features/catalog/infrastructure/catalog_seeder.dart';
import 'package:growth_gauge/features/catalog/infrastructure/exercise_repository.dart';

void main() {
  group('Catalog feature', () {
    late AppDatabase database;
    late ExerciseRepository repository;
    late CatalogUseCases useCases;

    setUp(() {
      database = AppDatabase.inMemory();
      repository = ExerciseRepository(database);
      useCases = CatalogUseCases(repository);
    });

    tearDown(() async => database.close());

    test('seeds standard exercises once and leaves a non-empty catalog alone',
        () async {
      final catalogSeeder = CatalogSeeder(repository);

      final firstSeed = await catalogSeeder.seedIfEmpty();
      final secondSeed = await catalogSeeder.seedIfEmpty();
      final exercises = await repository.findAll();

      expect(firstSeed.dataOrNull, 7);
      expect(secondSeed.dataOrNull, 0);
      expect(exercises.dataOrNull, hasLength(7));
    });

    test('search matches exercise names and aliases case-insensitively',
        () async {
      await CatalogSeeder(repository).seedIfEmpty();

      final byName = await useCases.list(query: 'BARBELL BACK');
      final byAlias = await useCases.list(query: 'chin-up');

      expect(byName.dataOrNull?.map((exercise) => exercise.id),
          contains('exercise-squat-001'));
      expect(byAlias.dataOrNull?.map((exercise) => exercise.id),
          contains('exercise-pullup-001'));
    });

    test('classification and equipment filters narrow catalog results',
        () async {
      await CatalogSeeder(repository).seedIfEmpty();

      final result = await useCases.list(
        bodyRegion: BodyRegion.lowerBody,
        movementPattern: MovementPattern.hinge,
        equipment: EquipmentType.dumbbell,
      );

      expect(result.dataOrNull, hasLength(1));
      expect(result.dataOrNull!.single.id, 'exercise-rdl-001');
    });

    test('custom exercises are user-owned and can be archived', () async {
      final created = await useCases.createCustom(
        name: '  Single-leg bridge  ',
        description: 'A custom glute exercise',
        createdById: 'user-1',
      );
      final exercise = created.dataOrNull!;

      expect(exercise.name, 'Single-leg bridge');
      expect(exercise.sourceType, ExerciseSourceType.userCreated);
      expect(exercise.createdById, 'user-1');

      final archived = await useCases.archive(exercise.id);
      final found = await repository.findById(exercise.id);

      expect(archived.isSuccess, isTrue);
      expect(found.dataOrNull!.status, ExerciseStatus.archived);
    });

    test('rejects blank names and protects system exercises from archiving',
        () async {
      await CatalogSeeder(repository).seedIfEmpty();
      final blank =
          await useCases.createCustom(name: '  ', createdById: 'user-1');
      final archiveSystem = await useCases.archive('exercise-squat-001');

      expect(blank.errorOrNull, isA<ValidationFailure>());
      expect(archiveSystem.errorOrNull, isA<ConflictFailure>());
    });
  });
}

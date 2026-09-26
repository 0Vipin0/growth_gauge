import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/database/document_adapter.dart';
import 'package:growth_gauge/core/database/drift_document_store.dart';
import 'package:growth_gauge/core/error/failures.dart';

class SampleUser {
  final String id;
  final String name;
  final int age;

  SampleUser({required this.id, required this.name, required this.age});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SampleUser && id == other.id && name == other.name && age == other.age;

  @override
  int get hashCode => Object.hash(id, name, age);
}

class SampleUserAdapter extends DocumentAdapter<SampleUser> {
  @override
  String get collection => 'users';

  @override
  String getId(SampleUser entity) => entity.id;

  @override
  int get schemaVersion => 1;

  @override
  Map<String, dynamic> toJson(SampleUser entity) => {
        'id': entity.id,
        'name': entity.name,
        'age': entity.age,
      };

  @override
  SampleUser fromJson(Map<String, dynamic> json) => SampleUser(
        id: json['id'] as String,
        name: json['name'] as String,
        age: json['age'] as int,
      );
}

void main() {
  group('DriftDocumentStore', () {
    late AppDatabase db;
    late SampleUserAdapter adapter;
    late DriftDocumentStore<SampleUser> store;

    setUp(() {
      db = AppDatabase.inMemory();
      adapter = SampleUserAdapter();
      store = DriftDocumentStore<SampleUser>(database: db, adapter: adapter);
    });

    tearDown(() async {
      await db.close();
    });

    test('upsert and getById retrieve stored entity accurately', () async {
      final user = SampleUser(id: 'user-001', name: 'Sarah Mitchell', age: 30);

      final insertResult = await store.upsert(user);
      expect(insertResult.isSuccess, isTrue);

      final fetchResult = await store.getById('user-001');
      expect(fetchResult.isSuccess, isTrue);
      expect(fetchResult.dataOrNull, equals(user));
    });

    test('getById returns NotFoundFailure when entity does not exist', () async {
      final result = await store.getById('non-existent-id');
      expect(result.isError, isTrue);
      expect(result.errorOrNull, isA<NotFoundFailure>());
    });

    test('second upsert with same ID updates entity in-place without duplicating rows', () async {
      final userV1 = SampleUser(id: 'user-001', name: 'Sarah', age: 30);
      final userV2 = SampleUser(id: 'user-001', name: 'Sarah Mitchell', age: 31);

      await store.upsert(userV1);
      await store.upsert(userV2);

      final allResult = await store.getAll();
      expect(allResult.isSuccess, isTrue);
      expect(allResult.dataOrNull?.length, equals(1));
      expect(allResult.dataOrNull?.first.name, equals('Sarah Mitchell'));
      expect(allResult.dataOrNull?.first.age, equals(31));
    });

    test('getAll returns all entities in the collection', () async {
      await store.upsert(SampleUser(id: 'u1', name: 'User 1', age: 20));
      await store.upsert(SampleUser(id: 'u2', name: 'User 2', age: 25));
      await store.upsert(SampleUser(id: 'u3', name: 'User 3', age: 30));

      final result = await store.getAll();
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull?.length, equals(3));
    });

    test('delete removes entity from document store', () async {
      final user = SampleUser(id: 'user-delete', name: 'Delete Me', age: 40);
      await store.upsert(user);

      final deleteResult = await store.delete('user-delete');
      expect(deleteResult.isSuccess, isTrue);

      final getResult = await store.getById('user-delete');
      expect(getResult.isError, isTrue);
      expect(getResult.errorOrNull, isA<NotFoundFailure>());
    });

    test('watchAll emits reactive updates when documents are added', () async {
      final emissions = <List<SampleUser>>[];
      final subscription = store.watchAll().listen((list) => emissions.add(list));

      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(emissions.last, isEmpty);

      await store.upsert(SampleUser(id: 'watch-1', name: 'Watcher', age: 22));
      await Future<void>.delayed(const Duration(milliseconds: 30));

      expect(emissions.last.length, equals(1));
      expect(emissions.last.first.id, equals('watch-1'));

      await subscription.cancel();
    });

    test('clearCollection deletes all entities in collection', () async {
      await store.upsert(SampleUser(id: 'u1', name: 'User 1', age: 20));
      await store.upsert(SampleUser(id: 'u2', name: 'User 2', age: 25));

      final clearResult = await store.clearCollection();
      expect(clearResult.isSuccess, isTrue);

      final all = await store.getAll();
      expect(all.dataOrNull, isEmpty);
    });
  });
}

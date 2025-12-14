import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/models/user_profile.dart';
import 'package:growth_gauge/data/repositories/drift_user_profile_repository.dart';
import 'package:growth_gauge/data/services/persistence/app_database.dart';

void main() {
  test('DriftUserProfileRepository save and load profile', () async {
    final db = AppDatabase.inMemory();
    final repo = DriftUserProfileRepository(db);

    final profile = UserProfile.createEmpty().copyWith(fitnessScore: 88);

    await repo.saveProfile(profile);

    final loaded = await repo.loadProfile();
    expect(loaded, isNotNull);
    expect(loaded!.fitnessScore, 88);
  });
}

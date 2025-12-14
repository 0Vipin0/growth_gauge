import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/repositories/drift_user_profile_repository.dart';
import 'package:growth_gauge/data/services/persistence/app_database.dart';
import 'package:growth_gauge/features/profile/provider/user_profile_provider.dart';

void main() {
  test('UserProfileProvider loads profile from Drift repository', () async {
    final db = AppDatabase.inMemory();
    final repo = DriftUserProfileRepository(db);
    final provider = UserProfileProvider(repository: repo);

    await provider.loadInitialProfile();

    // Initially no profile in DB -> provider should create an empty profile
    expect(provider.currentUserProfile, isNotNull);

    // Save a change and ensure it persists via repo
    provider.setProfile(provider.currentUserProfile!.copyWith(fitnessScore: 42));
    await provider.saveProfile();

    final loaded = await repo.loadProfile();
    expect(loaded!.fitnessScore, 42);
  });
}

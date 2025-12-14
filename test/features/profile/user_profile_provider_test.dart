import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/profile/provider/user_profile_provider.dart';

void main() {
  test('UserProfileProvider initializes and loads profile', () async {
    final provider = UserProfileProvider();

    expect(provider.currentUserProfile, isNull);
    expect(provider.isLoading, isFalse);

    await provider.loadInitialProfile();

    expect(provider.currentUserProfile, isNotNull);
    expect(provider.isLoading, isFalse);
  });
}

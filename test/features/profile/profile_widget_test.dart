import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:growth_gauge/features/profile/widgets/profile_page.dart';
import 'package:growth_gauge/features/profile/provider/user_profile_provider.dart';
import 'package:growth_gauge/features/profile/model/user_profile.dart';

void main() {
  testWidgets('ProfilePage shows profile data', (WidgetTester tester) async {
    final provider = UserProfileProvider();
    await provider.loadInitialProfile();
    provider.setProfile(provider.currentUserProfile!.copyWith(fitnessScore: 55));

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<UserProfileProvider>.value(
          value: provider,
          child: const ProfilePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('Fitness Score'), findsOneWidget);
    expect(find.textContaining('55'), findsOneWidget);
  });
}

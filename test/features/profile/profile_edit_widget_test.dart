import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/ui/profile/provider/user_profile_provider.dart';
import 'package:growth_gauge/ui/profile/widgets/profile_edit_page.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('ProfileEditPage validates and saves data',
      (WidgetTester tester) async {
    final provider = UserProfileProvider();
    await provider.loadInitialProfile();

    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider<UserProfileProvider>.value(
          value: provider, child: const ProfileEditPage()),
    ));

    await tester.pumpAndSettle();

    // Enter valid values
    await tester.enterText(find.bySemanticsLabel('Age'), '29');
    await tester.enterText(find.bySemanticsLabel('Height (cm)'), '175');
    await tester.enterText(find.bySemanticsLabel('Weight (kg)'), '70');

    // Tap save
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(provider.currentUserProfile?.data?.age, 29);
    expect(provider.currentUserProfile?.data?.heightCm, 175);
    expect(provider.currentUserProfile?.data?.weightKg, 70);
  });
}

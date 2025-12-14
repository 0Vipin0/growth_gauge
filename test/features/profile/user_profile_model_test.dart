import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/profile/model/user_profile.dart';

void main() {
  test('UserProfile JSON serialization roundtrip', () {
    final profile = UserProfile(
      id: 'uuid-123',
      creationDate: DateTime.parse('2024-01-01T00:00:00Z'),
      fitnessScore: 75,
      data: FitnessData(age: 30, heightCm: 180.5, weightKg: 75.2, restingHeartRate: 60),
      assessment: AssessmentResult(bmi: 23.15, predictedMaxHeartRate: 190, fitnessScore: 75),
    );

    final json = profile.toJson();
    final restored = UserProfile.fromJson(json);

    expect(restored.id, profile.id);
    expect(restored.fitnessScore, profile.fitnessScore);
    expect(restored.data?.age, 30);
    expect(restored.assessment?.bmi, closeTo(23.15, 0.001));
  });
}

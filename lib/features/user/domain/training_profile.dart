import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_enums.dart';

part 'training_profile.freezed.dart';
part 'training_profile.g.dart';

/// User fitness background, preferred routine structure, and schedule.
@freezed
abstract class TrainingProfile with _$TrainingProfile {
  const factory({
    required String userId,
    @Default(TrainingExperience.intermediate)
    TrainingExperience trainingExperience,
    @Default('General Strength') String primaryTrainingStyle,
    @Default(60) int preferredSessionDurationMinutes,
    @Default([1, 3, 5]) List<int> preferredTrainingDays,
    @Default(ActivityLevel.moderatelyActive) ActivityLevel activityLevel,
    double? baselineHeightCm,
    double? baselineWeightKg,
    int? restingHeartRateBpm,
    @Default('') String injuriesAndLimitations,
    @Default('') String notes,
    required DateTime updatedAt,
  }) = _TrainingProfile;

  factory fromJson(Map<String, dynamic> json) =>
      _$TrainingProfileFromJson(json);
}

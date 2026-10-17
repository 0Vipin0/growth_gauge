import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_enums.dart';

part 'training_goal.freezed.dart';
part 'training_goal.g.dart';

/// User-defined training target with measurable start and target values.
@freezed
abstract class TrainingGoal with _$TrainingGoal {
  const factory({
    required String id,
    required String userId,
    required GoalType type,
    required String name,
    @Default('') String description,
    required double startValue,
    required double targetValue,
    required double currentValue,
    @Default('kg') String unit,
    required DateTime startDate,
    DateTime? targetDate,
    @Default(GoalStatus.active) GoalStatus status,
    required DateTime createdAt,
    DateTime? completedAt,
  }) = _TrainingGoal;

  factory fromJson(Map<String, dynamic> json) => _$TrainingGoalFromJson(json);
}

extension TrainingGoalX on TrainingGoal {
  /// Computes completion percentage from start to target value (0.0 to 1.0).
  double get progressPercent {
    final range = targetValue - startValue;
    if (range == 0) return currentValue >= targetValue ? 1.0 : 0.0;
    final progress = (currentValue - startValue) / range;
    return progress.clamp(0.0, 1.0);
  }

  /// Whether the goal is currently in active state.
  bool get isActive => status == GoalStatus.active;

  /// Whether the goal has been achieved.
  bool get isAchieved => status == GoalStatus.achieved;
}

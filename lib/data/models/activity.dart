import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

enum ActivityType { countBased, timeBased }

@freezed
class Activity with _$Activity {

  const factory Activity({
    required String id,
    required String name,
    String? description,
    required ActivityType type,
    required String unit,
    @Default(false) bool isFavorite,
    String? goalId,
    List<String>? tags,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'type': type.index,
  };
}

@freezed
class ActivityLog with _$ActivityLog {

  const factory ActivityLog({
    required String id,
    required String activityId,
    required DateTime timestamp,
    required double value,
    String? notes,
    int? rpe,
  }) = _ActivityLog;

  factory ActivityLog.fromJson(Map<String, dynamic> json) => _$ActivityLogFromJson(json);

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'timestamp': timestamp.toIso8601String(),
  };
}

@freezed
class Goal with _$Goal {
  // Static final for UUID generation
  static const _uuid = Uuid();

  // The primary factory constructor for the immutable data class
  const factory Goal({
    // Use @JsonKey for custom field names in JSON
    required String id,
    required String name,
    required String type,
    double? targetValue,
    double? currentValue,
    required DateTime startDate,
    DateTime? endDate,
  }) = _Goal;

  // Custom factory constructor to handle ID and StartDate generation/defaulting
  factory Goal.create({
    String? id,
    required String name,
    required String type,
    double? targetValue,
    double? currentValue,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Goal(
      // Generate ID if none is provided
      id: id ?? _uuid.v4(),
      name: name,
      type: type,
      targetValue: targetValue,
      currentValue: currentValue,
      // Use DateTime.now() if no startDate is provided
      startDate: startDate ?? DateTime.now(),
      endDate: endDate,
    );
  }

  // Factory constructor for deserialization from JSON
  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  // Custom toJson implementation to ensure DateTime fields are ISO 8601 strings
  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'startDate': startDate.toIso8601String(),
    'endDate': endDate?.toIso8601String(),
  };
}
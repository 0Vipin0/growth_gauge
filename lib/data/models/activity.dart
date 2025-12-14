import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';


// Interface to easily access common fields, if needed outside of the union
abstract class ActivityBase {
  String get id;
  String get name;
  String? get description;
  String get unit;
  bool get isFavorite;
  String? get goalId;
  List<String>? get tags;
}

@freezed
class Activity with _$Activity {
  // --- Common Fields ---
  @Implements<ActivityBase>()
  const factory Activity.countBased({
    required String id,
    required String name,
    String? description,
    required String unit,
    @Default(false) bool isFavorite,
    String? goalId,
    List<String>? tags,
    // --- Count-Specific Field ---
    required int count,
  }) = CountBasedActivity;

  @Implements<ActivityBase>()
  const factory Activity.timeBased({
    required String id,
    required String name,
    String? description,
    required String unit,
    @Default(false) bool isFavorite,
    String? goalId,
    List<String>? tags,
    // --- Time-Specific Field ---
    required Duration duration,
  }) = TimeBasedActivity;

  // Factory constructor for deserialization
  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
}

@freezed
class ActivityLog with _$ActivityLog {
  static const _uuid = Uuid();

  // Primary Constructor
  const factory ActivityLog({
    required String id,
    required String activityId, // Assuming you want 'activityId' for the field name
    required DateTime timestamp,
    required double value, // Can be count or duration (in seconds/minutes)
    String? notes,
    int? rpe,
  }) = _ActivityLog;

  // Custom factory constructor to handle ID and Timestamp generation/defaulting
  factory ActivityLog.create({
    String? id,
    required String activityId,
    DateTime? timestamp,
    required double value,
    String? notes,
    int? rpe,
  }) {
    return ActivityLog(
      id: id ?? _uuid.v4(),
      activityId: activityId,
      timestamp: timestamp ?? DateTime.now(),
      value: value,
      notes: notes,
      rpe: rpe,
    );
  }

  // Serialization
  factory ActivityLog.fromJson(Map<String, dynamic> json) => _$ActivityLogFromJson(json);

  // Custom toJson implementation to handle timestamp formatting
  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    // Override the generated serialization for timestamp to use ISO 8601 string
    'timestamp': timestamp.toIso8601String(),
  };
}

@freezed
class Goal with _$Goal {
  static const _uuid = Uuid();

  // Primary Constructor
  const factory Goal({
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
      id: id ?? _uuid.v4(),
      name: name,
      type: type,
      targetValue: targetValue,
      currentValue: currentValue,
      startDate: startDate ?? DateTime.now(),
      endDate: endDate,
    );
  }

  // Serialization
  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  // Custom toJson implementation to ensure DateTime fields are ISO 8601 strings
  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'start_date': startDate.toIso8601String(),
    'end_date': endDate?.toIso8601String(),
  };
}
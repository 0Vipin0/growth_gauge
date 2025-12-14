import 'package:uuid/uuid.dart';

enum ActivityType { countBased, timeBased }

class Activity {
  final String id;
  final String name;
  final String? description;
  final ActivityType type;
  final String unit;
  final bool isFavorite;
  final String? goalId;
  final List<String>? tags;

  Activity({
    String? id,
    required this.name,
    this.description,
    required this.type,
    required this.unit,
    this.isFavorite = false,
    this.goalId,
    this.tags,
  }) : id = id ?? const Uuid().v4();

  Activity copyWith({
    String? id,
    String? name,
    String? description,
    ActivityType? type,
    String? unit,
    bool? isFavorite,
    String? goalId,
    List<String>? tags,
  }) {
    return Activity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      isFavorite: isFavorite ?? this.isFavorite,
      goalId: goalId ?? this.goalId,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'type': type.index,
        'unit': unit,
        'is_favorite': isFavorite,
        'goal_id': goalId,
        'tags': tags,
      };

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json['id'] as String?,
        name: json['name'] as String,
        description: json['description'] as String?,
        type: ActivityType.values[json['type'] as int],
        unit: json['unit'] as String,
        isFavorite: json['is_favorite'] as bool? ?? false,
        goalId: json['goal_id'] as String?,
        tags:
            (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      );
}

class ActivityLog {
  final String id;
  final String activityId;
  final DateTime timestamp;
  final double value;
  final String? notes;
  final int? rpe;

  ActivityLog({
    String? id,
    required this.activityId,
    DateTime? timestamp,
    required this.value,
    this.notes,
    this.rpe,
  })  : id = id ?? const Uuid().v4(),
        timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'activity_id': activityId,
        'timestamp': timestamp.toIso8601String(),
        'value': value,
        'notes': notes,
        'rpe': rpe,
      };

  factory ActivityLog.fromJson(Map<String, dynamic> json) => ActivityLog(
        id: json['id'] as String?,
        activityId: json['activity_id'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
        value: (json['value'] as num).toDouble(),
        notes: json['notes'] as String?,
        rpe: json['rpe'] as int?,
      );
}

class Goal {
  final String id;
  final String name;
  final String type; // e.g., "Strength", "Endurance"
  final double? targetValue;
  final double? currentValue;
  final DateTime startDate;
  final DateTime? endDate;

  Goal({
    String? id,
    required this.name,
    required this.type,
    this.targetValue,
    this.currentValue,
    DateTime? startDate,
    this.endDate,
  })  : id = id ?? const Uuid().v4(),
        startDate = startDate ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'target_value': targetValue,
        'current_value': currentValue,
        'start_date': startDate.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
      };

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        id: json['id'] as String?,
        name: json['name'] as String,
        type: json['type'] as String,
        targetValue: (json['target_value'] as num?)?.toDouble(),
        currentValue: (json['current_value'] as num?)?.toDouble(),
        startDate: json['start_date'] == null
            ? null
            : DateTime.parse(json['start_date'] as String),
        endDate: json['end_date'] == null
            ? null
            : DateTime.parse(json['end_date'] as String),
      );
}

import 'package:uuid/uuid.dart';

class WorkoutTemplate {
  final String id;
  final String name;
  final String? description;
  final List<Map<String, dynamic>> steps; // simple JSON-serializable steps
  final DateTime createdAt;
  final DateTime? updatedAt;

  WorkoutTemplate({
    String? id,
    required this.name,
    this.description,
    List<Map<String, dynamic>>? steps,
    DateTime? createdAt,
    this.updatedAt,
  })  : id = id ?? const Uuid().v4(),
        steps = steps ?? <Map<String, dynamic>>[],
        createdAt = createdAt ?? DateTime.now();

  WorkoutTemplate copyWith({
    String? id,
    String? name,
    String? description,
    List<Map<String, dynamic>>? steps,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WorkoutTemplate(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      steps: steps ?? this.steps,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'steps': steps,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  factory WorkoutTemplate.fromJson(Map<String, dynamic> json) => WorkoutTemplate(
        id: json['id'] as String?,
        name: json['name'] as String,
        description: json['description'] as String?,
        steps: (json['steps'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [],
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      );
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingProfile _$TrainingProfileFromJson(Map<String, dynamic> json) =>
    _TrainingProfile(
      userId: json['userId'] as String,
      trainingExperience:
          $enumDecodeNullable(
            _$TrainingExperienceEnumMap,
            json['trainingExperience'],
          ) ??
          TrainingExperience.intermediate,
      primaryTrainingStyle:
          json['primaryTrainingStyle'] as String? ?? 'General Strength',
      preferredSessionDurationMinutes:
          (json['preferredSessionDurationMinutes'] as num?)?.toInt() ?? 60,
      preferredTrainingDays:
          (json['preferredTrainingDays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [1, 3, 5],
      notes: json['notes'] as String? ?? '',
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TrainingProfileToJson(
  _TrainingProfile instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'trainingExperience':
      _$TrainingExperienceEnumMap[instance.trainingExperience]!,
  'primaryTrainingStyle': instance.primaryTrainingStyle,
  'preferredSessionDurationMinutes': instance.preferredSessionDurationMinutes,
  'preferredTrainingDays': instance.preferredTrainingDays,
  'notes': instance.notes,
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$TrainingExperienceEnumMap = {
  TrainingExperience.beginner: 'BEGINNER',
  TrainingExperience.intermediate: 'INTERMEDIATE',
  TrainingExperience.advanced: 'ADVANCED',
};

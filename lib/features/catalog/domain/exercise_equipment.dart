import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_enums.dart';

part 'exercise_equipment.freezed.dart';
part 'exercise_equipment.g.dart';

@freezed
abstract class ExerciseEquipmentProfile with _$ExerciseEquipmentProfile {
  const factory({
    @Default([]) List<EquipmentType> requiredEquipment,
    @Default([]) List<EquipmentType> optionalEquipment,
  }) = _ExerciseEquipmentProfile;

  factory fromJson(Map<String, dynamic> json) =>
      _$ExerciseEquipmentProfileFromJson(json);
}

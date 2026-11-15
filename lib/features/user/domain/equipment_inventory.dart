import 'package:freezed_annotation/freezed_annotation.dart';

import '../../catalog/domain/exercise_enums.dart';

part 'equipment_inventory.freezed.dart';
part 'equipment_inventory.g.dart';

/// Equipment owned or accessible by the user, used to filter workouts and exercises.
@freezed
abstract class EquipmentInventory with _$EquipmentInventory {
  const factory({
    required String userId,
    @Default([]) List<EquipmentType> ownedEquipment,
    required DateTime updatedAt,
  }) = _EquipmentInventory;

  factory fromJson(Map<String, dynamic> json) =>
      _$EquipmentInventoryFromJson(json);
}

extension EquipmentInventoryX on EquipmentInventory {
  /// Checks whether the user owns or has access to [type].
  /// Bodyweight is always available.
  bool hasEquipment(EquipmentType type) {
    if (type == EquipmentType.bodyweight) return true;
    return ownedEquipment.contains(type);
  }

  /// Verifies if all equipment required for an exercise is available.
  bool canPerform(List<EquipmentType> required) {
    return required.every(hasEquipment);
  }
}

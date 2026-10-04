import 'package:freezed_annotation/freezed_annotation.dart';

import '../../template/domain/template_enums.dart';
import 'session_item.dart';

part 'session_block.freezed.dart';
part 'session_block.g.dart';

@freezed
abstract class SessionBlock with _$SessionBlock {
  const factory({
    required String id,
    required String sourceTemplateBlockId,
    required String name,
    @Default(WorkoutBlockType.standard) WorkoutBlockType type,
    @Default(1) int rounds,
    int? timeCapSeconds,
    int? transitionSeconds,
    @Default([]) List<SessionItem> items,
    String? notes,
  }) = _SessionBlock;

  factory fromJson(Map<String, dynamic> json) => _$SessionBlockFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

import 'execution_set.dart';

part 'session_item.freezed.dart';
part 'session_item.g.dart';

@freezed
abstract class SessionItem with _$SessionItem {
  const factory SessionItem({
    required String id,
    required String sourceTemplateItemId,
    required String exerciseId,
    required int order,
    @Default([]) List<ExecutionSet> sets,
    String? notes,
  }) = _SessionItem;

  factory SessionItem.fromJson(Map<String, dynamic> json) =>
      _$SessionItemFromJson(json);
}

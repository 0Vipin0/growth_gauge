import 'package:freezed_annotation/freezed_annotation.dart';

import 'session_enums.dart';

part 'session_interruption.freezed.dart';
part 'session_interruption.g.dart';

@freezed
abstract class SessionInterruption with _$SessionInterruption {
  const factory SessionInterruption({
    required String id,
    required DateTime startedAt,
    DateTime? endedAt,
    @Default(InterruptionReason.other) InterruptionReason reason,
    @Default(true) bool userInitiated,
  }) = _SessionInterruption;

  factory SessionInterruption.fromJson(Map<String, dynamic> json) =>
      _$SessionInterruptionFromJson(json);
}

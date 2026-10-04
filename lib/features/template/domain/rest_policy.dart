import 'package:freezed_annotation/freezed_annotation.dart';

part 'rest_policy.freezed.dart';
part 'rest_policy.g.dart';

@freezed
abstract class RestPolicy with _$RestPolicy {
  const factory RestPolicy({
    required String id,
    @Default('Standard Rest') String name,
    required int targetSeconds,
    int? minimumSeconds,
    int? maximumSeconds,
    @Default(true) bool autoStart,
    @Default(true) bool allowSkip,
    @Default(true) bool allowExtend,
  }) = _RestPolicy;

  factory RestPolicy.fromJson(Map<String, dynamic> json) =>
      _$RestPolicyFromJson(json);
}

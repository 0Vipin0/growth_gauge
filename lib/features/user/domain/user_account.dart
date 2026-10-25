import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_enums.dart';

part 'user_account.freezed.dart';
part 'user_account.g.dart';

/// The root user account entity representing identity and account status.
@freezed
abstract class UserAccount with _$UserAccount {
  const factory({
    required String id,
    @Default(AccountStatus.active) AccountStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? lastActiveAt,
  }) = _UserAccount;

  factory fromJson(Map<String, dynamic> json) => _$UserAccountFromJson(json);
}

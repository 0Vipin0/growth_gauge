import 'package:equatable/equatable.dart';

import '../config/config.dart';
import '../model/settings_model.dart';

class const SettingsState({
  final SettingsModel settings = const SettingsModel(
    themeName: AppThemeName.light,
  ),
  final bool isReady = false,
  final String? error,
}) extends Equatable {
  SettingsState copyWith({
    SettingsModel? settings,
    bool? isReady,
    String? error,
    bool clearError = false,
  }) => SettingsState(
    settings: settings ?? this.settings,
    isReady: isReady ?? this.isReady,
    error: clearError ? null : error ?? this.error,
  );

  @override
  List<Object?> get props => [settings, isReady, error];
}

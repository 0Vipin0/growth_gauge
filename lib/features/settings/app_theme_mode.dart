enum AppThemeMode {
  light,
  lightMediumContrast,
  lightHighContrast,
  dark,
  darkMediumContrast,
  darkHighContrast,
}

extension AppThemeModeLabelExtension on AppThemeMode {
  String getLabel() {
    switch (this) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.lightMediumContrast:
        return 'Light Medium Contrast';
      case AppThemeMode.lightHighContrast:
        return 'Light High Contrast';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.darkMediumContrast:
        return 'Dark Medium Contrast';
      case AppThemeMode.darkHighContrast:
        return 'Dark High Contrast';
      default:
        return name; // Fallback to enum name
    }
  }
}

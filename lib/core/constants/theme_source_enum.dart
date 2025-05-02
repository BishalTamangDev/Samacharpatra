// theme source
enum ThemeSourceEnum {
  system,
  custom;

  String get label {
    switch (this) {
      case ThemeSourceEnum.system:
        return 'system';
      case ThemeSourceEnum.custom:
        return 'custom';
    }
  }

  static ThemeSourceEnum fromLabel(String label) {
    switch (label.toLowerCase()) {
      case 'custom':
        return ThemeSourceEnum.custom;
      default:
        return ThemeSourceEnum.system;
    }
  }
}

/// Shared enumerations used across the app.

/// Supported interface languages (FR-LANG-01).
enum AppLanguage {
  nepali('ne', 'नेपाली', 'Nepali'),
  english('en', 'English', 'English');

  const AppLanguage(this.code, this.nativeName, this.englishName);

  /// BCP-47 language code.
  final String code;

  /// Language name in its own script (for display to the user).
  final String nativeName;

  /// English name (for developer reference / fallback).
  final String englishName;
}

/// Text size options for the accessibility setting (FR-ACC-05).
enum TextSizeOption {
  small,
  medium,
  large,
}

/// Overall screening session status.
enum ScreeningStatus {
  /// User has not started the screening.
  notStarted,

  /// Screening is in progress (some questions answered).
  inProgress,

  /// All questions answered or skipped; pathway generated.
  completed,
}

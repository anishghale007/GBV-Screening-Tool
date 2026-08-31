/// App-wide constants for the GBV Screening Tool.
///
/// Centralized place for magic numbers and configuration values
/// so they can be changed without hunting through code.
abstract final class AppConstants {
  /// Total number of screening questions.
  static const int totalQuestions = 15;

  /// Length of the user's PIN code.
  static const int pinLength = 4;

  /// Auto-lock timeout in seconds (NFR-SEC-04).
  static const int autoLockTimeoutSeconds = 30;

  /// Quick-exit maximum response time in milliseconds (NFR-REL-04).
  static const int quickExitMaxMs = 1000;

  /// Question transition animation duration in milliseconds (NFR-PERF-03).
  static const int questionTransitionMs = 300;

  /// Maximum audio start latency in milliseconds (NFR-PERF-02).
  static const int audioStartMaxMs = 1000;

  /// Encryption/decryption target latency in milliseconds (NFR-PERF-04).
  static const int cryptoMaxMs = 500;

  /// Minimum touch target size in logical pixels (WCAG 2.1 AA).
  static const double minTouchTarget = 48;

  /// Large touch target size for accessibility mode.
  static const double largeTouchTarget = 64;

  /// Secure storage key names.
  static const String userPinKey = 'user_pin';
  static const String duressPinKey = 'duress_pin';
  static const String encryptionKeyKey = 'encryption_key';
  static const String encryptionIvKey = 'encryption_iv';
  static const String hasPinSetupKey = 'has_pin_setup';
  static const String selectedLanguageKey = 'selected_language';
  static const String accessibilitySettingsKey = 'accessibility_settings';
  static const String screeningProgressKey = 'screening_progress';
}

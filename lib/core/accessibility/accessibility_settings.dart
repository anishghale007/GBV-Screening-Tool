import 'package:equatable/equatable.dart';

import 'package:gbv/core/enums/app_enums.dart';

/// Data model for all user-configurable accessibility settings.
///
/// Persisted to secure storage so settings survive app restarts.
/// Each toggle maps to a specific FR-ACC requirement.
class AccessibilitySettings extends Equatable {
  const AccessibilitySettings({
    this.textSize = TextSizeOption.medium,
    this.isHighContrastEnabled = false,
    this.isReduceAnimationsEnabled = false,
    this.isLargeTouchTargetsEnabled = false,
    this.isHapticFeedbackEnabled = false,
    this.isScreenReaderModeEnabled = false,
    this.isAdhdModeEnabled = false,
    this.isDyslexiaModeEnabled = false,
    this.isVisionImpairedModeEnabled = false,
    this.isLowLiteracyModeEnabled = false,
    this.isAutoPlayAudioEnabled = false,
  });

  /// Creates settings from a JSON map (for persistence).
  factory AccessibilitySettings.fromJson(Map<String, dynamic> json) {
    return AccessibilitySettings(
      textSize: TextSizeOption.values[json['textSize'] as int? ?? 1],
      isHighContrastEnabled: json['isHighContrastEnabled'] as bool? ?? false,
      isReduceAnimationsEnabled:
          json['isReduceAnimationsEnabled'] as bool? ?? false,
      isLargeTouchTargetsEnabled:
          json['isLargeTouchTargetsEnabled'] as bool? ?? false,
      isHapticFeedbackEnabled:
          json['isHapticFeedbackEnabled'] as bool? ?? false,
      isScreenReaderModeEnabled:
          json['isScreenReaderModeEnabled'] as bool? ?? false,
      isAdhdModeEnabled: json['isAdhdModeEnabled'] as bool? ?? false,
      isDyslexiaModeEnabled: json['isDyslexiaModeEnabled'] as bool? ?? false,
      isVisionImpairedModeEnabled:
          json['isVisionImpairedModeEnabled'] as bool? ?? false,
      isLowLiteracyModeEnabled:
          json['isLowLiteracyModeEnabled'] as bool? ?? false,
      isAutoPlayAudioEnabled:
          json['isAutoPlayAudioEnabled'] as bool? ?? false,
    );
  }

  // FR-ACC-05: Text size (small / medium / large)
  final TextSizeOption textSize;

  // FR-ACC-06: High-contrast display toggle
  final bool isHighContrastEnabled;

  // FR-ACC-07: Reduce animations toggle
  final bool isReduceAnimationsEnabled;

  // FR-ACC-10: Large touch-target mode
  final bool isLargeTouchTargetsEnabled;

  // FR-ACC-09: Haptic feedback toggle
  final bool isHapticFeedbackEnabled;

  // FR-ACC-08: Screen-reader-friendly labeling
  final bool isScreenReaderModeEnabled;

  // FR-ACC-01: ADHD-friendly mode
  final bool isAdhdModeEnabled;

  // FR-ACC-02: Dyslexia-friendly mode
  final bool isDyslexiaModeEnabled;

  // FR-ACC-03: Vision-impaired mode
  final bool isVisionImpairedModeEnabled;

  // FR-ACC-04: Low-literacy mode
  final bool isLowLiteracyModeEnabled;

  // FR-SCR-04: Auto-play audio on screen load
  final bool isAutoPlayAudioEnabled;

  /// Serializes settings to JSON for persistence.
  Map<String, dynamic> toJson() => {
        'textSize': textSize.index,
        'isHighContrastEnabled': isHighContrastEnabled,
        'isReduceAnimationsEnabled': isReduceAnimationsEnabled,
        'isLargeTouchTargetsEnabled': isLargeTouchTargetsEnabled,
        'isHapticFeedbackEnabled': isHapticFeedbackEnabled,
        'isScreenReaderModeEnabled': isScreenReaderModeEnabled,
        'isAdhdModeEnabled': isAdhdModeEnabled,
        'isDyslexiaModeEnabled': isDyslexiaModeEnabled,
        'isVisionImpairedModeEnabled': isVisionImpairedModeEnabled,
        'isLowLiteracyModeEnabled': isLowLiteracyModeEnabled,
        'isAutoPlayAudioEnabled': isAutoPlayAudioEnabled,
      };

  /// Creates a copy with updated fields.
  AccessibilitySettings copyWith({
    TextSizeOption? textSize,
    bool? isHighContrastEnabled,
    bool? isReduceAnimationsEnabled,
    bool? isLargeTouchTargetsEnabled,
    bool? isHapticFeedbackEnabled,
    bool? isScreenReaderModeEnabled,
    bool? isAdhdModeEnabled,
    bool? isDyslexiaModeEnabled,
    bool? isVisionImpairedModeEnabled,
    bool? isLowLiteracyModeEnabled,
    bool? isAutoPlayAudioEnabled,
  }) {
    return AccessibilitySettings(
      textSize: textSize ?? this.textSize,
      isHighContrastEnabled:
          isHighContrastEnabled ?? this.isHighContrastEnabled,
      isReduceAnimationsEnabled:
          isReduceAnimationsEnabled ?? this.isReduceAnimationsEnabled,
      isLargeTouchTargetsEnabled:
          isLargeTouchTargetsEnabled ?? this.isLargeTouchTargetsEnabled,
      isHapticFeedbackEnabled:
          isHapticFeedbackEnabled ?? this.isHapticFeedbackEnabled,
      isScreenReaderModeEnabled:
          isScreenReaderModeEnabled ?? this.isScreenReaderModeEnabled,
      isAdhdModeEnabled: isAdhdModeEnabled ?? this.isAdhdModeEnabled,
      isDyslexiaModeEnabled:
          isDyslexiaModeEnabled ?? this.isDyslexiaModeEnabled,
      isVisionImpairedModeEnabled:
          isVisionImpairedModeEnabled ?? this.isVisionImpairedModeEnabled,
      isLowLiteracyModeEnabled:
          isLowLiteracyModeEnabled ?? this.isLowLiteracyModeEnabled,
      isAutoPlayAudioEnabled:
          isAutoPlayAudioEnabled ?? this.isAutoPlayAudioEnabled,
    );
  }

  @override
  List<Object?> get props => [
        textSize,
        isHighContrastEnabled,
        isReduceAnimationsEnabled,
        isLargeTouchTargetsEnabled,
        isHapticFeedbackEnabled,
        isScreenReaderModeEnabled,
        isAdhdModeEnabled,
        isDyslexiaModeEnabled,
        isVisionImpairedModeEnabled,
        isLowLiteracyModeEnabled,
        isAutoPlayAudioEnabled,
      ];
}

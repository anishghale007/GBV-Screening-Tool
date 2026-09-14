import 'package:gbv/core/enums/app_enums.dart';

/// Base typography sizing constants and scale factor configurations.
///
/// Centralizes all font sizes across headings, body, labels, and captions,
/// allowing accessibility settings (Vision & Reading) to dynamically scale
/// typography across the entire application.
abstract final class AppFontSizes {
  // ── Scale Factors ──────────────────────────────────────────────────────────
  static const double smallScale = 0.85;
  static const double mediumScale = 1;
  static const double largeScale = 1.25;

  /// Returns scale factor for a given [TextSizeOption].
  static double getScale(TextSizeOption option) {
    return switch (option) {
      TextSizeOption.small => smallScale,
      TextSizeOption.medium => mediumScale,
      TextSizeOption.large => largeScale,
    };
  }

  // ── Headings & Titles ──────────────────────────────────────────────────────
  static const double displayLarge = 32;
  static const double headlineLarge = 26;
  static const double headlineMedium = 22;
  static const double headlineSmall = 18;
  static const double titleLarge = 20;
  static const double titleMedium = 16;
  static const double titleSmall = 14;

  // ── Body ───────────────────────────────────────────────────────────────────
  static const double bodyLarge = 16;
  static const double bodyMedium = 14;
  static const double bodySmall = 12;

  // ── Labels & Buttons ───────────────────────────────────────────────────────
  static const double labelLarge = 16;
  static const double labelMedium = 14;
  static const double labelSmall = 12;
  static const double button = 16;
  static const double caption = 12;

  /// Calculates the scaled font size for the given base size and text option.
  static double scaled(double baseSize, TextSizeOption option) {
    return baseSize * getScale(option);
  }
}

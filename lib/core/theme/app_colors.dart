import 'package:flutter/material.dart';

/// Centralized color palette for the GBV Screening Tool.
///
/// Designed to provide a calming, trustworthy, and accessible experience:
/// - Primary: #216A6B (Deep Teal)
/// - FAB / Action Accent: #1A5455 (Dark Teal)
/// - High-contrast (WCAG AAA-level contrast for vision-impaired mode)
abstract final class AppColors {
  // ── Primary palette ─────────────────────────────────────────────────
  static const Color primary = Color(0xFF216A6B);
  static const Color primaryLight = Color(0xFF4A8B8C);
  static const Color primaryDark = Color(0xFF1A5455);
  static const Color primaryContainer = Color(0xFFE2F1F1);
  static const Color onPrimaryContainer = Color(0xFF216A6B);

  // ── Secondary / FAB ─────────────────────────────────────────────────
  static const Color secondary = Color(0xFF1A5455);
  static const Color secondaryLight = Color(0xFFE2F1F1);
  static const Color secondaryDark = Color(0xFF123C3D);
  static const Color fabBackground = Color(0xFF1A5455);
  static const Color fabForeground = Color(0xFFFFFFFF);

  // ── Background & surface ────────────────────────────────────────────
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F5F5);

  // ── Borders ─────────────────────────────────────────────────────────
  static const Color border = Color(0xFFDDE6E6);
  static const Color borderSelected = Color(0xFF216A6B);

  // ── Text ────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF112323);
  static const Color textSecondary = Color(0xFF596B6B);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ── Semantic ────────────────────────────────────────────────────────
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color success = Color(0xFF43A047);
  static const Color info = Color(0xFF216A6B);

  // ── Quick-exit / safety ─────────────────────────────────────────────
  static const Color quickExit = Color(0xFFEF5350);
  static const Color quickExitPressed = Color(0xFFC62828);

  // ── High-contrast overrides ─────────────────────────────────────────
  static const Color hcBackground = Color(0xFF000000);
  static const Color hcSurface = Color(0xFF1A1A1A);
  static const Color hcTextPrimary = Color(0xFFFFFFFF);
  static const Color hcTextSecondary = Color(0xFFE0E0E0);
  static const Color hcPrimary = Color(0xFF80CBC4);
  static const Color hcBorder = Color(0xFFFFFFFF);
}

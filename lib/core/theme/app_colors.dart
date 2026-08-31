import 'package:flutter/material.dart';

/// Centralized color palette for the GBV Screening Tool.
///
/// Two palettes are provided:
/// - Default (soft, calming tones appropriate for a wellbeing app)
/// - High-contrast (WCAG AAA-level contrast for vision-impaired mode)
abstract final class AppColors {
  // ── Primary palette ─────────────────────────────────────────────────
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFFB8B4FF);
  static const Color primaryDark = Color(0xFF3D35CC);

  // ── Secondary / accent ──────────────────────────────────────────────
  static const Color secondary = Color(0xFF00BFA6);
  static const Color secondaryLight = Color(0xFF80DFCF);
  static const Color secondaryDark = Color(0xFF008C7A);

  // ── Background & surface ────────────────────────────────────────────
  static const Color background = Color(0xFFF8F7FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0EEF6);

  // ── Text ────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B6B80);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ── Semantic ────────────────────────────────────────────────────────
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color success = Color(0xFF43A047);
  static const Color info = Color(0xFF29B6F6);

  // ── Quick-exit / safety ─────────────────────────────────────────────
  static const Color quickExit = Color(0xFFEF5350);
  static const Color quickExitPressed = Color(0xFFC62828);

  // ── High-contrast overrides ─────────────────────────────────────────
  static const Color hcBackground = Color(0xFF000000);
  static const Color hcSurface = Color(0xFF1A1A1A);
  static const Color hcTextPrimary = Color(0xFFFFFFFF);
  static const Color hcTextSecondary = Color(0xFFE0E0E0);
  static const Color hcPrimary = Color(0xFF82B1FF);
  static const Color hcBorder = Color(0xFFFFFFFF);
}

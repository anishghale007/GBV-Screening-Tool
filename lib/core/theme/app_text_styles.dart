import 'package:flutter/material.dart';
import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/core/theme/app_font_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

/// Text style presets for the GBV Screening Tool.
///
/// Backed by [AppFontSizes] for consistent heading, body, and label sizing,
/// with support for standard Inter typography and dyslexia-friendly rendering.
abstract final class AppTextStyles {
  // ── Base styles using Google Fonts (Inter) ──────────────────────────
  static TextStyle get headlineLarge => GoogleFonts.inter(
    fontSize: AppFontSizes.headlineLarge,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get headlineMedium => GoogleFonts.inter(
    fontSize: AppFontSizes.headlineMedium,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static TextStyle get headlineSmall => GoogleFonts.inter(
    fontSize: AppFontSizes.headlineSmall,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get titleLarge => GoogleFonts.inter(
    fontSize: AppFontSizes.titleLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: AppFontSizes.bodyLarge,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: AppFontSizes.bodyMedium,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: AppFontSizes.bodySmall,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: AppFontSizes.labelLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: AppFontSizes.labelMedium,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: AppFontSizes.caption,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static TextStyle get button => GoogleFonts.inter(
    fontSize: AppFontSizes.button,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.3,
    height: 1.4,
  );

  // ── Dyslexia-friendly styles ────────────────────────────────────────
  static TextStyle _dyslexiaBase(double fontSize) => GoogleFonts.lexend(
    fontSize: fontSize,
    letterSpacing: 1.1,
    wordSpacing: 2,
    height: 1.6,
  );

  static TextStyle get dyslexiaBody => _dyslexiaBase(AppFontSizes.bodyLarge);
  static TextStyle get dyslexiaHeadline =>
      _dyslexiaBase(AppFontSizes.headlineMedium)
          .copyWith(fontWeight: FontWeight.w700);
  static TextStyle get dyslexiaLabel =>
      _dyslexiaBase(AppFontSizes.labelMedium)
          .copyWith(fontWeight: FontWeight.w600);

  /// Generates a TextTheme configured for either standard or dyslexia mode.
  static TextTheme createTextTheme({bool isDyslexia = false}) {
    if (isDyslexia) {
      return GoogleFonts.lexendTextTheme().copyWith(
        headlineLarge: dyslexiaHeadline.copyWith(
          fontSize: AppFontSizes.headlineLarge,
        ),
        headlineMedium: dyslexiaHeadline,
        headlineSmall: dyslexiaHeadline.copyWith(
          fontSize: AppFontSizes.headlineSmall,
        ),
        bodyLarge: dyslexiaBody,
        bodyMedium: dyslexiaBody.copyWith(fontSize: AppFontSizes.bodyMedium),
        bodySmall: dyslexiaBody.copyWith(fontSize: AppFontSizes.bodySmall),
        labelLarge: dyslexiaLabel.copyWith(fontSize: AppFontSizes.labelLarge),
        labelMedium: dyslexiaLabel,
      );
    }
    return GoogleFonts.interTextTheme();
  }
}

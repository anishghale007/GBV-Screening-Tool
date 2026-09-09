import 'package:flutter/material.dart';
import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

/// App-wide theme configuration matching the new design.
///
/// Provides [lightTheme] and [highContrastTheme] with WCAG-compliant
/// touch targets, consistent border radii, Inter typography,
/// and calming teal palette.
abstract final class AppTheme {
  /// Default light theme — #216A6B primary, Inter font, #1A5455 FAB.
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: GoogleFonts.interTextTheme(),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textOnPrimary,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceVariant,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.border,
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTextStyles.headlineSmall.copyWith(
        color: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.fabBackground,
      foregroundColor: AppColors.fabForeground,
      elevation: 2,
      shape: CircleBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        minimumSize: const Size(double.infinity, 52),
        padding: AppSpacing.paddingHorizontalLg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: AppTextStyles.button,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 52),
        padding: AppSpacing.paddingHorizontalLg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(
          AppSpacing.minTouchTarget,
          AppSpacing.minTouchTarget,
        ),
        textStyle: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: const Size(
          AppSpacing.minTouchTarget,
          AppSpacing.minTouchTarget,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border, width: 1.2),
      ),
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: AppSpacing.paddingMd,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.surfaceVariant,
      space: AppSpacing.lg,
      thickness: 1,
    ),
  );

  /// High-contrast theme for vision-impaired mode (FR-ACC-06).
  static ThemeData get highContrastTheme => lightTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.hcBackground,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.hcPrimary,
      onPrimary: AppColors.hcBackground,
      secondary: AppColors.hcPrimary,
      onSecondary: AppColors.hcBackground,
      surface: AppColors.hcSurface,
      onSurface: AppColors.hcTextPrimary,
      error: AppColors.error,
      onError: AppColors.hcTextPrimary,
    ),
    appBarTheme: lightTheme.appBarTheme.copyWith(
      backgroundColor: AppColors.hcSurface,
      foregroundColor: AppColors.hcTextPrimary,
      iconTheme: const IconThemeData(color: AppColors.hcTextPrimary),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.hcPrimary,
      foregroundColor: AppColors.hcBackground,
    ),
    cardTheme: lightTheme.cardTheme.copyWith(
      color: AppColors.hcSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.hcBorder, width: 2),
      ),
    ),
  );
}

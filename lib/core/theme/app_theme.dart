import 'package:flutter/material.dart';

import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';

/// App-wide theme configuration.
///
/// Provides [lightTheme] and [highContrastTheme] with WCAG-compliant
/// touch targets, consistent border radii, and calming color palette.
abstract final class AppTheme {
  /// Default light theme — calming, accessible.
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.headlineSmall.copyWith(
        color: AppColors.textPrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        minimumSize: const Size(double.infinity, AppSpacing.minTouchTarget),
        padding: AppSpacing.paddingHorizontalLg,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
        textStyle: AppTextStyles.button,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, AppSpacing.minTouchTarget),
        padding: AppSpacing.paddingHorizontalLg,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
        side: const BorderSide(color: AppColors.primary),
        textStyle: AppTextStyles.button,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(
          AppSpacing.minTouchTarget,
          AppSpacing.minTouchTarget,
        ),
        textStyle: AppTextStyles.labelLarge,
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
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: AppSpacing.borderRadiusMd),
      contentPadding: AppSpacing.paddingMd,
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
    colorScheme: const ColorScheme.dark(
      primary: AppColors.hcPrimary,
      surface: AppColors.hcSurface,
      error: AppColors.error,
    ),
    appBarTheme: lightTheme.appBarTheme.copyWith(
      backgroundColor: AppColors.hcSurface,
      foregroundColor: AppColors.hcTextPrimary,
    ),
    cardTheme: lightTheme.cardTheme.copyWith(color: AppColors.hcSurface),
  );
}

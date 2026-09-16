import 'package:flutter/material.dart';
import 'package:gbv/core/accessibility/accessibility_settings.dart';
import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

/// App-wide theme configuration matching the design.
///
/// Provides [lightTheme], [highContrastTheme], and [buildTheme] to
/// dynamically apply accessibility settings (high contrast, dyslexia fonts,
/// and larger touch targets).
abstract final class AppTheme {
  /// Default light theme — #216A6B primary, Inter font, #1A5455 FAB.
  static ThemeData get lightTheme => _createTheme(
    isHighContrast: false,
    isDyslexia: false,
    isLargeTouchTargets: false,
  );

  /// High-contrast theme for vision-impaired mode (FR-ACC-06).
  static ThemeData get highContrastTheme => _createTheme(
    isHighContrast: true,
    isDyslexia: false,
    isLargeTouchTargets: false,
  );

  /// Dynamically builds a [ThemeData] adapted to user [AccessibilitySettings].
  static ThemeData buildTheme(AccessibilitySettings settings) {
    return _createTheme(
      isHighContrast: settings.isHighContrastEnabled,
      isDyslexia: settings.isDyslexiaModeEnabled,
      isLargeTouchTargets: settings.isLargeTouchTargetsEnabled,
    );
  }

  static ThemeData _createTheme({
    required bool isHighContrast,
    required bool isDyslexia,
    required bool isLargeTouchTargets,
  }) {
    final textTheme = AppTextStyles.createTextTheme(isDyslexia: isDyslexia);
    final minTouchTarget = isLargeTouchTargets
        ? AppSpacing.largeTouchTarget
        : AppSpacing.minTouchTarget;
    final buttonHeight = isLargeTouchTargets ? 60.0 : 52.0;

    if (isHighContrast) {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: isDyslexia
            ? GoogleFonts.lexend().fontFamily
            : GoogleFonts.inter().fontFamily,
        textTheme: textTheme,
        scaffoldBackgroundColor: AppColors.hcBackground,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.hcPrimary,
          onPrimary: AppColors.hcBackground,
          primaryContainer: AppColors.hcSurface,
          onPrimaryContainer: AppColors.hcTextPrimary,
          secondary: AppColors.hcPrimary,
          onSecondary: AppColors.hcBackground,
          error: AppColors.error,
          onError: AppColors.hcTextPrimary,
          surface: AppColors.hcSurface,
          onSurface: AppColors.hcTextPrimary,
          surfaceContainerHighest: AppColors.hcSurface,
          onSurfaceVariant: AppColors.hcTextPrimary,
          outline: AppColors.hcBorder,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.hcSurface,
          foregroundColor: AppColors.hcTextPrimary,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.hcTextPrimary,
          ),
          iconTheme: const IconThemeData(color: AppColors.hcTextPrimary),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.hcPrimary,
          foregroundColor: AppColors.hcBackground,
          elevation: 2,
          shape: CircleBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.hcPrimary,
            foregroundColor: AppColors.hcBackground,
            minimumSize: Size(double.infinity, buttonHeight),
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
            foregroundColor: AppColors.hcPrimary,
            minimumSize: Size(double.infinity, buttonHeight),
            padding: AppSpacing.paddingHorizontalLg,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            side: const BorderSide(color: AppColors.hcPrimary, width: 2),
            textStyle: AppTextStyles.button.copyWith(
              color: AppColors.hcPrimary,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.hcPrimary,
            minimumSize: Size(minTouchTarget, minTouchTarget),
            textStyle: AppTextStyles.labelLarge.copyWith(
              color: AppColors.hcPrimary,
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            minimumSize: Size(minTouchTarget, minTouchTarget),
          ),
        ),
        cardTheme: CardThemeData(
          color: AppColors.hcSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.hcBorder, width: 2),
          ),
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.hcBorder,
          space: AppSpacing.lg,
          thickness: 1.5,
        ),
      );
    }

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: isDyslexia
          ? GoogleFonts.lexend().fontFamily
          : GoogleFonts.inter().fontFamily,
      textTheme: textTheme,
      splashColor: Colors.transparent,
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
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
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
          minimumSize: Size(double.infinity, buttonHeight),
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
          minimumSize: Size(double.infinity, buttonHeight),
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
          minimumSize: Size(minTouchTarget, minTouchTarget),
          textStyle: AppTextStyles.labelLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: Size(minTouchTarget, minTouchTarget),
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
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Text style presets for the GBV Screening Tool.
///
/// Provides three size tiers (small, medium, large) to support
/// the text-size accessibility setting (FR-ACC-05).
abstract final class AppTextStyles {
  // ── Scale factors for text size options ──────────────────────────────
  static const double smallScale = 0.85;
  static const double mediumScale = 1;
  static const double largeScale = 1.25;

  // ── Base styles using Google Fonts (Inter) ──────────────────────────
  static TextStyle get headlineLarge =>
      GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700, height: 1.3);

  static TextStyle get headlineMedium =>
      GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get headlineSmall =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, height: 1.4);

  static TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400, height: 1.6);

  static TextStyle get bodyMedium =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);

  static TextStyle get bodySmall =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);

  static TextStyle get labelLarge =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, height: 1.4);

  static TextStyle get labelMedium =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, height: 1.4);

  static TextStyle get caption =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, height: 1.4);

  static TextStyle get button => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ── Dyslexia-friendly variants ──────────────────────────────────────
  // Uses OpenDyslexic with increased letter/word spacing.
  static TextStyle _dyslexiaBase(double fontSize) => TextStyle(
    fontFamily: 'OpenDyslexic',
    fontSize: fontSize,
    letterSpacing: 1.2,
    wordSpacing: 3,
    height: 1.8,
  );

  static TextStyle get dyslexiaBody => _dyslexiaBase(16);
  static TextStyle get dyslexiaHeadline =>
      _dyslexiaBase(22).copyWith(fontWeight: FontWeight.w700);
  static TextStyle get dyslexiaLabel =>
      _dyslexiaBase(14).copyWith(fontWeight: FontWeight.w600);
}

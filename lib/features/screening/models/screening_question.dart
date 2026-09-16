import 'package:equatable/equatable.dart';
import 'package:gbv/core/enums/gender_option.dart';
import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';

/// Represents a selectable option within a screening question.
class ScreeningOption extends Equatable {
  const ScreeningOption({
    required this.id,
    required this.labelEn,
    required this.labelNe,
    this.points = 0,
  });

  /// Option identifier (e.g., 'opt_1', 'often').
  final String id;

  /// English label for display.
  final String labelEn;

  /// Nepali label for display.
  final String labelNe;

  /// Point weight awarded when this option is selected.
  final int points;

  /// Returns the localized label according to [languageCode].
  String label(String languageCode) => languageCode == 'ne' ? labelNe : labelEn;

  @override
  List<Object?> get props => [id, labelEn, labelNe, points];
}

/// Represents a screening question with its rules, scoring, and options.
class ScreeningQuestion extends Equatable {
  const ScreeningQuestion({
    required this.id,
    required this.textEn,
    required this.textNe,
    required this.options,
    this.typeId,
    this.level = QuestionLevel.gateway,
    this.unlockedByQId,
    this.unlockMinPoints,
    this.genderScope,
    this.genderTextEn,
    this.genderTextNe,
    this.preferNotToSayPoints = 0,
  });

  /// Unique Question Identifier (e.g., 'Q01', 'Q01_T1_G').
  final String id;

  /// Associated Incident Category (Type_ID).
  final IncidentCategory? typeId;

  /// Question Level: Gateway or Follow-up.
  final QuestionLevel level;

  /// For follow-ups: The Gateway Q_ID that unlocks this question.
  final String? unlockedByQId;

  /// Minimum points on the Gateway question required to unlock this follow-up.
  final int? unlockMinPoints;

  /// Optional Gender Scope filter/metadata.
  final GenderOption? genderScope;

  /// Default question text in English.
  final String textEn;

  /// Default question text in Nepali.
  final String textNe;

  /// Optional gender-specific English overrides (e.g., specific pronouns).
  final Map<GenderOption, String>? genderTextEn;

  /// Optional gender-specific Nepali overrides.
  final Map<GenderOption, String>? genderTextNe;

  /// List of selectable options.
  final List<ScreeningOption> options;

  /// Points awarded when user chooses "Prefer not to say" (default 0).
  final int preferNotToSayPoints;

  /// Returns the localized question text tailored for [languageCode]
  /// and optional [gender].
  String text(String languageCode, [GenderOption? gender]) {
    if (languageCode == 'ne') {
      if (gender != null &&
          genderTextNe != null &&
          genderTextNe!.containsKey(gender)) {
        return genderTextNe![gender]!;
      }
      return textNe;
    } else {
      if (gender != null &&
          genderTextEn != null &&
          genderTextEn!.containsKey(gender)) {
        return genderTextEn![gender]!;
      }
      return textEn;
    }
  }

  @override
  List<Object?> get props => [
    id,
    typeId,
    level,
    unlockedByQId,
    unlockMinPoints,
    genderScope,
    textEn,
    textNe,
    genderTextEn,
    genderTextNe,
    options,
    preferNotToSayPoints,
  ];
}

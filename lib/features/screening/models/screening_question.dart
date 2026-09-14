import 'package:equatable/equatable.dart';

/// Represents an option within a screening question.
class ScreeningOption extends Equatable {
  const ScreeningOption({
    required this.id,
    required this.labelEn,
    required this.labelNe,
  });

  final String id;
  final String labelEn;
  final String labelNe;

  /// Returns the localized label according to [languageCode].
  String label(String languageCode) => languageCode == 'ne' ? labelNe : labelEn;

  @override
  List<Object?> get props => [id, labelEn, labelNe];
}

/// Represents a single screening question with its options.
class ScreeningQuestion extends Equatable {
  const ScreeningQuestion({
    required this.id,
    required this.textEn,
    required this.textNe,
    required this.options,
  });

  final int id;
  final String textEn;
  final String textNe;
  final List<ScreeningOption> options;

  /// Returns the localized question text according to [languageCode].
  String text(String languageCode) => languageCode == 'ne' ? textNe : textEn;

  @override
  List<Object?> get props => [id, textEn, textNe, options];
}

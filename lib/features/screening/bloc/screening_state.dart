import 'package:equatable/equatable.dart';
import 'package:gbv/core/enums/gender_option.dart';
import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/risk_range.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

/// State representation for the dynamic screening assessment flow.
class ScreeningState extends Equatable {
  const ScreeningState({
    this.gender,
    this.selectedCategories = const [],
    this.activeQuestions = const [],
    this.answers = const {},
    this.questionScores = const {},
    this.currentIndex = 0,
    this.isCompleted = false,
  });

  /// User's chosen gender preference from Screen 1.
  final GenderOption? gender;

  /// Ordered list of selected incident categories from Screen 2.
  final List<IncidentCategory> selectedCategories;

  /// Dynamic list of active questions (Gateways + dynamically unlocked
  /// Follow-ups).
  final List<ScreeningQuestion> activeQuestions;

  /// Map of question ID to selected option ID or 'prefer_not_to_say'.
  final Map<String, String> answers;

  /// Map of question ID to awarded score points.
  final Map<String, int> questionScores;

  /// Current active question index in the questionnaire flow.
  final int currentIndex;

  /// Whether all active questions have been completed.
  final bool isCompleted;

  /// Total screening score accumulated across all answered questions.
  int get totalScore =>
      questionScores.values.fold(0, (sum, points) => sum + points);

  /// Number of total active questions.
  int get totalQuestions => activeQuestions.length;

  /// Maximum possible points obtainable for the currently active questions
  /// (3 points max per question).
  int get maxPossibleScore =>
      (activeQuestions.isNotEmpty ? activeQuestions.length : 1) * 3;

  /// Percentage score normalized to 0..100.
  double get scorePercentage =>
      maxPossibleScore > 0 ? (totalScore / maxPossibleScore) * 100.0 : 0.0;

  /// Integer percentage rounded and clamped to 0..100.
  int get scorePercentageInt => scorePercentage.round().clamp(0, 100);

  /// Matching [RiskRange] computed from the total score and active questions.
  RiskRange get riskRange =>
      RiskRange.fromScoreAndMax(totalScore, maxPossibleScore);

  /// Whether current question is answered.
  bool get isCurrentQuestionAnswered {
    if (activeQuestions.isEmpty || currentIndex >= activeQuestions.length) {
      return false;
    }
    final currentQ = activeQuestions[currentIndex];
    return answers.containsKey(currentQ.id);
  }

  ScreeningState copyWith({
    GenderOption? gender,
    List<IncidentCategory>? selectedCategories,
    List<ScreeningQuestion>? activeQuestions,
    Map<String, String>? answers,
    Map<String, int>? questionScores,
    int? currentIndex,
    bool? isCompleted,
  }) {
    return ScreeningState(
      gender: gender ?? this.gender,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      activeQuestions: activeQuestions ?? this.activeQuestions,
      answers: answers ?? this.answers,
      questionScores: questionScores ?? this.questionScores,
      currentIndex: currentIndex ?? this.currentIndex,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
    gender,
    selectedCategories,
    activeQuestions,
    answers,
    questionScores,
    currentIndex,
    isCompleted,
  ];
}

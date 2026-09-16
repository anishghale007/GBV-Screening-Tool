import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbv/core/enums/gender_option.dart';
import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/bloc/screening_state.dart';
import 'package:gbv/features/screening/data/screening_questions_data.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

/// Cubit managing the dynamic questionnaire engine, scoring, and navigation.
class ScreeningCubit extends Cubit<ScreeningState> {
  ScreeningCubit() : super(const ScreeningState());

  /// Maximum allowed questions (Gateways + Follow-ups).
  static const int maxQuestionsCap = 15;

  /// Sets the user's gender preference from Screen 1.
  void setGender(GenderOption gender) {
    emit(state.copyWith(gender: gender));
  }

  /// Sets the selected incident categories from Screen 2 and builds
  /// the initial Gateway questions queue in the order selected.
  void setSelectedCategories(
    List<IncidentCategory> categories, {
    bool isNotSure = false,
  }) {
    final List<ScreeningQuestion> initialQuestions;

    if (isNotSure || categories.isEmpty) {
      // Zero selections rule: Safe low-specificity generic defaults (Q02,03,05)
      initialQuestions = List<ScreeningQuestion>.from(defaultGenericQuestions);
    } else {
      // Gateway rule: Every selected Type_ID gets exactly one Gateway question
      initialQuestions = categories
          .map((cat) => gatewayQuestionsMap[cat])
          .whereType<ScreeningQuestion>()
          .toList();
    }

    emit(
      state.copyWith(
        selectedCategories: List.unmodifiable(categories),
        activeQuestions: initialQuestions,
        answers: {},
        questionScores: {},
        currentIndex: 0,
        isCompleted: false,
      ),
    );
  }

  /// Records an answer option selection for a question and evaluates
  /// dynamic follow-up triggers and hard cap enforcement.
  void answerQuestion(ScreeningQuestion question, ScreeningOption option) {
    final updatedAnswers = Map<String, String>.from(state.answers);
    final updatedScores = Map<String, int>.from(state.questionScores);

    updatedAnswers[question.id] = option.id;
    updatedScores[question.id] = option.points;

    final updatedQuestions =
        List<ScreeningQuestion>.from(state.activeQuestions);

    // Follow-up rule: If a Gateway answer scores >= its Unlock_Min_Points
    if (question.level == QuestionLevel.gateway && question.typeId != null) {
      final followUp = followUpQuestionsMap[question.typeId];
      final minPoints = question.unlockMinPoints ?? 2;

      if (followUp != null) {
        if (option.points >= minPoints) {
          // If follow-up is not already active, insert right after Gateway
          final currentPos = updatedQuestions.indexWhere(
            (q) => q.id == question.id,
          );
          final alreadyPresent = updatedQuestions.any(
            (q) => q.id == followUp.id,
          );

          if (!alreadyPresent && currentPos != -1) {
            updatedQuestions.insert(currentPos + 1, followUp);
            _enforceHardCap(updatedQuestions);
          }
        } else {
          // If score is below threshold, remove previously inserted follow-up
          updatedQuestions.removeWhere((q) => q.id == followUp.id);
          updatedAnswers.remove(followUp.id);
          updatedScores.remove(followUp.id);
        }
      }
    }

    emit(
      state.copyWith(
        activeQuestions: updatedQuestions,
        answers: updatedAnswers,
        questionScores: updatedScores,
      ),
    );
  }

  /// Skips a question by selecting "Prefer not to say".
  void skipQuestion(ScreeningQuestion question) {
    final updatedAnswers = Map<String, String>.from(state.answers);
    final updatedScores = Map<String, int>.from(state.questionScores);

    updatedAnswers[question.id] = 'prefer_not_to_say';
    updatedScores[question.id] = question.preferNotToSayPoints;

    final updatedQuestions =
        List<ScreeningQuestion>.from(state.activeQuestions);

    // If skipping a gateway, remove any previously unlocked follow-up
    if (question.level == QuestionLevel.gateway && question.typeId != null) {
      final followUp = followUpQuestionsMap[question.typeId];
      if (followUp != null) {
        updatedQuestions.removeWhere((q) => q.id == followUp.id);
        updatedAnswers.remove(followUp.id);
        updatedScores.remove(followUp.id);
      }
    }

    emit(
      state.copyWith(
        activeQuestions: updatedQuestions,
        answers: updatedAnswers,
        questionScores: updatedScores,
      ),
    );
  }

  /// Enforces the 15-question hard cap:
  /// Keep all Gateways (non-negotiable).
  /// Drop lowest-severity Follow-ups first (Threats/Offline dropped last).
  void _enforceHardCap(List<ScreeningQuestion> questions) {
    while (questions.length > maxQuestionsCap) {
      // Find all follow-up questions
      final followUps = questions
          .where((q) => q.level == QuestionLevel.followUp)
          .toList();
      if (followUps.isEmpty) break; // Cannot drop gateways

      // Find the follow-up with the lowest category severity rank
      followUps.sort((a, b) {
        final rankA =
            a.typeId != null ? (categorySeverityRank[a.typeId] ?? 0) : 0;
        final rankB =
            b.typeId != null ? (categorySeverityRank[b.typeId] ?? 0) : 0;
        return rankA.compareTo(rankB);
      });

      final lowestSeverityFollowUp = followUps.first;
      questions.removeWhere((q) => q.id == lowestSeverityFollowUp.id);
    }
  }

  /// Navigates to a specific question index.
  void setCurrentIndex(int index) {
    if (index >= 0 && index < state.activeQuestions.length) {
      emit(state.copyWith(currentIndex: index));
    }
  }

  /// Marks the screening as completed.
  void completeScreening() {
    emit(state.copyWith(isCompleted: true));
  }

  /// Resets the full screening state.
  void reset() {
    emit(const ScreeningState());
  }
}

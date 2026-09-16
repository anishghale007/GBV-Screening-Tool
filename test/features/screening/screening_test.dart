import 'package:flutter_test/flutter_test.dart';
import 'package:gbv/core/enums/gender_option.dart';
import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/bloc/screening_cubit.dart';
import 'package:gbv/features/screening/data/screening_questions_data.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

void main() {
  group('Screening Question Engine & Rules', () {
    late ScreeningCubit cubit;

    setUp(() {
      cubit = ScreeningCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('Zero selections: loads safe generic defaults (Q02, Q03, Q05)', () {
      cubit.setSelectedCategories([], isNotSure: true);
      expect(cubit.state.activeQuestions.length, 3);
      expect(
        cubit.state.activeQuestions.map((q) => q.id),
        containsAllInOrder(['Q02_T2_G', 'Q03_T3_G', 'Q05_T5_G']),
      );
    });

    test('Gateway rule: Loads exactly one gateway per selected type in order',
        () {
      cubit.setSelectedCategories([
        IncidentCategory.threats,
        IncidentCategory.stalking,
        IncidentCategory.leakedImages,
      ]);

      expect(cubit.state.activeQuestions.length, 3);
      expect(cubit.state.activeQuestions[0].id, 'Q07_T7_G');
      expect(cubit.state.activeQuestions[1].id, 'Q01_T1_G');
      expect(cubit.state.activeQuestions[2].id, 'Q04_T4_G');
      expect(
        cubit.state.activeQuestions.every(
          (q) => q.level == QuestionLevel.gateway,
        ),
        isTrue,
      );
    });

    test(
        'Follow-up rule: score >= unlockMinPoints dynamically splices '
        'follow-up', () {
      cubit.setSelectedCategories([IncidentCategory.stalking]);
      expect(cubit.state.activeQuestions.length, 1);
      final gateway = cubit.state.activeQuestions.first;

      // Select high score option (3 points >= 2 min points)
      final highOption = gateway.options.firstWhere((o) => o.points >= 2);
      cubit.answerQuestion(gateway, highOption);

      expect(cubit.state.activeQuestions.length, 2);
      expect(cubit.state.activeQuestions[0].id, 'Q01_T1_G');
      expect(cubit.state.activeQuestions[1].id, 'Q01_T1_F');
      expect(
        cubit.state.activeQuestions[1].level,
        QuestionLevel.followUp,
      );
    });

    test('Follow-up rule: score < unlockMinPoints removes previously added '
        'follow-up', () {
      cubit.setSelectedCategories([IncidentCategory.stalking]);
      final gateway = cubit.state.activeQuestions.first;

      // Select high score option first
      final highOption = gateway.options.firstWhere((o) => o.points >= 2);
      cubit.answerQuestion(gateway, highOption);
      expect(cubit.state.activeQuestions.length, 2);

      // Change answer to low score option (0 points)
      final lowOption = gateway.options.firstWhere((o) => o.points == 0);
      cubit.answerQuestion(gateway, lowOption);
      expect(cubit.state.activeQuestions.length, 1);
      expect(cubit.state.activeQuestions.first.id, 'Q01_T1_G');
    });

    test('Hard cap (15): drops lowest severity follow-up and protects Threats '
        'and Offline Escalation', () {
      // Select all 10 categories -> 10 Gateways
      final allCategories = IncidentCategory.values.toList();
      cubit.setSelectedCategories(allCategories);
      expect(cubit.state.activeQuestions.length, 10);

      // Trigger follow-up for all 10 categories
      for (final cat in allCategories) {
        final gateway = gatewayQuestionsMap[cat]!;
        final highOption = gateway.options.firstWhere((o) => o.points >= 2);
        cubit.answerQuestion(gateway, highOption);
      }

      // Total must never exceed 15
      expect(cubit.state.activeQuestions.length, 15);

      // All 10 gateways must be preserved
      final activeGateways = cubit.state.activeQuestions
          .where((q) => q.level == QuestionLevel.gateway)
          .toList();
      expect(activeGateways.length, 10);

      // Slander (T3, rank 1) follow-up should be dropped first
      final hasSlanderFollowUp = cubit.state.activeQuestions
          .any((q) => q.id == 'Q03_T3_F');
      expect(hasSlanderFollowUp, isFalse);

      // Threats (T7, rank 10) & Offline Escalation (T8, rank 9) follow-ups kept
      final hasThreatsFollowUp = cubit.state.activeQuestions
          .any((q) => q.id == 'Q07_T7_F');
      final hasOfflineFollowUp = cubit.state.activeQuestions
          .any((q) => q.id == 'Q08_T8_F');
      expect(hasThreatsFollowUp, isTrue);
      expect(hasOfflineFollowUp, isTrue);
    });

    test('Gender scope customization: adapts wording without altering '
        'question', () {
      const question = ScreeningQuestion(
        id: 'TEST_Q',
        textEn: 'Default English',
        textNe: 'Default Nepali',
        genderTextEn: {
          GenderOption.woman: 'English for Woman',
          GenderOption.man: 'English for Man',
        },
        genderTextNe: {
          GenderOption.woman: 'Nepali for Woman',
        },
        options: defaultFrequencyOptions,
      );

      expect(question.text('en', GenderOption.woman), 'English for Woman');
      expect(question.text('en', GenderOption.man), 'English for Man');
      expect(question.text('en', GenderOption.nonBinary), 'Default English');
      expect(question.text('ne', GenderOption.woman), 'Nepali for Woman');
      expect(question.text('ne', GenderOption.man), 'Default Nepali');
    });
  });
}

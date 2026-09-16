import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbv/core/enums/risk_range.dart';
import 'package:gbv/features/screening/bloc/screening_cubit.dart';

void main() {
  group('RiskRange Classification & Thresholds', () {
    test('Percentage mapping matches expected design categories', () {
      expect(RiskRange.fromPercentage(0), RiskRange.low);
      expect(RiskRange.fromPercentage(15), RiskRange.low);
      expect(RiskRange.fromPercentage(29), RiskRange.low);

      expect(RiskRange.fromPercentage(30), RiskRange.moderate);
      expect(RiskRange.fromPercentage(50), RiskRange.moderate);
      expect(RiskRange.fromPercentage(59), RiskRange.moderate);

      expect(RiskRange.fromPercentage(60), RiskRange.high);
      expect(RiskRange.fromPercentage(80), RiskRange.high);
      expect(RiskRange.fromPercentage(84), RiskRange.high);

      expect(RiskRange.fromPercentage(85), RiskRange.severe);
      expect(RiskRange.fromPercentage(98), RiskRange.severe);
      expect(RiskRange.fromPercentage(100), RiskRange.severe);
    });

    test('Score and Max Score calculation produces accurate RiskRange', () {
      // 15 total max points (5 questions)
      // 3 points = 20% -> Low
      expect(RiskRange.fromScoreAndMax(3, 15), RiskRange.low);
      // 7 points = 46.7% -> Moderate
      expect(RiskRange.fromScoreAndMax(7, 15), RiskRange.moderate);
      // 12 points = 80.0% -> High concern
      expect(RiskRange.fromScoreAndMax(12, 15), RiskRange.high);
      // 15 points = 100.0% -> Severe / urgent
      expect(RiskRange.fromScoreAndMax(15, 15), RiskRange.severe);
    });

    test('RiskRange contains designated colors and badge labels', () {
      expect(RiskRange.low.badgeLabel, 'Low');
      expect(RiskRange.low.color, const Color(0xFF216A6B));

      expect(RiskRange.moderate.badgeLabel, 'Moderate');
      expect(RiskRange.moderate.color, const Color(0xFFF59E0B));

      expect(RiskRange.high.badgeLabel, 'High concern');
      expect(RiskRange.high.color, const Color(0xFFDC2626));

      expect(RiskRange.severe.badgeLabel, 'Severe/Urgent');
      expect(RiskRange.severe.color, const Color(0xFFB91C1C));
    });

    test('ScreeningState score percentage calculates correctly', () {
      final cubit = ScreeningCubit()
        ..setSelectedCategories([], isNotSure: true);

      // Generic questions default: 3 questions = max 9 points
      expect(cubit.state.activeQuestions.length, 3);
      expect(cubit.state.maxPossibleScore, 9);
      expect(cubit.state.totalScore, 0);
      expect(cubit.state.scorePercentageInt, 0);
      expect(cubit.state.riskRange, RiskRange.low);

      // Answer first question with max points (3 points).
      // Dynamically splices a follow-up question -> 4 questions (max 12 pts).
      final q0 = cubit.state.activeQuestions[0];
      final opt3 = q0.options.firstWhere((o) => o.points == 3);
      cubit.answerQuestion(q0, opt3);

      expect(cubit.state.activeQuestions.length, 4);
      expect(cubit.state.maxPossibleScore, 12);
      expect(cubit.state.totalScore, 3);
      // 3 / 12 = 25% -> Low concern
      expect(cubit.state.scorePercentageInt, 25);
      expect(cubit.state.riskRange, RiskRange.low);

      cubit.close();
    });
  });
}

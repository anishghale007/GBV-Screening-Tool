import 'package:flutter/material.dart';

/// Risk range categories for the GBV screening assessment.
enum RiskRange {
  low(
    id: 'R1',
    label: 'Low concern',
    badgeLabel: 'Low',
    minScore: 0,
    maxScore: 4,
    minPercentage: 0,
    maxPercentage: 29,
    color: Color(0xFF216A6B),
    backgroundColor: Color(0xFFE8F5F5),
    borderColor: Color(0xFF216A6B),
    meaning:
        'Your safety and peace of mind are critical. Based on your answers, '
        'there are low indicators of risk at this time.',
  ),
  moderate(
    id: 'R2',
    label: 'Moderate concern',
    badgeLabel: 'Moderate',
    minScore: 5,
    maxScore: 9,
    minPercentage: 30,
    maxPercentage: 59,
    color: Color(0xFFF59E0B),
    backgroundColor: Color(0xFFFFFBEB),
    borderColor: Color(0xFFF59E0B),
    meaning:
        'Your safety and peace of mind are critical. Based on your answers, '
        'there are indicators of moderate concern that may require attention.',
  ),
  high(
    id: 'R3',
    label: 'High concern',
    badgeLabel: 'High concern',
    minScore: 10,
    maxScore: 14,
    minPercentage: 60,
    maxPercentage: 84,
    color: Color(0xFFDC2626),
    backgroundColor: Color(0xFFFEE2E2),
    borderColor: Color(0xFFEF4444),
    meaning:
        'Your safety and peace of mind are critical. Based on your answers, '
        'there are indicators of high verbal/emotional pressure and financial control.',
  ),
  severe(
    id: 'R4',
    label: 'Severe / urgent',
    badgeLabel: 'Severe/Urgent',
    minScore: 15,
    maxScore: 100,
    minPercentage: 85,
    maxPercentage: 100,
    color: Color(0xFFB91C1C),
    backgroundColor: Color(0xFFFEE2E2),
    borderColor: Color(0xFFDC2626),
    meaning:
        'Your safety and peace of mind are critical. Based on your '
        'answers, there are indicators of severe risk, direct threat, '
        'or urgent escalation.',
  );

  const RiskRange({
    required this.id,
    required this.label,
    required this.badgeLabel,
    required this.minScore,
    required this.maxScore,
    required this.minPercentage,
    required this.maxPercentage,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    required this.meaning,
  });

  final String id;
  final String label;
  final String badgeLabel;
  final int minScore;
  final int maxScore;
  final int minPercentage;
  final int maxPercentage;
  final Color color;
  final Color backgroundColor;
  final Color borderColor;
  final String meaning;

  /// Returns the matching [RiskRange] for a given total score.
  /// Falls back to [RiskRange.severe] for scores >= 15.
  static RiskRange fromScore(int score) {
    if (score < 0) return RiskRange.low;
    for (final range in RiskRange.values) {
      if (score >= range.minScore && score <= range.maxScore) {
        return range;
      }
    }
    return RiskRange.severe;
  }

  /// Returns the matching [RiskRange] for a calculated percentage (0 to 100).
  static RiskRange fromPercentage(double percentage) {
    final clamped = percentage.clamp(0.0, 100.0);
    if (clamped < 30.0) return RiskRange.low;
    if (clamped < 60.0) return RiskRange.moderate;
    if (clamped < 85.0) return RiskRange.high;
    return RiskRange.severe;
  }

  /// Returns the matching [RiskRange] from a score and its maximum
  /// possible score.
  static RiskRange fromScoreAndMax(int score, int maxScore) {
    if (maxScore <= 0) return fromScore(score);
    final pct = (score / maxScore) * 100.0;
    return fromPercentage(pct);
  }

  bool contains(int score) => score >= minScore && score <= maxScore;

  @override
  String toString() => '$id ($badgeLabel): $minScore–$maxScore';
}

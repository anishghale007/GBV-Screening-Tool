// ignore_for_file: lines_longer_than_80_chars

enum RiskRange {
  low(
    id: 'R1',
    label: 'Low concern',
    minScore: 0,
    maxScore: 4,
    meaning:
        'Little or no indication of risk right now. Offer general safety awareness info.',
  ),
  moderate(
    id: 'R2',
    label: 'Moderate concern',
    minScore: 5,
    maxScore: 9,
    meaning:
        'Some patterns worth acting on. Suggest documenting incidents and specific support contacts.',
  ),
  high(
    id: 'R3',
    label: 'High concern',
    minScore: 10,
    maxScore: 14,
    meaning:
        'Multiple or serious patterns. Strongly recommend contacting a support organisation.',
  ),
  severe(
    id: 'R4',
    label: 'Severe / urgent',
    minScore: 15,
    maxScore: 32,
    meaning:
        'Direct threat or offline escalation present. Point immediately to emergency and crisis contacts.',
  );

  const RiskRange({
    required this.id,
    required this.label,
    required this.minScore,
    required this.maxScore,
    required this.meaning,
  });

  final String id;
  final String label;
  final int minScore;
  final int maxScore;
  final String meaning;

  /// Returns the matching [RiskRange] for a given total score.
  /// Throws [ArgumentError] if the score falls outside all defined ranges.
  static RiskRange fromScore(int score) {
    for (final range in RiskRange.values) {
      if (score >= range.minScore && score <= range.maxScore) {
        return range;
      }
    }
    throw ArgumentError('No RiskRange defined for score: $score');
  }

  bool contains(int score) => score >= minScore && score <= maxScore;

  @override
  String toString() => '$id ($label): $minScore–$maxScore';
}

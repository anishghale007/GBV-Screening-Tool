/// Represents the level / depth of a screening question.
enum QuestionLevel {
  /// Gateway question: Exactly one per selected incident category.
  gateway,

  /// Follow-up question: Triggered if the linked Gateway score reaches
  /// Unlock_Min_Points threshold.
  followUp,
}

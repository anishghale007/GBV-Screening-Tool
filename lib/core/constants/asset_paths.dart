/// Centralized asset path strings.
///
/// All asset paths in one place so typos are caught at compile time
/// and paths can be updated without touching feature code.
abstract final class AssetPaths {
  // ── Images ──────────────────────────────────────────────────────────
  static const String _imagesBase = 'assets/images';
  static const String _questionsBase = '$_imagesBase/questions';

  /// Returns the illustration path for a given question index (0-based).
  static String questionImage(int index) =>
      '$_questionsBase/question_${index + 1}.png';

  // ── Icons ───────────────────────────────────────────────────────────
  static const String _iconsBase = 'assets/icons';

  /// Placeholder — add specific icon paths as assets are created.
  static String icon(String name) => '$_iconsBase/$name.svg';

  // ── Audio ───────────────────────────────────────────────────────────
  static const String _audioBase = 'assets/audio';

  /// Returns the audio narration path for a question in a given language.
  static String questionAudio({
    required String languageCode,
    required int questionIndex,
  }) =>
      '$_audioBase/$languageCode/question_${questionIndex + 1}.mp3';

  /// Returns the audio narration path for a general screen/instruction.
  static String screenAudio({
    required String languageCode,
    required String screenName,
  }) =>
      '$_audioBase/$languageCode/$screenName.mp3';

  // ── Fonts ───────────────────────────────────────────────────────────
  static const String _fontsBase = 'assets/fonts';

  /// Dyslexia-friendly font file path.
  static const String dyslexiaFont = '$_fontsBase/OpenDyslexic-Regular.otf';
}

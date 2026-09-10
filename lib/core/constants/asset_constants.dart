/// Centralized asset constants for icons, images, audio, and fonts.
abstract final class AssetConstants {
  // ── Icons Base & SVG Assets ──────────────────────────────────────────
  static const String iconsBase = 'assets/icons';
  static const String manIcon = '$iconsBase/man_icon.svg';
  static const String nonBinaryIcon = '$iconsBase/non_binary_icon.svg';
  static const String safeIcon = '$iconsBase/safe_icon.svg';
  static const String womanIcon = '$iconsBase/woman_icon.svg';
  static const String audioLinesIcon = '$iconsBase/audio_lines_icon.svg';
  static const String crossIcon = '$iconsBase/cross_icon.svg';
  static const String flagIcon = '$iconsBase/flag_icon.svg';
  static const String heartCrackIcon = '$iconsBase/heart_crack_icon.svg';
  static const String imageDownloadIcon = '$iconsBase/image_download_icon.svg';
  static const String megaphoneOffIcon = '$iconsBase/megaphone_off_icon.svg';
  static const String messageWarningIcon =
      '$iconsBase/message_warning_icon.svg';
  static const String userLockIcon = '$iconsBase/user_lock_icon.svg';
  static const String userSearchIcon = '$iconsBase/user_search_icon.svg';
  static const String buildingIcon = '$iconsBase/building_icon.svg';
  static const String alertIcon = '$iconsBase/alert_icon.svg';

  /// Helper to get any icon path by name.
  static String icon(String name) => '$iconsBase/$name.svg';

  // ── Images ──────────────────────────────────────────────────────────
  static const String imagesBase = 'assets/images';
  static const String questionsBase = '$imagesBase/questions';

  /// Illustration path for a question index (0-based).
  static String questionImage(int index) =>
      '$questionsBase/question_${index + 1}.png';

  // ── Audio ───────────────────────────────────────────────────────────
  static const String audioBase = 'assets/audio';

  /// Audio narration path for a question in a given language.
  static String questionAudio({
    required String languageCode,
    required int questionIndex,
  }) => '$audioBase/$languageCode/question_${questionIndex + 1}.mp3';

  /// Audio narration path for a general screen/instruction.
  static String screenAudio({
    required String languageCode,
    required String screenName,
  }) => '$audioBase/$languageCode/$screenName.mp3';
}

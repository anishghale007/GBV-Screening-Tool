/// Reusable RegExp patterns used across the app.
abstract final class AppRegex {
  /// Matches strings containing only numeric digits (0-9).
  static final RegExp numericOnly = RegExp(r'^\d+$');

  /// Matches standard international/local phone number (7 to 15 digits).
  static final RegExp phoneNumber = RegExp(r'^\+?[0-9]{7,15}$');

  /// Characters to strip when cleaning phone numbers.
  static final RegExp phonePunctuation = RegExp(r'[\s\-\(\)]');
}

/// Helpful string extensions for validation and formatting.
extension StringValidationX on String {
  /// Whether the string consists purely of digits.
  bool get isNumeric => AppRegex.numericOnly.hasMatch(this);

  /// Whether the string is a valid phone number after cleaning punctuation.
  bool get isValidPhoneNumber {
    final clean = replaceAll(AppRegex.phonePunctuation, '');
    return AppRegex.phoneNumber.hasMatch(clean);
  }

  /// Whether the string is empty or contains only whitespace.
  bool get isBlank => trim().isEmpty;

  /// Whether the string is not empty and not only whitespace.
  bool get isNotBlank => !isBlank;
}

/// Optional nullable string validation extensions.
extension NullableStringValidationX on String? {
  /// Whether the string is null, empty, or whitespace only.
  bool get isNullOrBlank => this == null || this!.isBlank;

  /// Whether the string is non-null and contains non-whitespace characters.
  bool get isNotNullOrBlank => !isNullOrBlank;
}

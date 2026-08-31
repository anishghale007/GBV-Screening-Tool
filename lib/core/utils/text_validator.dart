import 'package:gbv/core/constants/app_constants.dart';

/// Common text validation utilities for form inputs, PIN validation, etc.
abstract final class TextValidator {
  /// Validates that a string value is not null or empty/whitespace only.
  static String? validateNotEmpty(String? value, [String? errorMessage]) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage ?? 'This field cannot be empty';
    }
    return null;
  }

  /// Validates a 4-digit numeric PIN (FR-SAFE-06).
  static String? validatePin(String? value, [String? errorMessage]) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage ?? 'PIN is required';
    }
    final isRightLength = value.length == AppConstants.pinLength;
    final isNumeric = RegExp(r'^\d+$').hasMatch(value);
    if (!isRightLength || !isNumeric) {
      return errorMessage ??
          'PIN must be exactly ${AppConstants.pinLength} digits';
    }
    return null;
  }

  /// Validates that a confirmation PIN matches the original PIN.
  static String? validateConfirmPin(
    String? confirmValue,
    String originalPin, [
    String? errorMessage,
  ]) {
    final pinError = validatePin(confirmValue);
    if (pinError != null) return pinError;

    if (confirmValue != originalPin) {
      return errorMessage ?? 'PINs do not match';
    }
    return null;
  }

  /// Validates a phone number format (for support directory emergency numbers).
  static String? validatePhoneNumber(String? value, [String? errorMessage]) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage ?? 'Phone number is required';
    }
    final cleanNumber = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(cleanNumber)) {
      return errorMessage ?? 'Enter a valid phone number';
    }
    return null;
  }
}

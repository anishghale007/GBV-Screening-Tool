import 'package:flutter/services.dart';

/// Helper for providing tactical haptic feedback across user interactions.
abstract final class HapticHelper {
  /// Triggers a subtle light impact vibration.
  static Future<void> lightImpact({bool isEnabled = true}) async {
    if (!isEnabled) return;
    try {
      await HapticFeedback.vibrate();
    } catch (_) {
      // Gracefully ignore on unsupported devices.
    }
  }

  /// Triggers a selection click vibration on taps / option selection.
  static Future<void> selectionClick({bool isEnabled = true}) async {
    if (!isEnabled) return;
    try {
      await HapticFeedback.selectionClick();
    } catch (_) {
      // Gracefully ignore on unsupported devices.
    }
  }
}

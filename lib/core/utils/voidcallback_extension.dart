import 'package:flutter/foundation.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';
import 'package:gbv/injection_container.dart';
import 'package:vibration/vibration.dart';

void _vibrateMedium() {
  try {
    if (sl.isRegistered<AccessibilityBloc>()) {
      final isHapticEnabled =
          sl<AccessibilityBloc>().state.settings.isHapticFeedbackEnabled;
      if (!isHapticEnabled) return;
    }
    Vibration.vibrate(pattern: [0, 60], amplitude: 255);
  } catch (_) {
    // Gracefully ignore vibration errors on unsupported platforms/devices.
  }
}

extension HapticFeedbackExtension on VoidCallback {
  VoidCallback withMediumImpate() => withMediumImpact();

  VoidCallback withMediumImpact() {
    return () {
      _vibrateMedium();
      this();
    };
  }
}

extension NullableHapticFeedbackExtension on VoidCallback? {
  VoidCallback? withMediumImpate() => withMediumImpact();

  VoidCallback? withMediumImpact() {
    final callback = this;
    if (callback == null) return null;
    return () {
      _vibrateMedium();
      callback();
    };
  }
}

extension ValueChangedHapticFeedbackExtension<T> on ValueChanged<T> {
  ValueChanged<T> withMediumImpate() => withMediumImpact();

  ValueChanged<T> withMediumImpact() {
    return (value) {
      _vibrateMedium();
      this(value);
    };
  }
}

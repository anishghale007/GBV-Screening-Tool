import 'package:flutter/foundation.dart';
import 'package:vibration/vibration.dart';

void _vibrateMedium() {
  Vibration.vibrate(pattern: [0, 60], amplitude: 255);
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

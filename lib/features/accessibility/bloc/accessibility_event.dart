import 'package:equatable/equatable.dart';
import 'package:gbv/core/enums/app_enums.dart';

/// Base class for all accessibility events.
sealed class AccessibilityEvent extends Equatable {
  const AccessibilityEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load saved accessibility settings from persistent storage.
final class LoadAccessibilitySettings extends AccessibilityEvent {
  const LoadAccessibilitySettings();
}

/// Event to update the text size tier (small, medium, large).
final class UpdateTextSize extends AccessibilityEvent {
  const UpdateTextSize(this.textSize);

  final TextSizeOption textSize;

  @override
  List<Object?> get props => [textSize];
}

/// Event to toggle high-contrast display mode.
final class ToggleHighContrast extends AccessibilityEvent {
  const ToggleHighContrast({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];
}

/// Event to toggle dyslexia-friendly font mode.
final class ToggleDyslexiaFont extends AccessibilityEvent {
  const ToggleDyslexiaFont({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];
}

/// Event to toggle large touch targets mode.
final class ToggleLargeTouchTargets extends AccessibilityEvent {
  const ToggleLargeTouchTargets({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];
}

/// Event to toggle haptic feedback on interactions.
final class ToggleHapticFeedback extends AccessibilityEvent {
  const ToggleHapticFeedback({required this.isEnabled});

  final bool isEnabled;

  @override
  List<Object?> get props => [isEnabled];
}

/// Event to reset all accessibility settings to default.
final class ResetAccessibilitySettings extends AccessibilityEvent {
  const ResetAccessibilitySettings();
}

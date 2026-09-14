import 'package:equatable/equatable.dart';
import 'package:gbv/core/accessibility/accessibility_settings.dart';

/// State representation for accessibility preferences.
class AccessibilityState extends Equatable {
  const AccessibilityState({
    this.settings = const AccessibilitySettings(),
    this.isLoading = false,
  });

  /// The active accessibility settings.
  final AccessibilitySettings settings;

  /// Whether settings are currently being loaded from storage.
  final bool isLoading;

  AccessibilityState copyWith({
    AccessibilitySettings? settings,
    bool? isLoading,
  }) {
    return AccessibilityState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [settings, isLoading];
}

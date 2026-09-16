import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbv/core/accessibility/accessibility_settings.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_event.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'accessibility_event.dart';
export 'accessibility_state.dart';

/// BLoC that manages and persists accessibility preferences.
class AccessibilityBloc extends Bloc<AccessibilityEvent, AccessibilityState> {
  AccessibilityBloc(this._prefs)
    : super(AccessibilityState(settings: _loadInitialSettings(_prefs))) {
    on<LoadAccessibilitySettings>(_onLoadSettings);
    on<UpdateTextSize>(_onUpdateTextSize);
    on<ToggleHighContrast>(_onToggleHighContrast);
    on<ToggleDyslexiaFont>(_onToggleDyslexiaFont);
    on<ToggleLargeTouchTargets>(_onToggleLargeTouchTargets);
    on<ToggleHapticFeedback>(_onToggleHapticFeedback);
    on<ToggleAdhdMode>(_onToggleAdhdMode);
    on<ResetAccessibilitySettings>(_onResetSettings);
  }

  final SharedPreferences _prefs;

  static const String storageKey = 'app_accessibility_settings_key';

  static AccessibilitySettings _loadInitialSettings(SharedPreferences prefs) {
    final rawJson = prefs.getString(storageKey);
    if (rawJson != null && rawJson.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
        return AccessibilitySettings.fromJson(decoded);
      } catch (_) {
        return const AccessibilitySettings();
      }
    }
    return const AccessibilitySettings();
  }

  Future<void> _saveSettings(AccessibilitySettings settings) async {
    try {
      await _prefs.setString(storageKey, jsonEncode(settings.toJson()));
    } catch (_) {
      // Ignore write errors gracefully.
    }
  }

  Future<void> _onLoadSettings(
    LoadAccessibilitySettings event,
    Emitter<AccessibilityState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final settings = _loadInitialSettings(_prefs);
    emit(state.copyWith(settings: settings, isLoading: false));
  }

  Future<void> _onUpdateTextSize(
    UpdateTextSize event,
    Emitter<AccessibilityState> emit,
  ) async {
    final updated = state.settings.copyWith(textSize: event.textSize);
    emit(state.copyWith(settings: updated));
    await _saveSettings(updated);
  }

  Future<void> _onToggleHighContrast(
    ToggleHighContrast event,
    Emitter<AccessibilityState> emit,
  ) async {
    final updated = state.settings.copyWith(
      isHighContrastEnabled: event.isEnabled,
    );
    emit(state.copyWith(settings: updated));
    await _saveSettings(updated);
  }

  Future<void> _onToggleDyslexiaFont(
    ToggleDyslexiaFont event,
    Emitter<AccessibilityState> emit,
  ) async {
    final updated = state.settings.copyWith(
      isDyslexiaModeEnabled: event.isEnabled,
    );
    emit(state.copyWith(settings: updated));
    await _saveSettings(updated);
  }

  Future<void> _onToggleLargeTouchTargets(
    ToggleLargeTouchTargets event,
    Emitter<AccessibilityState> emit,
  ) async {
    final updated = state.settings.copyWith(
      isLargeTouchTargetsEnabled: event.isEnabled,
    );
    emit(state.copyWith(settings: updated));
    await _saveSettings(updated);
  }

  Future<void> _onToggleHapticFeedback(
    ToggleHapticFeedback event,
    Emitter<AccessibilityState> emit,
  ) async {
    final updated = state.settings.copyWith(
      isHapticFeedbackEnabled: event.isEnabled,
    );
    emit(state.copyWith(settings: updated));
    await _saveSettings(updated);
  }

  Future<void> _onToggleAdhdMode(
    ToggleAdhdMode event,
    Emitter<AccessibilityState> emit,
  ) async {
    final updated = state.settings.copyWith(
      isAdhdModeEnabled: event.isEnabled,
    );
    emit(state.copyWith(settings: updated));
    await _saveSettings(updated);
  }

  Future<void> _onResetSettings(
    ResetAccessibilitySettings event,
    Emitter<AccessibilityState> emit,
  ) async {
    const defaultSettings = AccessibilitySettings();
    emit(state.copyWith(settings: defaultSettings));
    await _saveSettings(defaultSettings);
  }
}

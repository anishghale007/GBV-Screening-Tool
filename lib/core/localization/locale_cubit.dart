import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cubit responsible for managing the application-wide [Locale].
///
/// Persists user language preference locally using [SharedPreferences]
/// and emits changes so all localized widgets rebuild seamlessly.
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._prefs) : super(_loadInitialLocale(_prefs));

  final SharedPreferences _prefs;

  /// Storage key for the selected locale language code.
  static const String localeStorageKey = 'app_selected_locale_code';

  /// Supported locales.
  static const Locale english = Locale('en');
  static const Locale nepali = Locale('ne');

  /// Loads the persisted locale from local storage, defaulting to English.
  static Locale _loadInitialLocale(SharedPreferences prefs) {
    final code = prefs.getString(localeStorageKey);
    if (code == 'ne') {
      return nepali;
    }
    return english;
  }

  /// Whether the current active locale is Nepali.
  bool get isNepali => state.languageCode == 'ne';

  /// Whether the current active locale is English.
  bool get isEnglish => state.languageCode == 'en';

  /// Sets the application locale and saves it locally.
  Future<void> setLocale(Locale locale) async {
    if (locale.languageCode != 'en' && locale.languageCode != 'ne') return;
    if (state.languageCode == locale.languageCode) return;

    await _prefs.setString(localeStorageKey, locale.languageCode);
    emit(locale);
  }

  /// Sets the application locale to English.
  Future<void> setEnglish() => setLocale(english);

  /// Sets the application locale to Nepali ("ने").
  Future<void> setNepali() => setLocale(nepali);

  /// Toggles between English and Nepali locales.
  Future<void> toggleLocale() async {
    if (isNepali) {
      await setEnglish();
    } else {
      await setNepali();
    }
  }
}

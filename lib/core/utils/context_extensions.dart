import 'package:flutter/material.dart';
import 'package:gbv/l10n/l10n.dart';

/// Extension methods on [BuildContext] for ergonomic access to theme,
/// localization, media queries, and color schemes.
extension BuildContextX on BuildContext {
  /// App localizations shortcut (`context.l10n`).
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Current [ColorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Current [TextTheme].
  TextTheme get textTheme => theme.textTheme;

  /// [MediaQueryData] of the context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen size.
  Size get screenSize => mediaQuery.size;

  /// Screen width.
  double get screenWidth => screenSize.width;

  /// Screen height.
  double get screenHeight => screenSize.height;

  /// View padding (e.g. status bar, notch).
  EdgeInsets get padding => mediaQuery.padding;

  /// View insets (e.g. keyboard).
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Whether the device is in dark/high-contrast mode.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Hides the software keyboard.
  void hideKeyboard() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Shows a standard snackbar message.
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
          action: action,
        ),
      );
  }
}

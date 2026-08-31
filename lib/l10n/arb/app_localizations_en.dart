// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Wellbeing';

  @override
  String get languageSelectionTitle => 'Choose Language';

  @override
  String get nepali => 'Nepali';

  @override
  String get english => 'English';

  @override
  String get continueButton => 'Continue';

  @override
  String get backButton => 'Back';

  @override
  String get skipButton => 'Skip';

  @override
  String get listenButton => 'Listen';

  @override
  String get replayButton => 'Replay';

  @override
  String get nextButton => 'Next';

  @override
  String get previousButton => 'Previous';

  @override
  String get preferNotToSay => 'Prefer not to say';

  @override
  String questionProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get enterPin => 'Enter PIN';

  @override
  String get createPin => 'Create a PIN';

  @override
  String get confirmPin => 'Confirm your PIN';

  @override
  String get incorrectPin => 'Incorrect PIN. Please try again.';

  @override
  String get settings => 'Settings';

  @override
  String get accessibilitySettings => 'Accessibility';

  @override
  String get textSize => 'Text Size';

  @override
  String get textSizeSmall => 'Small';

  @override
  String get textSizeMedium => 'Medium';

  @override
  String get textSizeLarge => 'Large';

  @override
  String get highContrast => 'High Contrast';

  @override
  String get reduceAnimations => 'Reduce Animations';

  @override
  String get largeTouchTargets => 'Large Touch Targets';

  @override
  String get hapticFeedback => 'Haptic Feedback';

  @override
  String get screenReaderMode => 'Screen Reader Mode';

  @override
  String get adhdMode => 'Focus Mode';

  @override
  String get dyslexiaMode => 'Dyslexia-Friendly Text';

  @override
  String get visionImpairedMode => 'Enhanced Visibility';

  @override
  String get lowLiteracyMode => 'Simple Mode';

  @override
  String get autoPlayAudio => 'Auto-Play Audio';

  @override
  String get supportResources => 'Support Resources';

  @override
  String get emergencyContacts => 'Emergency Contacts';

  @override
  String get helpline => 'Women\'s Helpline';

  @override
  String get counselor => 'Counselor';

  @override
  String get localSupport => 'Local Support Services';

  @override
  String get quickExitMessage => 'Press and hold to exit safely';

  @override
  String get completionTitle => 'Thank You';

  @override
  String get completionMessage => 'Here are some suggested next steps for you.';
}

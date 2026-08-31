// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get appTitle => 'मेरो स्वास्थ्य';

  @override
  String get languageSelectionTitle => 'भाषा छान्नुहोस्';

  @override
  String get nepali => 'नेपाली';

  @override
  String get english => 'अंग्रेजी';

  @override
  String get continueButton => 'जारी राख्नुहोस्';

  @override
  String get backButton => 'पछाडि';

  @override
  String get skipButton => 'छोड्नुहोस्';

  @override
  String get listenButton => 'सुन्नुहोस्';

  @override
  String get replayButton => 'फेरि सुन्नुहोस्';

  @override
  String get nextButton => 'अर्को';

  @override
  String get previousButton => 'अघिल्लो';

  @override
  String get preferNotToSay => 'भन्न चाहन्नँ';

  @override
  String questionProgress(int current, int total) {
    return 'प्रश्न $current / $total';
  }

  @override
  String get enterPin => 'PIN प्रविष्ट गर्नुहोस्';

  @override
  String get createPin => 'PIN बनाउनुहोस्';

  @override
  String get confirmPin => 'PIN पुष्टि गर्नुहोस्';

  @override
  String get incorrectPin => 'गलत PIN। फेरि प्रयास गर्नुहोस्।';

  @override
  String get settings => 'सेटिङहरू';

  @override
  String get accessibilitySettings => 'पहुँचयोग्यता';

  @override
  String get textSize => 'अक्षरको आकार';

  @override
  String get textSizeSmall => 'सानो';

  @override
  String get textSizeMedium => 'मध्यम';

  @override
  String get textSizeLarge => 'ठूलो';

  @override
  String get highContrast => 'उच्च कन्ट्रास्ट';

  @override
  String get reduceAnimations => 'एनिमेसन घटाउनुहोस्';

  @override
  String get largeTouchTargets => 'ठूला बटनहरू';

  @override
  String get hapticFeedback => 'स्पर्श प्रतिक्रिया';

  @override
  String get screenReaderMode => 'स्क्रिन रिडर मोड';

  @override
  String get adhdMode => 'फोकस मोड';

  @override
  String get dyslexiaMode => 'पढ्न सजिलो अक्षर';

  @override
  String get visionImpairedMode => 'बढी देखिने मोड';

  @override
  String get lowLiteracyMode => 'सरल मोड';

  @override
  String get autoPlayAudio => 'स्वत: अडियो बजाउनुहोस्';

  @override
  String get supportResources => 'सहायता स्रोतहरू';

  @override
  String get emergencyContacts => 'आपतकालीन सम्पर्कहरू';

  @override
  String get helpline => 'महिला हेल्पलाइन';

  @override
  String get counselor => 'परामर्शदाता';

  @override
  String get localSupport => 'स्थानीय सहायता सेवाहरू';

  @override
  String get quickExitMessage => 'सुरक्षित रूपमा बाहिर निस्कन थिचिराख्नुहोस्';

  @override
  String get completionTitle => 'धन्यवाद';

  @override
  String get completionMessage => 'तपाईंका लागि केही सुझावहरू यहाँ छन्।';
}

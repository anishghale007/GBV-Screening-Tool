// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GBV Screening Tool';

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
  String get nextButton => 'Next Step';

  @override
  String get nextStepButton => 'Next Step';

  @override
  String get submitButton => 'Submit';

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
  String get audioSettingsTitle => 'Audio Settings';

  @override
  String get autoPlayAudio => 'Audio narration auto-play';

  @override
  String get autoPlayAudioSubtitle =>
      'Auto-read each question aloud automatically';

  @override
  String get screenReaderMode => 'Screen reader optimization';

  @override
  String get screenReaderModeSubtitle =>
      'Enhanced compatibility with screen readers';

  @override
  String get visionAndReadingTitle => 'Vision & Reading';

  @override
  String get textSize => 'Text size';

  @override
  String get textSizeSmall => 'Small';

  @override
  String get textSizeMedium => 'Medium';

  @override
  String get textSizeLarge => 'Large';

  @override
  String get textSizePreview =>
      'Preview: This is how the text will appear in the app.';

  @override
  String get highContrast => 'High contrast mode';

  @override
  String get highContrastSubtitle => 'Increase contrast for better visibility';

  @override
  String get dyslexiaMode => 'Dyslexia-friendly font';

  @override
  String get dyslexiaFontSubtitle => 'Use a font designed for easier reading';

  @override
  String get motorAndInteractionsTitle => 'Motor & Interactions';

  @override
  String get largeTouchTargets => 'Large touch targets';

  @override
  String get largeTouchTargetsSubtitle =>
      'Provide larger, easier-to-tap buttons';

  @override
  String get hapticFeedback => 'Haptic feedback';

  @override
  String get hapticFeedbackSubtitle => 'Feel subtle vibrations on interactions';

  @override
  String get reduceAnimations => 'Reduce Animations';

  @override
  String get cognitiveSupportTitle => 'Cognitive Support';

  @override
  String get lowLiteracyMode => 'Low literacy mode';

  @override
  String get lowLiteracyModeSubtitle => 'Simpler wording with more visual cues';

  @override
  String get adhdMode => 'ADHD-friendly mode';

  @override
  String get adhdModeSubtitle => 'Reduced visual clutter and distractions';

  @override
  String get languageSectionTitle => 'Language';

  @override
  String get appLanguage => 'App language';

  @override
  String get selectAppLanguage => 'Select App Language';

  @override
  String get englishSubtitle => 'English (US)';

  @override
  String get nepaliSubtitle => 'Nepali';

  @override
  String get visionImpairedMode => 'Enhanced Visibility';

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

  @override
  String get screeningTitle => 'Screening';

  @override
  String get genderSelectionTitle => 'How would you like to be represented?';

  @override
  String get genderSelectionSubtitle =>
      'This is used only to tailor question wording. Your choice is not stored anywhere.';

  @override
  String get genderWoman => 'Woman';

  @override
  String get genderMan => 'Man';

  @override
  String get genderNonBinary => 'Non-binary';

  @override
  String get privacyBannerText =>
      'This app is encrypted. No local log or background footprint is kept.';

  @override
  String get incidentSelectionTitle =>
      'Which categories best describe the situation?';

  @override
  String get incidentSelectionSubtitle =>
      'Select all that apply. This helps categorize resources.';

  @override
  String get categoryStalking => 'Stalking';

  @override
  String get categoryStalkingDesc =>
      'Constantly followed or watched without consent';

  @override
  String get categoryCyberbullying => 'Cyberbullying';

  @override
  String get categoryCyberbullyingDesc =>
      'Harassment over messages, social media, apps';

  @override
  String get categorySlander => 'Slander / False Rumours';

  @override
  String get categorySlanderDesc => 'Spreading damaging fake reports about you';

  @override
  String get categoryLeakedImages => 'Leaked / Fake Images';

  @override
  String get categoryLeakedImagesDesc =>
      'Private or manipulated photos shared online';

  @override
  String get categorySharingDetails => 'Sharing private details';

  @override
  String get categorySharingDetailsDesc =>
      'Exposing addresses, contacts, schedules publicly';

  @override
  String get categoryFakeAccounts => 'Fake accounts';

  @override
  String get categoryFakeAccountsDesc =>
      'Impersonator profile created with your identity';

  @override
  String get categoryThreats => 'Threats';

  @override
  String get categoryThreatsDesc =>
      'Violent warnings of blackmail and leverage';

  @override
  String get categoryOfflineEscalation => 'Offline escalation';

  @override
  String get categoryOfflineEscalationDesc =>
      'Incidents spilling into real-world workspace or home';

  @override
  String get categorySexualHarassment => 'Sexual harassment';

  @override
  String get categorySexualHarassmentDesc =>
      'Unwelcome sexual comments or actions online';

  @override
  String get categoryPoliticalIntimidation => 'Political intimidation';

  @override
  String get categoryPoliticalIntimidationDesc =>
      'Targeted systemic pressure or civic silencing';

  @override
  String get notSureSkipSelection => 'I\'m not sure / skip selection';

  @override
  String get assessmentSummary => 'Assessment Summary';

  @override
  String get assessmentSummaryDefaultDesc =>
      'Your safety and peace of mind are critical. Based on your answers, there are indicators of high verbal/emotional pressure and financial control.';

  @override
  String get talkToCounselor => 'Talk to a Counselor';

  @override
  String get talkToCounselorDesc =>
      'A trained counselor is available to listen and help you confidentially.';

  @override
  String get callHelpline1145 => 'Call Helpline 1145';

  @override
  String get knowYourDigitalRights => 'Know Your Digital Rights';

  @override
  String get knowYourDigitalRightsDesc =>
      'Understand privacy and online safety laws in Nepal.';

  @override
  String get learnMore => 'Learn More';

  @override
  String get safetyPlanningTips => 'Safety Planning Tips';

  @override
  String get safetyPlanningTipsDesc =>
      'Practical, secure steps to increase your overall safety.';

  @override
  String get viewTips => 'View Tips';

  @override
  String get riskLow => 'Low';

  @override
  String get riskModerate => 'Moderate';

  @override
  String get riskHigh => 'High concern';

  @override
  String get riskSevere => 'Severe/Urgent';

  @override
  String get riskLowMeaning =>
      'Your safety and peace of mind are critical. Based on your answers, there are low indicators of risk at this time.';

  @override
  String get riskModerateMeaning =>
      'Your safety and peace of mind are critical. Based on your answers, there are indicators of moderate concern that may require attention.';

  @override
  String get riskHighMeaning =>
      'Your safety and peace of mind are critical. Based on your answers, there are indicators of high verbal/emotional pressure and financial control.';

  @override
  String get riskSevereMeaning =>
      'Your safety and peace of mind are critical. Based on your answers, there are indicators of severe risk, direct threat, or urgent escalation.';

  @override
  String get digitalRightsModalTitle => 'Digital Rights in Nepal';

  @override
  String get digitalRightsModalContent =>
      'Under Nepalese law (including the Electronic Transactions Act and Privacy Act), you are protected against online harassment, defamation, leaked media, and cyberstalking. Incidents can be reported directly to the Nepal Police Cyber Bureau (1145 / 01-4412797).';

  @override
  String get safetyTipsModalTitle => 'Safety Planning Tips';

  @override
  String get safetyTipsModalContent =>
      '• Secure your accounts with Two-Factor Authentication (2FA).\n• Screenshot and document threatening messages with timestamps.\n• Keep emergency contacts and helpline numbers saved.\n• Establish a private check-in code with trusted persons.\n• Use Quick Exit anytime you need immediate discretion.';

  @override
  String get close => 'Close';

  @override
  String get supportDirectoryTitle => 'Support Directory';

  @override
  String get searchHelplinesPlaceholder => 'Search helplines & centers...';

  @override
  String get emergencyBannerText =>
      'In immediate danger? Call Police (100) or Women\'s Helpline (1145).';

  @override
  String get verifiedResources => 'Verified Resources';

  @override
  String get noResourcesFound => 'No resources found matching your search.';

  @override
  String callButtonLabel(String number) {
    return 'Call $number';
  }

  @override
  String get homePrivacyBanner =>
      '100% On-device & Encrypted. No personal data leaves this phone.';

  @override
  String get wellbeingScreeningTitle => 'Wellbeing Screening';

  @override
  String get wellbeingScreeningDesc =>
      'A quick, 15-question guided audio check to help understand your situation and suggest safe options.';

  @override
  String get startScreeningButton => 'Start Screening';

  @override
  String get supportResourcesDesc =>
      'Always-accessible emergency numbers, helplines, and local counselors.';

  @override
  String get viewResourcesButton => 'View Resources';

  @override
  String progressLabel(int percent) {
    return 'Progress: $percent%';
  }
}

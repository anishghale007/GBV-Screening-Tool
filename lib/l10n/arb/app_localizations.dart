import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ne.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ne'),
  ];

  /// Neutral app title shown in app bar and store listing
  ///
  /// In en, this message translates to:
  /// **'GBV Screening Tool'**
  String get appTitle;

  /// Title on the language selection screen
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get languageSelectionTitle;

  /// No description provided for @nepali.
  ///
  /// In en, this message translates to:
  /// **'Nepali'**
  String get nepali;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Generic continue button label
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @skipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipButton;

  /// Button label to play audio narration
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listenButton;

  /// No description provided for @replayButton.
  ///
  /// In en, this message translates to:
  /// **'Replay'**
  String get replayButton;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextButton;

  /// Button label to proceed to next screening question step
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStepButton;

  /// Button label to submit completed screening questionnaire
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @previousButton.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previousButton;

  /// Option to skip answering a screening question
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get preferNotToSay;

  /// Progress indicator showing current question number
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String questionProgress(int current, int total);

  /// Prompt shown on the PIN lock screen
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get enterPin;

  /// No description provided for @createPin.
  ///
  /// In en, this message translates to:
  /// **'Create a PIN'**
  String get createPin;

  /// No description provided for @confirmPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm your PIN'**
  String get confirmPin;

  /// No description provided for @incorrectPin.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN. Please try again.'**
  String get incorrectPin;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @accessibilitySettings.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibilitySettings;

  /// No description provided for @audioSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Audio Settings'**
  String get audioSettingsTitle;

  /// No description provided for @autoPlayAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio narration auto-play'**
  String get autoPlayAudio;

  /// No description provided for @autoPlayAudioSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Auto-read each question aloud automatically'**
  String get autoPlayAudioSubtitle;

  /// No description provided for @screenReaderMode.
  ///
  /// In en, this message translates to:
  /// **'Screen reader optimization'**
  String get screenReaderMode;

  /// No description provided for @screenReaderModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enhanced compatibility with screen readers'**
  String get screenReaderModeSubtitle;

  /// No description provided for @visionAndReadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Vision & Reading'**
  String get visionAndReadingTitle;

  /// No description provided for @textSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSize;

  /// No description provided for @textSizeSmall.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get textSizeSmall;

  /// No description provided for @textSizeMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get textSizeMedium;

  /// No description provided for @textSizeLarge.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get textSizeLarge;

  /// No description provided for @textSizePreview.
  ///
  /// In en, this message translates to:
  /// **'Preview: This is how the text will appear in the app.'**
  String get textSizePreview;

  /// No description provided for @highContrast.
  ///
  /// In en, this message translates to:
  /// **'High contrast mode'**
  String get highContrast;

  /// No description provided for @highContrastSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Increase contrast for better visibility'**
  String get highContrastSubtitle;

  /// No description provided for @dyslexiaMode.
  ///
  /// In en, this message translates to:
  /// **'Dyslexia-friendly font'**
  String get dyslexiaMode;

  /// No description provided for @dyslexiaFontSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use a font designed for easier reading'**
  String get dyslexiaFontSubtitle;

  /// No description provided for @motorAndInteractionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Motor & Interactions'**
  String get motorAndInteractionsTitle;

  /// No description provided for @largeTouchTargets.
  ///
  /// In en, this message translates to:
  /// **'Large touch targets'**
  String get largeTouchTargets;

  /// No description provided for @largeTouchTargetsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Provide larger, easier-to-tap buttons'**
  String get largeTouchTargetsSubtitle;

  /// No description provided for @hapticFeedback.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get hapticFeedback;

  /// No description provided for @hapticFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Feel subtle vibrations on interactions'**
  String get hapticFeedbackSubtitle;

  /// No description provided for @reduceAnimations.
  ///
  /// In en, this message translates to:
  /// **'Reduce Animations'**
  String get reduceAnimations;

  /// No description provided for @cognitiveSupportTitle.
  ///
  /// In en, this message translates to:
  /// **'Cognitive Support'**
  String get cognitiveSupportTitle;

  /// No description provided for @lowLiteracyMode.
  ///
  /// In en, this message translates to:
  /// **'Low literacy mode'**
  String get lowLiteracyMode;

  /// No description provided for @lowLiteracyModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Simpler wording with more visual cues'**
  String get lowLiteracyModeSubtitle;

  /// No description provided for @adhdMode.
  ///
  /// In en, this message translates to:
  /// **'ADHD-friendly mode'**
  String get adhdMode;

  /// No description provided for @adhdModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reduced visual clutter and distractions'**
  String get adhdModeSubtitle;

  /// No description provided for @languageSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSectionTitle;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get appLanguage;

  /// No description provided for @selectAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select App Language'**
  String get selectAppLanguage;

  /// No description provided for @englishSubtitle.
  ///
  /// In en, this message translates to:
  /// **'English (US)'**
  String get englishSubtitle;

  /// No description provided for @nepaliSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nepali'**
  String get nepaliSubtitle;

  /// No description provided for @visionImpairedMode.
  ///
  /// In en, this message translates to:
  /// **'Enhanced Visibility'**
  String get visionImpairedMode;

  /// Title for the support/help directory
  ///
  /// In en, this message translates to:
  /// **'Support Resources'**
  String get supportResources;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get emergencyContacts;

  /// No description provided for @helpline.
  ///
  /// In en, this message translates to:
  /// **'Women\'s Helpline'**
  String get helpline;

  /// No description provided for @counselor.
  ///
  /// In en, this message translates to:
  /// **'Counselor'**
  String get counselor;

  /// No description provided for @localSupport.
  ///
  /// In en, this message translates to:
  /// **'Local Support Services'**
  String get localSupport;

  /// No description provided for @quickExitMessage.
  ///
  /// In en, this message translates to:
  /// **'Press and hold to exit safely'**
  String get quickExitMessage;

  /// No description provided for @completionTitle.
  ///
  /// In en, this message translates to:
  /// **'Thank You'**
  String get completionTitle;

  /// No description provided for @completionMessage.
  ///
  /// In en, this message translates to:
  /// **'Here are some suggested next steps for you.'**
  String get completionMessage;

  /// App bar title on screening pages
  ///
  /// In en, this message translates to:
  /// **'Screening'**
  String get screeningTitle;

  /// Heading on the gender selection screen
  ///
  /// In en, this message translates to:
  /// **'How would you like to be represented?'**
  String get genderSelectionTitle;

  /// Privacy note below the gender question heading
  ///
  /// In en, this message translates to:
  /// **'This is used only to tailor question wording. Your choice is not stored anywhere.'**
  String get genderSelectionSubtitle;

  /// No description provided for @genderWoman.
  ///
  /// In en, this message translates to:
  /// **'Woman'**
  String get genderWoman;

  /// No description provided for @genderMan.
  ///
  /// In en, this message translates to:
  /// **'Man'**
  String get genderMan;

  /// No description provided for @genderNonBinary.
  ///
  /// In en, this message translates to:
  /// **'Non-binary'**
  String get genderNonBinary;

  /// Short privacy assurance shown at the bottom of screening pages
  ///
  /// In en, this message translates to:
  /// **'This app is encrypted. No local log or background footprint is kept.'**
  String get privacyBannerText;

  /// Title on the incident category selection screen
  ///
  /// In en, this message translates to:
  /// **'Which categories best describe the situation?'**
  String get incidentSelectionTitle;

  /// Subtitle explaining multi-select for categories
  ///
  /// In en, this message translates to:
  /// **'Select all that apply. This helps categorize resources.'**
  String get incidentSelectionSubtitle;

  /// No description provided for @categoryStalking.
  ///
  /// In en, this message translates to:
  /// **'Stalking'**
  String get categoryStalking;

  /// No description provided for @categoryStalkingDesc.
  ///
  /// In en, this message translates to:
  /// **'Constantly followed or watched without consent'**
  String get categoryStalkingDesc;

  /// No description provided for @categoryCyberbullying.
  ///
  /// In en, this message translates to:
  /// **'Cyberbullying'**
  String get categoryCyberbullying;

  /// No description provided for @categoryCyberbullyingDesc.
  ///
  /// In en, this message translates to:
  /// **'Harassment over messages, social media, apps'**
  String get categoryCyberbullyingDesc;

  /// No description provided for @categorySlander.
  ///
  /// In en, this message translates to:
  /// **'Slander / False Rumours'**
  String get categorySlander;

  /// No description provided for @categorySlanderDesc.
  ///
  /// In en, this message translates to:
  /// **'Spreading damaging fake reports about you'**
  String get categorySlanderDesc;

  /// No description provided for @categoryLeakedImages.
  ///
  /// In en, this message translates to:
  /// **'Leaked / Fake Images'**
  String get categoryLeakedImages;

  /// No description provided for @categoryLeakedImagesDesc.
  ///
  /// In en, this message translates to:
  /// **'Private or manipulated photos shared online'**
  String get categoryLeakedImagesDesc;

  /// No description provided for @categorySharingDetails.
  ///
  /// In en, this message translates to:
  /// **'Sharing private details'**
  String get categorySharingDetails;

  /// No description provided for @categorySharingDetailsDesc.
  ///
  /// In en, this message translates to:
  /// **'Exposing addresses, contacts, schedules publicly'**
  String get categorySharingDetailsDesc;

  /// No description provided for @categoryFakeAccounts.
  ///
  /// In en, this message translates to:
  /// **'Fake accounts'**
  String get categoryFakeAccounts;

  /// No description provided for @categoryFakeAccountsDesc.
  ///
  /// In en, this message translates to:
  /// **'Impersonator profile created with your identity'**
  String get categoryFakeAccountsDesc;

  /// No description provided for @categoryThreats.
  ///
  /// In en, this message translates to:
  /// **'Threats'**
  String get categoryThreats;

  /// No description provided for @categoryThreatsDesc.
  ///
  /// In en, this message translates to:
  /// **'Violent warnings of blackmail and leverage'**
  String get categoryThreatsDesc;

  /// No description provided for @categoryOfflineEscalation.
  ///
  /// In en, this message translates to:
  /// **'Offline escalation'**
  String get categoryOfflineEscalation;

  /// No description provided for @categoryOfflineEscalationDesc.
  ///
  /// In en, this message translates to:
  /// **'Incidents spilling into real-world workspace or home'**
  String get categoryOfflineEscalationDesc;

  /// No description provided for @categorySexualHarassment.
  ///
  /// In en, this message translates to:
  /// **'Sexual harassment'**
  String get categorySexualHarassment;

  /// No description provided for @categorySexualHarassmentDesc.
  ///
  /// In en, this message translates to:
  /// **'Unwelcome sexual comments or actions online'**
  String get categorySexualHarassmentDesc;

  /// No description provided for @categoryPoliticalIntimidation.
  ///
  /// In en, this message translates to:
  /// **'Political intimidation'**
  String get categoryPoliticalIntimidation;

  /// No description provided for @categoryPoliticalIntimidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Targeted systemic pressure or civic silencing'**
  String get categoryPoliticalIntimidationDesc;

  /// No description provided for @notSureSkipSelection.
  ///
  /// In en, this message translates to:
  /// **'I\'m not sure / skip selection'**
  String get notSureSkipSelection;

  /// Heading for the screening assessment summary card
  ///
  /// In en, this message translates to:
  /// **'Assessment Summary'**
  String get assessmentSummary;

  /// No description provided for @assessmentSummaryDefaultDesc.
  ///
  /// In en, this message translates to:
  /// **'Your safety and peace of mind are critical. Based on your answers, there are indicators of high verbal/emotional pressure and financial control.'**
  String get assessmentSummaryDefaultDesc;

  /// No description provided for @talkToCounselor.
  ///
  /// In en, this message translates to:
  /// **'Talk to a Counselor'**
  String get talkToCounselor;

  /// No description provided for @talkToCounselorDesc.
  ///
  /// In en, this message translates to:
  /// **'A trained counselor is available to listen and help you confidentially.'**
  String get talkToCounselorDesc;

  /// No description provided for @callHelpline1145.
  ///
  /// In en, this message translates to:
  /// **'Call Helpline 1145'**
  String get callHelpline1145;

  /// No description provided for @knowYourDigitalRights.
  ///
  /// In en, this message translates to:
  /// **'Know Your Digital Rights'**
  String get knowYourDigitalRights;

  /// No description provided for @knowYourDigitalRightsDesc.
  ///
  /// In en, this message translates to:
  /// **'Understand privacy and online safety laws in Nepal.'**
  String get knowYourDigitalRightsDesc;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @safetyPlanningTips.
  ///
  /// In en, this message translates to:
  /// **'Safety Planning Tips'**
  String get safetyPlanningTips;

  /// No description provided for @safetyPlanningTipsDesc.
  ///
  /// In en, this message translates to:
  /// **'Practical, secure steps to increase your overall safety.'**
  String get safetyPlanningTipsDesc;

  /// No description provided for @viewTips.
  ///
  /// In en, this message translates to:
  /// **'View Tips'**
  String get viewTips;

  /// No description provided for @riskLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get riskLow;

  /// No description provided for @riskModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get riskModerate;

  /// No description provided for @riskHigh.
  ///
  /// In en, this message translates to:
  /// **'High concern'**
  String get riskHigh;

  /// No description provided for @riskSevere.
  ///
  /// In en, this message translates to:
  /// **'Severe/Urgent'**
  String get riskSevere;

  /// No description provided for @riskLowMeaning.
  ///
  /// In en, this message translates to:
  /// **'Your safety and peace of mind are critical. Based on your answers, there are low indicators of risk at this time.'**
  String get riskLowMeaning;

  /// No description provided for @riskModerateMeaning.
  ///
  /// In en, this message translates to:
  /// **'Your safety and peace of mind are critical. Based on your answers, there are indicators of moderate concern that may require attention.'**
  String get riskModerateMeaning;

  /// No description provided for @riskHighMeaning.
  ///
  /// In en, this message translates to:
  /// **'Your safety and peace of mind are critical. Based on your answers, there are indicators of high verbal/emotional pressure and financial control.'**
  String get riskHighMeaning;

  /// No description provided for @riskSevereMeaning.
  ///
  /// In en, this message translates to:
  /// **'Your safety and peace of mind are critical. Based on your answers, there are indicators of severe risk, direct threat, or urgent escalation.'**
  String get riskSevereMeaning;

  /// No description provided for @digitalRightsModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Digital Rights in Nepal'**
  String get digitalRightsModalTitle;

  /// No description provided for @digitalRightsModalContent.
  ///
  /// In en, this message translates to:
  /// **'Under Nepalese law (including the Electronic Transactions Act and Privacy Act), you are protected against online harassment, defamation, leaked media, and cyberstalking. Incidents can be reported directly to the Nepal Police Cyber Bureau (1145 / 01-4412797).'**
  String get digitalRightsModalContent;

  /// No description provided for @safetyTipsModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety Planning Tips'**
  String get safetyTipsModalTitle;

  /// No description provided for @safetyTipsModalContent.
  ///
  /// In en, this message translates to:
  /// **'• Secure your accounts with Two-Factor Authentication (2FA).\n• Screenshot and document threatening messages with timestamps.\n• Keep emergency contacts and helpline numbers saved.\n• Establish a private check-in code with trusted persons.\n• Use Quick Exit anytime you need immediate discretion.'**
  String get safetyTipsModalContent;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// AppBar title on the support directory page
  ///
  /// In en, this message translates to:
  /// **'Support Directory'**
  String get supportDirectoryTitle;

  /// No description provided for @searchHelplinesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search helplines & centers...'**
  String get searchHelplinesPlaceholder;

  /// No description provided for @emergencyBannerText.
  ///
  /// In en, this message translates to:
  /// **'In immediate danger? Call Police (100) or Women\'s Helpline (1145).'**
  String get emergencyBannerText;

  /// No description provided for @verifiedResources.
  ///
  /// In en, this message translates to:
  /// **'Verified Resources'**
  String get verifiedResources;

  /// No description provided for @noResourcesFound.
  ///
  /// In en, this message translates to:
  /// **'No resources found matching your search.'**
  String get noResourcesFound;

  /// Call button label with phone number parameter
  ///
  /// In en, this message translates to:
  /// **'Call {number}'**
  String callButtonLabel(String number);

  /// Privacy assurance banner on the home page
  ///
  /// In en, this message translates to:
  /// **'100% On-device & Encrypted. No personal data leaves this phone.'**
  String get homePrivacyBanner;

  /// Title of the wellbeing screening card on home page
  ///
  /// In en, this message translates to:
  /// **'Wellbeing Screening'**
  String get wellbeingScreeningTitle;

  /// Description of the wellbeing screening card on home page
  ///
  /// In en, this message translates to:
  /// **'A quick, 15-question guided audio check to help understand your situation and suggest safe options.'**
  String get wellbeingScreeningDesc;

  /// Button to begin the wellbeing screening
  ///
  /// In en, this message translates to:
  /// **'Start Screening'**
  String get startScreeningButton;

  /// Description of the support resources card on home page
  ///
  /// In en, this message translates to:
  /// **'Always-accessible emergency numbers, helplines, and local counselors.'**
  String get supportResourcesDesc;

  /// Button to navigate to support directory from home page
  ///
  /// In en, this message translates to:
  /// **'View Resources'**
  String get viewResourcesButton;

  /// Progress percentage indicator label
  ///
  /// In en, this message translates to:
  /// **'Progress: {percent}%'**
  String progressLabel(int percent);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ne':
      return AppLocalizationsNe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

import 'package:gbv/features/screening/models/screening_question.dart';

/// Default 4-level frequency response options used across screening questions.
const List<ScreeningOption> defaultFrequencyOptions = [
  ScreeningOption(
    id: 'yes_often',
    labelEn: 'Yes, often',
    labelNe: 'हो, धेरैजसो',
  ),
  ScreeningOption(
    id: 'yes_sometimes',
    labelEn: 'Yes, sometimes',
    labelNe: 'हो, कहिलेकाहीं',
  ),
  ScreeningOption(
    id: 'rarely',
    labelEn: 'Rarely',
    labelNe: 'कमै मात्र',
  ),
  ScreeningOption(
    id: 'no_never',
    labelEn: 'No, never',
    labelNe: 'होइन, कहिल्यै होइन',
  ),
];

/// Dynamic list of screening questions.
///
/// New questions or custom options can be easily added or modified here.
const List<ScreeningQuestion> defaultScreeningQuestions = [
  ScreeningQuestion(
    id: 1,
    textEn:
        'In the last few months, has someone sent you unwanted, repetitive, '
        'or threatening messages online?',
    textNe:
        'पछिल्ला केही महिनाहरूमा, के कसैले तपाईंलाई अनलाइनमा नचाहिँदो, '
        'बारम्बार वा धम्कीपूर्ण सन्देशहरू पठाएको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 2,
    textEn:
        'Has anyone shared or threatened to share your private photos, '
        'videos, or personal conversations without your consent?',
    textNe:
        'के कसैले तपाईंको सहमति बिना तपाईंको निजी तस्बिर, भिडियो '
        'वा व्यक्तिगत कुराकानीहरू सार्वजनिक गरेको वा गर्ने धम्की दिएको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 3,
    textEn:
        'Has someone created fake accounts or profiles impersonating you '
        'or damaging your reputation?',
    textNe:
        'के कसैले तपाईंको नाममा नक्कली खाता बनाएर तपाईंको पहिचानको '
        'दुरुपयोग गरेको वा प्रतिष्ठामा आँच पुर्याएको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 4,
    textEn:
        'In the last few months, has someone followed or shown up where '
        'you were without you inviting them?',
    textNe:
        'पछिल्ला केही महिनाहरूमा, के कसैले तपाईंलाई नबोलाइकन तपाईं भएको '
        'ठाउँमा पछ्याएको वा देखा परेको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 5,
    textEn:
        'Has someone posted your personal contact details, location, '
        'or home address online to intimidate you?',
    textNe:
        'के कसैले तपाईंलाई डराउन वा धम्क्याउन तपाईंको सम्पर्क विवरण, '
        'ठेगाना वा स्थान अनलाइनमा पोस्ट गरेको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 6,
    textEn:
        'Has someone made unwanted sexual advances, comments, or sent '
        'inappropriate images to you?',
    textNe:
        'के कसैले तपाईंसँग अवाञ्छित यौनजन्य प्रस्ताव, टिप्पणी वा '
        'अनुपयुक्त तस्बिरहरू पठाएको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 7,
    textEn:
        'Have you experienced coordinated online harassment, trolling, '
        'or hate speech targeting you?',
    textNe:
        'के तपाईंले योजनाबद्ध अनलाइन दुर्व्यवहार, ट्रोलिङ वा घृणास्पद '
        'अभिव्यक्तिको सामना गर्नुभएको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 8,
    textEn:
        'Has someone monitored or hacked your device, social media, '
        'or communication accounts?',
    textNe:
        'के कसैले तपाईंको फोन, सामाजिक सञ्जाल वा सन्देश खाताहरू '
        'ह्याक वा निगरानी गरेको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 9,
    textEn:
        'Has online harassment or threats extended into your physical '
        'workspace, community, or home?',
    textNe:
        'के अनलाइनमा आएका धम्की वा दुर्व्यवहार तपाईंको कार्यस्थल, '
        'समाज वा घरसम्म आइपुगेको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 10,
    textEn:
        'Have you felt unsafe, anxious, or isolated because of things '
        'happening to you online or offline?',
    textNe:
        'के अनलाइन वा अफलाइन भइरहेका घटनाहरूका कारण तपाईंले असुरक्षित, '
        'चिन्तित वा एक्लो महसुस गर्नुभएको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 11,
    textEn:
        'Has someone pressurized or blackmailed you financially or '
        'emotionally using digital means?',
    textNe:
        'के कसैले डिजिटल माध्यम प्रयोग गरेर तपाईंलाई आर्थिक वा '
        'भावनात्मक रूपमा ब्ल्याकमेल गरेको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 12,
    textEn:
        'Have you had to stop using social media, change your phone '
        'number, or change routines due to threats?',
    textNe:
        'के धम्कीका कारण तपाईंले सामाजिक सञ्जाल छोड्नु परेको, फोन नम्बर '
        'फेर्नु परेको वा दिनचर्या बदल्नु परेको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 13,
    textEn:
        'Has anyone in authority or power used digital communications '
        'to silence or threaten you?',
    textNe:
        'के कुनै प्रभावशाली वा अधिकार प्राप्त व्यक्तिले डिजिटल माध्यमबाट '
        'तपाईंको आवाज दबाउने वा धम्क्याउने प्रयास गरेको छ?',
    options: defaultFrequencyOptions,
  ),
  ScreeningQuestion(
    id: 14,
    textEn:
        'Do you know who the person or group causing these online/offline '
        'incidents is?',
    textNe:
        'के तपाईंलाई यी अनलाइन वा अफलाइन घटनाहरू गराउने व्यक्ति वा '
        'समूह को हो भन्ने थाहा छ?',
    options: [
      ScreeningOption(
        id: 'known_person',
        labelEn: 'Yes, I know them',
        labelNe: 'हो, म चिन्छु',
      ),
      ScreeningOption(
        id: 'suspected',
        labelEn: 'I have suspicion',
        labelNe: 'शंका छ',
      ),
      ScreeningOption(
        id: 'anonymous',
        labelEn: 'Completely anonymous',
        labelNe: 'अपरिचित वा अज्ञात',
      ),
      ScreeningOption(
        id: 'multiple',
        labelEn: 'Multiple individuals',
        labelNe: 'धेरै व्यक्तिहरू',
      ),
    ],
  ),
  ScreeningQuestion(
    id: 15,
    textEn:
        'Would you like information on immediate legal, psychological, '
        'or digital safety support services?',
    textNe:
        'के तपाईं तत्काल कानुनी, मनोसामाजिक वा डिजिटल सुरक्षा सहायता '
        'सम्बन्धी जानकारी चाहनुहुन्छ?',
    options: [
      ScreeningOption(
        id: 'immediate_help',
        labelEn: 'Yes, immediately',
        labelNe: 'हो, तुरुन्तै चाहिन्छ',
      ),
      ScreeningOption(
        id: 'want_info',
        labelEn: 'Yes, for future reference',
        labelNe: 'हो, जानकारीका लागि',
      ),
      ScreeningOption(
        id: 'maybe_later',
        labelEn: 'Maybe later',
        labelNe: 'पछि सोच्नेछु',
      ),
      ScreeningOption(
        id: 'no_need',
        labelEn: 'Not right now',
        labelNe: 'अहिले आवश्यक छैन',
      ),
    ],
  ),
];

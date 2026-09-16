import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T7: THREATS & BLACKMAIL (threats)
// =============================================================================

/// T7 Gateway Question
const ScreeningQuestion gatewayThreats = ScreeningQuestion(
  id: 'Q07_T7_G',
  typeId: IncidentCategory.threats,
  unlockMinPoints: 2,
  textEn:
      'Have you received direct or indirect threats of physical violence, '
      'harm, or blackmail online?',
  textNe:
      'के तपाईंले अनलाइनमा भौतिक आक्रमण, हानि वा ब्ल्याकमेल गर्ने प्रत्यक्ष वा '
      'अप्रत्यक्ष धम्की पाउनुभएको छ?',
  options: defaultFrequencyOptions,
);

/// T7 Follow-up Question (Unlocked if Q07_T7_G scores >= 2)
const ScreeningQuestion followUpThreats = ScreeningQuestion(
  id: 'Q07_T7_F',
  typeId: IncidentCategory.threats,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q07_T7_G',
  unlockMinPoints: 2,
  textEn:
      'Has the perpetrator specified weapons, exact locations, or '
      'imminent timelines for carrying out the threats?',
  textNe:
      'के धम्की दिने व्यक्तिले हतियार, निश्चित स्थान वा तुरुन्तै आक्रमण '
      'गर्ने समय तोकेर धम्क्याएको छ?',
  options: defaultFrequencyOptions,
);

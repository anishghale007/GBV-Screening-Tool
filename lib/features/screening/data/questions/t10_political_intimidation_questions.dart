import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T10: POLITICAL INTIMIDATION (politicalIntimidation)
// =============================================================================

/// T10 Gateway Question
const ScreeningQuestion gatewayPoliticalIntimidation = ScreeningQuestion(
  id: 'Q10_T10_G',
  typeId: IncidentCategory.politicalIntimidation,
  unlockMinPoints: 2,
  textEn:
      'Have you been systematically attacked, silenced, or intimidated online '
      'due to your political beliefs, activism, or public opinions?',
  textNe:
      'के तपाईंको राजनीतिक विचार, सक्रियता वा अभिव्यक्तिका कारण तपाईंमाथि '
      'अनलाइनमा योजनाबद्ध आक्रमण वा धम्की दिइएको छ?',
  options: defaultFrequencyOptions,
);

/// T10 Follow-up Question (Unlocked if Q10_T10_G scores >= 2)
const ScreeningQuestion followUpPoliticalIntimidation = ScreeningQuestion(
  id: 'Q10_T10_F',
  typeId: IncidentCategory.politicalIntimidation,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q10_T10_G',
  unlockMinPoints: 2,
  textEn:
      'Have official authorities, party cadres, or organized bots targeted '
      'you or your family to force you to delete your posts?',
  textNe:
      'के तपाईंलाई आफ्ना भनाइ हटाउन बाध्य पार्न राजनीतिक दल, कार्यकर्ता वा '
      'संगठित समूहले तपाईं वा परिवारलाई लक्षित गरेका छन्?',
  options: defaultFrequencyOptions,
);

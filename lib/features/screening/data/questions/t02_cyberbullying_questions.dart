import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T2: CYBERBULLYING (cyberbullying)
// =============================================================================

/// T2 Gateway Question
const ScreeningQuestion gatewayCyberbullying = ScreeningQuestion(
  id: 'Q02_T2_G',
  typeId: IncidentCategory.cyberbullying,
  unlockMinPoints: 2,
  textEn:
      'Have you been targeted with abusive, hostile, or intimidating comments '
      'and messages online?',
  textNe:
      'के तपाईंले अनलाइनमा अपमानजनक, शत्रुतापूर्ण वा धम्कीपूर्ण टिप्पणी र '
      'सन्देशहरूको सामना गर्नुभएको छ?',
  options: defaultFrequencyOptions,
);

/// T2 Follow-up Question (Unlocked if Q02_T2_G scores >= 2)
const ScreeningQuestion followUpCyberbullying = ScreeningQuestion(
  id: 'Q02_T2_F',
  typeId: IncidentCategory.cyberbullying,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q02_T2_G',
  unlockMinPoints: 2,
  textEn:
      'Is the bullying coordinated by multiple people or organized hate '
      'groups flooding your profile/messages?',
  textNe:
      'के धेरै व्यक्तिहरू मिलेर योजनाबद्ध रूपमा तपाईंको प्रोफाइल वा '
      'सन्देशहरूमा सामूहिक दुर्व्यवहार गरिरहेका छन्?',
  options: defaultFrequencyOptions,
);

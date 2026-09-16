import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T5: SHARING DETAILS / DOXXING (sharingDetails)
// =============================================================================

/// T5 Gateway Question
const ScreeningQuestion gatewaySharingDetails = ScreeningQuestion(
  id: 'Q05_T5_G',
  typeId: IncidentCategory.sharingDetails,
  unlockMinPoints: 2,
  textEn:
      'Has someone posted your personal phone number, home address, or '
      'private contact details publicly to intimidate you?',
  textNe:
      'के कसैले तपाईंलाई तनाव दिन तपाईंको फोन नम्बर, ठेगाना वा व्यक्तिगत '
      'विवरण सार्वजनिक रूपमा पोस्ट गरेको छ?',
  options: defaultFrequencyOptions,
);

/// T5 Follow-up Question (Unlocked if Q05_T5_G scores >= 2)
const ScreeningQuestion followUpSharingDetails = ScreeningQuestion(
  id: 'Q05_T5_F',
  typeId: IncidentCategory.sharingDetails,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q05_T5_G',
  unlockMinPoints: 2,
  textEn:
      'Have strangers started calling, messaging, or visiting you as a '
      'result of your private details being exposed (doxxing)?',
  textNe:
      'के तपाईंको विवरण बाहिरिएका कारण अपरिचित व्यक्तिहरूले फोन गर्ने, '
      'सन्देश पठाउने वा घरसम्म आउने गरेका छन्?',
  options: defaultFrequencyOptions,
);

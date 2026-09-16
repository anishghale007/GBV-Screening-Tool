import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T8: OFFLINE ESCALATION (offlineEscalation)
// =============================================================================

/// T8 Gateway Question
const ScreeningQuestion gatewayOfflineEscalation = ScreeningQuestion(
  id: 'Q08_T8_G',
  typeId: IncidentCategory.offlineEscalation,
  unlockMinPoints: 2,
  textEn:
      'Has any online harassment or threat escalated into physical following, '
      'visits to your home, workplace, or public spaces?',
  textNe:
      'के अनलाइनका धम्की वा दुर्व्यवहार तपाईंको घर, कार्यस्थल वा '
      'बाटोमा प्रत्यक्ष पछ्याउने वा देखा पर्नेसम्म पुगेको छ?',
  options: defaultFrequencyOptions,
);

/// T8 Follow-up Question (Unlocked if Q08_T8_G scores >= 2)
const ScreeningQuestion followUpOfflineEscalation = ScreeningQuestion(
  id: 'Q08_T8_F',
  typeId: IncidentCategory.offlineEscalation,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q08_T8_G',
  unlockMinPoints: 2,
  textEn:
      'Have you had to change your daily routines, relocate, or avoid '
      'leaving your house out of fear for your physical safety?',
  textNe:
      'के शारीरिक सुरक्षाको डरले तपाईंले आफ्नो दैनिक तालिका बदल्नु परेको, '
      'बासस्थान सर्नु परेको वा घर बाहिर निस्कन डराउनु परेको छ?',
  options: defaultFrequencyOptions,
);

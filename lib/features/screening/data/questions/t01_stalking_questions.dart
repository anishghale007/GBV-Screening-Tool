import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T1: STALKING (stalking)
// =============================================================================

/// T1 Gateway Question
const ScreeningQuestion gatewayStalking = ScreeningQuestion(
  id: 'Q01_T1_G',
  typeId: IncidentCategory.stalking,
  unlockMinPoints: 2,
  textEn:
      'In the last few months, has someone repeatedly tracked your online '
      'activities, messages, or location without your consent?',
  textNe:
      'पछिल्ला केही महिनाहरूमा, के कसैले तपाईंको सहमति बिना तपाईंको अनलाइन '
      'गतिविधि, सन्देश वा स्थान निरन्तर निगरानी गरेको छ?',
  options: defaultFrequencyOptions,
);

/// T1 Follow-up Question (Unlocked if Q01_T1_G scores >= 2)
const ScreeningQuestion followUpStalking = ScreeningQuestion(
  id: 'Q01_T1_F',
  typeId: IncidentCategory.stalking,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q01_T1_G',
  unlockMinPoints: 2,
  textEn:
      'Has the person monitoring you hacked into your accounts, installed '
      'spyware on your phone, or contacted your friends/family?',
  textNe:
      'के निगरानी गर्ने व्यक्तिले तपाईंको खाता ह्याक गरेको, फोनमा जासुसी एप '
      'राखेको वा साथीभाइ/परिवारलाई सम्पर्क गरेको छ?',
  options: defaultFrequencyOptions,
);

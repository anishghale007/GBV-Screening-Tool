import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T6: FAKE ACCOUNTS / IMPERSONATION (fakeAccounts)
// =============================================================================

/// T6 Gateway Question
const ScreeningQuestion gatewayFakeAccounts = ScreeningQuestion(
  id: 'Q06_T6_G',
  typeId: IncidentCategory.fakeAccounts,
  unlockMinPoints: 2,
  textEn:
      'Has someone created fake social media accounts or profiles '
      'impersonating you or damaging your reputation?',
  textNe:
      'के कसैले तपाईंको नाममा नक्कली खाता बनाएर तपाईंको पहिचान दुरुपयोग गरेको '
      'वा बदनाम गर्ने प्रयास गरेको छ?',
  options: defaultFrequencyOptions,
);

/// T6 Follow-up Question (Unlocked if Q06_T6_G scores >= 2)
const ScreeningQuestion followUpFakeAccounts = ScreeningQuestion(
  id: 'Q06_T6_F',
  typeId: IncidentCategory.fakeAccounts,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q06_T6_G',
  unlockMinPoints: 2,
  textEn:
      'Are the fake profiles reaching out to your contacts or posting '
      'offensive content pretending to be you?',
  textNe:
      'के नक्कली खाताबाट तपाईंका चिनजानका व्यक्तिहरूसँग सम्पर्क गर्ने वा '
      'तपाईंको नामबाट आपत्तिजनक सामग्री पोस्ट गर्ने गरिएको छ?',
  options: defaultFrequencyOptions,
);

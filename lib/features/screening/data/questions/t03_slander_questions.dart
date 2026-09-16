import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T3: SLANDER & DEFAMATION (slander)
// =============================================================================

/// T3 Gateway Question
const ScreeningQuestion gatewaySlander = ScreeningQuestion(
  id: 'Q03_T3_G',
  typeId: IncidentCategory.slander,
  unlockMinPoints: 2,
  textEn:
      'Has someone spread false rumors, fabricated stories, or defamatory '
      'statements about you online?',
  textNe:
      'के कसैले तपाईंको बारेमा अनलाइनमा झूटो हल्ला, बनावटी कुरा '
      'वा चरित्र हत्या गर्ने सामग्री फैलाएको छ?',
  options: defaultFrequencyOptions,
);

/// T3 Follow-up Question (Unlocked if Q03_T3_G scores >= 2)
const ScreeningQuestion followUpSlander = ScreeningQuestion(
  id: 'Q03_T3_F',
  typeId: IncidentCategory.slander,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q03_T3_G',
  unlockMinPoints: 2,
  textEn:
      'Has the defamatory material affected your workplace, family '
      'relationships, or caused public shaming in your community?',
  textNe:
      'के चरित्र हत्या गर्ने सामग्रीले तपाईंको जागिर, पारिवारिक सम्बन्ध '
      'वा समाजमा अपमान पुर्याएको छ?',
  options: defaultFrequencyOptions,
);

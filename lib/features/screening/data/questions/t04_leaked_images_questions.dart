import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T4: LEAKED / INTIMATE IMAGES (leakedImages)
// =============================================================================

/// T4 Gateway Question
const ScreeningQuestion gatewayLeakedImages = ScreeningQuestion(
  id: 'Q04_T4_G',
  typeId: IncidentCategory.leakedImages,
  unlockMinPoints: 2,
  textEn:
      'Has anyone shared, or threatened to share, your private photos, '
      'videos, or intimate content without your permission?',
  textNe:
      'के कसैले तपाईंको सहमति बिना तपाईंको निजी तस्बिर, भिडियो वा व्यक्तिगत '
      'सामग्री सार्वजनिक गरेको वा गर्ने धम्की दिएको छ?',
  options: defaultFrequencyOptions,
);

/// T4 Follow-up Question (Unlocked if Q04_T4_G scores >= 2)
const ScreeningQuestion followUpLeakedImages = ScreeningQuestion(
  id: 'Q04_T4_F',
  typeId: IncidentCategory.leakedImages,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q04_T4_G',
  unlockMinPoints: 2,
  textEn:
      'Are they demanding money, sexual favors, or further intimate media '
      'in exchange for not publishing the images (sextortion)?',
  textNe:
      'के तस्बिरहरू सार्वजनिक नगर्नका लागि पैसा, यौन सम्बन्ध वा थप निजी '
      'सामग्री माग गरेर ब्ल्याकमेल गरिएको छ?',
  options: defaultFrequencyOptions,
);

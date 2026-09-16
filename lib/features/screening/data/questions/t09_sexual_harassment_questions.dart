import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/core/enums/question_level.dart';
import 'package:gbv/features/screening/data/questions/shared_options.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// =============================================================================
// T9: SEXUAL HARASSMENT (sexualHarassment)
// =============================================================================

/// T9 Gateway Question
const ScreeningQuestion gatewaySexualHarassment = ScreeningQuestion(
  id: 'Q09_T9_G',
  typeId: IncidentCategory.sexualHarassment,
  unlockMinPoints: 2,
  textEn:
      'Has someone sent you unwanted sexual remarks, explicit media, or '
      'pressured you into sexual conversations online?',
  textNe:
      'के कसैले तपाईंलाई अवाञ्छित यौनजन्य प्रस्ताव, अश्लील तस्बिर/भिडियो '
      'पठाएको वा अनलाइनमा यौन कुराकानी गर्न दबाब दिएको छ?',
  options: defaultFrequencyOptions,
);

/// T9 Follow-up Question (Unlocked if Q09_T9_G scores >= 2)
const ScreeningQuestion followUpSexualHarassment = ScreeningQuestion(
  id: 'Q09_T9_F',
  typeId: IncidentCategory.sexualHarassment,
  level: QuestionLevel.followUp,
  unlockedByQId: 'Q09_T9_G',
  unlockMinPoints: 2,
  textEn:
      'Is the perpetrator in a position of power over you (e.g., employer, '
      'teacher, family member, landlord)?',
  textNe:
      'के दुर्व्यवहार गर्ने व्यक्ति तपाईं भन्दा शक्तिशाली पद वा हैसियतमा छ '
      '(जस्तै रोजगारदाता, शिक्षक, घरबेटी वा पारिवारिक सदस्य)?',
  options: defaultFrequencyOptions,
);

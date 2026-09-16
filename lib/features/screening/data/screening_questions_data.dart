import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/features/screening/data/questions/t01_stalking_questions.dart';
import 'package:gbv/features/screening/data/questions/t02_cyberbullying_questions.dart';
import 'package:gbv/features/screening/data/questions/t03_slander_questions.dart';
import 'package:gbv/features/screening/data/questions/t04_leaked_images_questions.dart';
import 'package:gbv/features/screening/data/questions/t05_sharing_details_questions.dart';
import 'package:gbv/features/screening/data/questions/t06_fake_accounts_questions.dart';
import 'package:gbv/features/screening/data/questions/t07_threats_questions.dart';
import 'package:gbv/features/screening/data/questions/t08_offline_escalation_questions.dart';
import 'package:gbv/features/screening/data/questions/t09_sexual_harassment_questions.dart';
import 'package:gbv/features/screening/data/questions/t10_political_intimidation_questions.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

// Re-export all question files for single-import convenience
export 'questions/shared_options.dart';
export 'questions/t01_stalking_questions.dart';
export 'questions/t02_cyberbullying_questions.dart';
export 'questions/t03_slander_questions.dart';
export 'questions/t04_leaked_images_questions.dart';
export 'questions/t05_sharing_details_questions.dart';
export 'questions/t06_fake_accounts_questions.dart';
export 'questions/t07_threats_questions.dart';
export 'questions/t08_offline_escalation_questions.dart';
export 'questions/t09_sexual_harassment_questions.dart';
export 'questions/t10_political_intimidation_questions.dart';

// =============================================================================
// REGISTRY & LOOKUP TABLES
// =============================================================================

/// Map of each incident category to its Gateway question.
const Map<IncidentCategory, ScreeningQuestion> gatewayQuestionsMap = {
  IncidentCategory.stalking: gatewayStalking,
  IncidentCategory.cyberbullying: gatewayCyberbullying,
  IncidentCategory.slander: gatewaySlander,
  IncidentCategory.leakedImages: gatewayLeakedImages,
  IncidentCategory.sharingDetails: gatewaySharingDetails,
  IncidentCategory.fakeAccounts: gatewayFakeAccounts,
  IncidentCategory.threats: gatewayThreats,
  IncidentCategory.offlineEscalation: gatewayOfflineEscalation,
  IncidentCategory.sexualHarassment: gatewaySexualHarassment,
  IncidentCategory.politicalIntimidation: gatewayPoliticalIntimidation,
};

/// Map of each incident category to its Follow-up question.
const Map<IncidentCategory, ScreeningQuestion> followUpQuestionsMap = {
  IncidentCategory.stalking: followUpStalking,
  IncidentCategory.cyberbullying: followUpCyberbullying,
  IncidentCategory.slander: followUpSlander,
  IncidentCategory.leakedImages: followUpLeakedImages,
  IncidentCategory.sharingDetails: followUpSharingDetails,
  IncidentCategory.fakeAccounts: followUpFakeAccounts,
  IncidentCategory.threats: followUpThreats,
  IncidentCategory.offlineEscalation: followUpOfflineEscalation,
  IncidentCategory.sexualHarassment: followUpSexualHarassment,
  IncidentCategory.politicalIntimidation: followUpPoliticalIntimidation,
};

/// Generic default questions shown when zero incident categories are selected
/// (Screen 2 "Not sure" / empty).
/// Uses Q02 (Cyberbullying Gateway), Q03 (Slander Gateway), and Q05 (Sharing
/// Details Gateway) as safe defaults.
const List<ScreeningQuestion> defaultGenericQuestions = [
  gatewayCyberbullying, // Q02
  gatewaySlander, // Q03
  gatewaySharingDetails, // Q05
];

/// All available sample screening questions list.
const List<ScreeningQuestion> defaultScreeningQuestions = [
  gatewayStalking,
  followUpStalking,
  gatewayCyberbullying,
  followUpCyberbullying,
  gatewaySlander,
  followUpSlander,
  gatewayLeakedImages,
  followUpLeakedImages,
  gatewaySharingDetails,
  followUpSharingDetails,
  gatewayFakeAccounts,
  followUpFakeAccounts,
  gatewayThreats,
  followUpThreats,
  gatewayOfflineEscalation,
  followUpOfflineEscalation,
  gatewaySexualHarassment,
  followUpSexualHarassment,
  gatewayPoliticalIntimidation,
  followUpPoliticalIntimidation,
];

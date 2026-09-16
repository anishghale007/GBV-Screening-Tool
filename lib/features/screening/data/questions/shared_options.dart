import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/features/screening/models/screening_question.dart';

/// Standard 4-level frequency response options with points.
const List<ScreeningOption> defaultFrequencyOptions = [
  ScreeningOption(
    id: 'opt_often',
    labelEn: 'Yes, often',
    labelNe: 'हो, धेरैजसो',
    points: 3,
  ),
  ScreeningOption(
    id: 'opt_sometimes',
    labelEn: 'Yes, sometimes',
    labelNe: 'हो, कहिलेकाहीं',
    points: 2,
  ),
  ScreeningOption(
    id: 'opt_rarely',
    labelEn: 'Rarely',
    labelNe: 'कमै मात्र',
    points: 1,
  ),
  ScreeningOption(
    id: 'opt_never',
    labelEn: 'No, never',
    labelNe: 'होइन, कहिल्यै होइन',
  ),
];

/// Category severity weight mapping used for retention priority when the
/// 15-question hard cap is reached.
/// Higher number = Higher priority to retain. Threats and Offline Escalation
/// are dropped last.
const Map<IncidentCategory, int> categorySeverityRank = {
  IncidentCategory.threats: 10, // T7 - Dropped last
  IncidentCategory.offlineEscalation: 9, // T8 - Dropped second to last
  IncidentCategory.sexualHarassment: 8, // T9
  IncidentCategory.leakedImages: 7, // T4
  IncidentCategory.stalking: 6, // T1
  IncidentCategory.sharingDetails: 5, // T5
  IncidentCategory.fakeAccounts: 4, // T6
  IncidentCategory.politicalIntimidation: 3, // T10
  IncidentCategory.cyberbullying: 2, // T2
  IncidentCategory.slander: 1, // T3 - Dropped first
};

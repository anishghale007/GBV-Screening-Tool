import 'package:gbv/core/constants/asset_constants.dart';
import 'package:gbv/core/enums/incident_category.dart';
import 'package:gbv/features/screening/models/incident_type_model.dart';
import 'package:gbv/l10n/l10n.dart';

List<IncidentTypeModel> getIncidentTypes(AppLocalizations l10n) => [
  IncidentTypeModel(
    category: IncidentCategory.stalking,
    iconPath: AssetConstants.userSearchIcon,
    title: l10n.categoryStalking,
    description: l10n.categoryStalkingDesc,
  ),
  IncidentTypeModel(
    category: IncidentCategory.cyberbullying,
    iconPath: AssetConstants.messageWarningIcon,
    title: l10n.categoryCyberbullying,
    description: l10n.categoryCyberbullyingDesc,
  ),
  IncidentTypeModel(
    category: IncidentCategory.slander,
    iconPath: AssetConstants.megaphoneOffIcon,
    title: l10n.categorySlander,
    description: l10n.categorySlanderDesc,
  ),
  IncidentTypeModel(
    category: IncidentCategory.leakedImages,
    iconPath: AssetConstants.imageDownloadIcon,
    title: l10n.categoryLeakedImages,
    description: l10n.categoryLeakedImagesDesc,
  ),
  IncidentTypeModel(
    category: IncidentCategory.sharingDetails,
    iconPath: AssetConstants.userLockIcon,
    title: l10n.categorySharingDetails,
    description: l10n.categorySharingDetailsDesc,
  ),
  IncidentTypeModel(
    category: IncidentCategory.fakeAccounts,
    iconPath: AssetConstants.crossIcon,
    title: l10n.categoryFakeAccounts,
    description: l10n.categoryFakeAccountsDesc,
  ),
  IncidentTypeModel(
    category: IncidentCategory.threats,
    iconPath: AssetConstants.alertIcon,
    title: l10n.categoryThreats,
    description: l10n.categoryThreatsDesc,
  ),
  IncidentTypeModel(
    category: IncidentCategory.offlineEscalation,
    iconPath: AssetConstants.buildingIcon,
    title: l10n.categoryOfflineEscalation,
    description: l10n.categoryOfflineEscalationDesc,
  ),
  IncidentTypeModel(
    category: IncidentCategory.sexualHarassment,
    iconPath: AssetConstants.heartCrackIcon,
    title: l10n.categorySexualHarassment,
    description: l10n.categorySexualHarassmentDesc,
  ),
  IncidentTypeModel(
    category: IncidentCategory.politicalIntimidation,
    iconPath: AssetConstants.flagIcon,
    title: l10n.categoryPoliticalIntimidation,
    description: l10n.categoryPoliticalIntimidationDesc,
  ),
];

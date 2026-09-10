import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/view/accessibility_page.dart';
import 'package:gbv/injection_container.dart';
import 'package:go_router/go_router.dart';

/// Available incident categories for multi-selection.
enum IncidentCategory {
  stalking,
  cyberbullying,
  slander,
  leakedImages,
  sharingDetails,
  fakeAccounts,
  threats,
  offlineEscalation,
  sexualHarassment,
  politicalIntimidation,
}

/// Incident selection screen allowing users to choose all categories
/// that describe their situation, with TTS and multi-select support.
class IncidentSelectionPage extends StatefulWidget {
  const IncidentSelectionPage({super.key});

  @override
  State<IncidentSelectionPage> createState() => _IncidentSelectionPageState();
}

class _IncidentSelectionPageState extends State<IncidentSelectionPage> {
  final TtsHelper _tts = sl<TtsHelper>();
  StreamSubscription<TtsState>? _ttsSubscription;

  final Set<IncidentCategory> _selected = {};
  bool _isNotSureSelected = false;
  String? _activeSpeechText;

  @override
  void initState() {
    super.initState();
    _ttsSubscription = _tts.stateStream.listen((state) {
      if (!mounted) return;
      if (state == TtsState.stopped) {
        setState(() => _activeSpeechText = null);
      }
    });
  }

  @override
  void dispose() {
    _ttsSubscription?.cancel();
    _tts.stop();
    super.dispose();
  }

  bool get _canContinue => _selected.isNotEmpty || _isNotSureSelected;

  void _toggleCategory(IncidentCategory category) {
    setState(() {
      if (_selected.contains(category)) {
        _selected.remove(category);
      } else {
        _selected.add(category);
        _isNotSureSelected = false;
      }
    });
  }

  void _toggleNotSure() {
    setState(() {
      _isNotSureSelected = !_isNotSureSelected;
      if (_isNotSureSelected) {
        _selected.clear();
      }
    });
  }

  Future<void> _playAudio(String text) async {
    if (_activeSpeechText == text && _tts.isPlaying) {
      await _tts.stop();
      if (mounted) setState(() => _activeSpeechText = null);
      return;
    }

    final languageCode = context.read<LocaleCubit>().state.languageCode;
    final ttsLanguage = languageCode == 'ne' ? 'ne-NP' : 'en-US';

    if (mounted) setState(() => _activeSpeechText = text);
    await _tts.stop();
    await _tts.speak(text, languageCode: ttsLanguage);
  }

  void _onContinue() {
    // Navigate to the pathway / questions flow
    context.push(AppRoutes.pathway);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final categories = <_CategoryItemData>[
      _CategoryItemData(
        category: IncidentCategory.stalking,
        iconPath: AssetConstants.userSearchIcon,
        title: l10n.categoryStalking,
        description: l10n.categoryStalkingDesc,
      ),
      _CategoryItemData(
        category: IncidentCategory.cyberbullying,
        iconPath: AssetConstants.messageWarningIcon,
        title: l10n.categoryCyberbullying,
        description: l10n.categoryCyberbullyingDesc,
      ),
      _CategoryItemData(
        category: IncidentCategory.slander,
        iconPath: AssetConstants.megaphoneOffIcon,
        title: l10n.categorySlander,
        description: l10n.categorySlanderDesc,
      ),
      _CategoryItemData(
        category: IncidentCategory.leakedImages,
        iconPath: AssetConstants.imageDownloadIcon,
        title: l10n.categoryLeakedImages,
        description: l10n.categoryLeakedImagesDesc,
      ),
      _CategoryItemData(
        category: IncidentCategory.sharingDetails,
        iconPath: AssetConstants.userLockIcon,
        title: l10n.categorySharingDetails,
        description: l10n.categorySharingDetailsDesc,
      ),
      _CategoryItemData(
        category: IncidentCategory.fakeAccounts,
        iconPath: AssetConstants.crossIcon,
        title: l10n.categoryFakeAccounts,
        description: l10n.categoryFakeAccountsDesc,
      ),
      _CategoryItemData(
        category: IncidentCategory.threats,
        iconPath: AssetConstants.alertIcon,
        title: l10n.categoryThreats,
        description: l10n.categoryThreatsDesc,
      ),
      _CategoryItemData(
        category: IncidentCategory.offlineEscalation,
        iconPath: AssetConstants.buildingIcon,
        title: l10n.categoryOfflineEscalation,
        description: l10n.categoryOfflineEscalationDesc,
      ),
      _CategoryItemData(
        category: IncidentCategory.sexualHarassment,
        iconPath: AssetConstants.heartCrackIcon,
        title: l10n.categorySexualHarassment,
        description: l10n.categorySexualHarassmentDesc,
      ),
      _CategoryItemData(
        category: IncidentCategory.politicalIntimidation,
        iconPath: AssetConstants.flagIcon,
        title: l10n.categoryPoliticalIntimidation,
        description: l10n.categoryPoliticalIntimidationDesc,
      ),
    ];

    return AppScaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(l10n.screeningTitle, style: AppTextStyles.headlineSmall),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.sm),
            child: LocaleSwitch(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AccessibilityBottomSheet.show(context),
        tooltip: l10n.accessibilitySettings,
        child: const Icon(Icons.accessible_forward_rounded),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.md),
                  // Question heading
                  Text(
                    l10n.incidentSelectionTitle,
                    style: AppTextStyles.headlineLarge.copyWith(height: 1.15),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Subtitle
                  Text(
                    l10n.incidentSelectionSubtitle,
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Category Cards
                  ...categories.map((data) {
                    final isSelected = _selected.contains(data.category);
                    final speechKey = '${data.title}. ${data.description}';
                    final isPlaying = _activeSpeechText == speechKey;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
                      child: _IncidentCategoryTile(
                        iconPath: data.iconPath,
                        title: data.title,
                        description: data.description,
                        isSelected: isSelected,
                        isPlaying: isPlaying,
                        onTap: () => _toggleCategory(data.category),
                        onAudioTap: () => _playAudio(speechKey),
                      ),
                    );
                  }),

                  const SizedBox(height: AppSpacing.xs),

                  // "I'm not sure / skip selection" option
                  _NotSureTile(
                    label: l10n.notSureSkipSelection,
                    isSelected: _isNotSureSelected,
                    onTap: _toggleNotSure,
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),

          // Bottom Continue Button
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: AppButton(
              text: l10n.continueButton,
              onPressed: _canContinue ? _onContinue : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Supporting Data & Widgets
// ────────────────────────────────────────────────────────────────────────────

class _CategoryItemData {
  const _CategoryItemData({
    required this.category,
    required this.iconPath,
    required this.title,
    required this.description,
  });

  final IncidentCategory category;
  final String iconPath;
  final String title;
  final String description;
}

/// Selectable Incident Category Tile.
class _IncidentCategoryTile extends StatelessWidget {
  const _IncidentCategoryTile({
    required this.iconPath,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.isPlaying,
    required this.onTap,
    required this.onAudioTap,
  });

  final String iconPath;
  final String title;
  final String description;
  final bool isSelected;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onAudioTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? AppColors.primary : AppColors.border;
    final borderWidth = isSelected ? 2.0 : 1.2;

    return Material(
      color: AppColors.surface,
      borderRadius: AppSpacing.borderRadiusMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.borderRadiusMd,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Row(
            children: [
              // Icon Circle
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : AppColors.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),

              // Audio narration button
              _AudioIconButton(
                onTap: onAudioTap,
                isPlaying: isPlaying,
              ),
              const SizedBox(width: AppSpacing.sm),

              // Custom Rounded Checkbox
              _CustomCheckbox(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Rounded Checkbox matching the design reference.
class _CustomCheckbox extends StatelessWidget {
  const _CustomCheckbox({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: 1.5,
        ),
      ),
      child: isSelected
          ? const Center(
              child: Icon(
                Icons.check_rounded,
                size: 16,
                color: AppColors.textOnPrimary,
              ),
            )
          : null,
    );
  }
}

/// Audio narration button.
class _AudioIconButton extends StatelessWidget {
  const _AudioIconButton({
    required this.onTap,
    this.isPlaying = false,
  });

  final VoidCallback onTap;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isPlaying ? AppColors.primary : AppColors.surfaceVariant;
    final iconColor =
        isPlaying ? AppColors.textOnPrimary : AppColors.textSecondary;
    final borderColor =
        isPlaying ? AppColors.primary : AppColors.borderSelected;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: SvgPicture.asset(
            AssetConstants.audioLinesIcon,
            height: 18,
            width: 18,
            colorFilter: ColorFilter.mode(
              iconColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

/// "I'm not sure / skip selection" option tile.
class _NotSureTile extends StatelessWidget {
  const _NotSureTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppSpacing.borderRadiusMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.borderRadiusMd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 2.0 : 1.2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

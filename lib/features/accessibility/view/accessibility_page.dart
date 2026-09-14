import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbv/common/widgets/section_divider.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';
import 'package:gbv/features/accessibility/widgets/accessibility_section_header.dart';
import 'package:gbv/features/accessibility/widgets/accessibility_toggle_row.dart';
import 'package:gbv/features/accessibility/widgets/language_selector_modal.dart';
import 'package:gbv/features/accessibility/widgets/text_size_preview_card.dart';

/// Accessibility settings bottom sheet.
///
/// Features a sticky top drag handle, interactive Vision & Reading,
/// Motor & Interactions controls wired to [AccessibilityBloc],
/// and app language switcher powered by [LocaleCubit].
class AccessibilityBottomSheet extends StatelessWidget {
  const AccessibilityBottomSheet({super.key});

  /// Helper to open the accessibility bottom sheet from any screen.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AccessibilityBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isNepali = context.watch<LocaleCubit>().isNepali;
    final currentLanguageName = isNepali ? l10n.nepali : l10n.english;

    return BlocBuilder<AccessibilityBloc, AccessibilityState>(
      builder: (context, state) {
        final settings = state.settings;
        final isHaptic = settings.isHapticFeedbackEnabled;

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.9,
          ),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pinned sticky top section with drag handle & title
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: AppSpacing.lg,
                    right: AppSpacing.lg,
                    bottom: AppSpacing.sm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 38,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        l10n.accessibilitySettings,
                        style: AppTextStyles.headlineMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable settings body
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.xs,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Audio Settings ──────────────────────────────────
                        AccessibilitySectionHeader(
                          iconPath: AssetConstants.volumenIcon,
                          title: l10n.audioSettingsTitle,
                        ),
                        AccessibilityToggleRow(
                          title: l10n.autoPlayAudio,
                          subtitle: l10n.autoPlayAudioSubtitle,
                          value: settings.isAutoPlayAudioEnabled,
                          isEnabled: false,
                          onChanged: null,
                        ),
                        AccessibilityToggleRow(
                          title: l10n.screenReaderMode,
                          subtitle: l10n.screenReaderModeSubtitle,
                          value: settings.isScreenReaderModeEnabled,
                          isEnabled: false,
                          onChanged: null,
                        ),

                        const SectionDivider(),

                        // ── Vision & Reading ────────────────────────────────
                        AccessibilitySectionHeader(
                          iconPath: AssetConstants.eyeIcon,
                          title: l10n.visionAndReadingTitle,
                        ),
                        const SizedBox(height: AppSpacing.xs),

                        // Text size selector and live preview
                        TextSizePreviewCard(
                          selectedOption: settings.textSize,
                          onChanged: (option) {
                            HapticHelper.selectionClick(isEnabled: isHaptic);
                            context
                                .read<AccessibilityBloc>()
                                .add(UpdateTextSize(option));
                          },
                        ),
                        const SizedBox(height: AppSpacing.sm),

                        AccessibilityToggleRow(
                          title: l10n.highContrast,
                          subtitle: l10n.highContrastSubtitle,
                          value: settings.isHighContrastEnabled,
                          onChanged: (val) {
                            HapticHelper.lightImpact(isEnabled: isHaptic);
                            context
                                .read<AccessibilityBloc>()
                                .add(ToggleHighContrast(isEnabled: val));
                          },
                        ),
                        AccessibilityToggleRow(
                          title: l10n.dyslexiaMode,
                          subtitle: l10n.dyslexiaFontSubtitle,
                          value: settings.isDyslexiaModeEnabled,
                          onChanged: (val) {
                            HapticHelper.lightImpact(isEnabled: isHaptic);
                            context
                                .read<AccessibilityBloc>()
                                .add(ToggleDyslexiaFont(isEnabled: val));
                          },
                        ),

                        const SectionDivider(),

                        // ── Motor & Interactions ────────────────────────────
                        AccessibilitySectionHeader(
                          iconPath: AssetConstants.handIcon,
                          title: l10n.motorAndInteractionsTitle,
                        ),
                        AccessibilityToggleRow(
                          title: l10n.largeTouchTargets,
                          subtitle: l10n.largeTouchTargetsSubtitle,
                          value: settings.isLargeTouchTargetsEnabled,
                          onChanged: (val) {
                            HapticHelper.lightImpact(isEnabled: isHaptic);
                            context
                                .read<AccessibilityBloc>()
                                .add(ToggleLargeTouchTargets(isEnabled: val));
                          },
                        ),
                        AccessibilityToggleRow(
                          title: l10n.hapticFeedback,
                          subtitle: l10n.hapticFeedbackSubtitle,
                          value: settings.isHapticFeedbackEnabled,
                          onChanged: (val) {
                            HapticHelper.lightImpact(isEnabled: val);
                            context
                                .read<AccessibilityBloc>()
                                .add(ToggleHapticFeedback(isEnabled: val));
                          },
                        ),

                        const SectionDivider(),

                        // ── Cognitive Support ───────────────────────────────
                        AccessibilitySectionHeader(
                          iconPath: AssetConstants.bulbIcon,
                          title: l10n.cognitiveSupportTitle,
                        ),
                        AccessibilityToggleRow(
                          title: l10n.lowLiteracyMode,
                          subtitle: l10n.lowLiteracyModeSubtitle,
                          value: settings.isLowLiteracyModeEnabled,
                          isEnabled: false,
                          onChanged: null,
                        ),
                        AccessibilityToggleRow(
                          title: l10n.adhdMode,
                          subtitle: l10n.adhdModeSubtitle,
                          value: settings.isAdhdModeEnabled,
                          isEnabled: false,
                          onChanged: null,
                        ),

                        const SectionDivider(),

                        // ── Language ────────────────────────────────────────
                        AccessibilitySectionHeader(
                          iconPath: AssetConstants.globeIcon,
                          title: l10n.languageSectionTitle,
                        ),
                        _LanguageRow(
                          title: l10n.appLanguage,
                          currentLanguage: currentLanguageName,
                          onTap: () {
                            HapticHelper.selectionClick(isEnabled: isHaptic);
                            LanguageSelectorModal.show(context);
                          },
                        ),

                        const SizedBox(height: AppSpacing.xl),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Alias for backwards compatibility with routes.
typedef AccessibilityPage = AccessibilityBottomSheet;

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.title,
    required this.currentLanguage,
    required this.onTap,
  });

  final String title;
  final String currentLanguage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    currentLanguage,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

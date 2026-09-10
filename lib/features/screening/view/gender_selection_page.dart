import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/view/accessibility_page.dart';
import 'package:gbv/injection_container.dart';
import 'package:go_router/go_router.dart';

/// Gender identity represented as an enum for selection.
enum GenderOption { woman, man, nonBinary, preferNotToSay }

/// First screen of the screening flow — asks the user how they'd
/// like to be represented. This is used only to tailor question
/// wording; the choice is never stored or transmitted.
class GenderSelectionPage extends StatefulWidget {
  const GenderSelectionPage({super.key});

  @override
  State<GenderSelectionPage> createState() => _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<GenderSelectionPage> {
  final TtsHelper _tts = sl<TtsHelper>();
  StreamSubscription<TtsState>? _ttsSubscription;
  GenderOption? _selected;
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
          // Scrollable content area
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.md),
                  // Question heading
                  Text(
                    l10n.genderSelectionTitle,
                    style: AppTextStyles.headlineLarge.copyWith(height: 1.1),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Subtitle / privacy note
                  Text(
                    l10n.genderSelectionSubtitle,
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Gender option cards
                  _GenderOptionTile(
                    iconPath: AssetConstants.womanIcon,
                    label: l10n.genderWoman,
                    isSelected: _selected == GenderOption.woman,
                    isPlaying: _activeSpeechText == l10n.genderWoman,
                    onTap: () => _select(GenderOption.woman),
                    onAudioTap: () => _playAudio(l10n.genderWoman),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _GenderOptionTile(
                    iconPath: AssetConstants.manIcon,
                    label: l10n.genderMan,
                    isSelected: _selected == GenderOption.man,
                    isPlaying: _activeSpeechText == l10n.genderMan,
                    onTap: () => _select(GenderOption.man),
                    onAudioTap: () => _playAudio(l10n.genderMan),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _GenderOptionTile(
                    iconPath: AssetConstants.nonBinaryIcon,
                    label: l10n.genderNonBinary,
                    isSelected: _selected == GenderOption.nonBinary,
                    isPlaying: _activeSpeechText == l10n.genderNonBinary,
                    onTap: () => _select(GenderOption.nonBinary),
                    onAudioTap: () => _playAudio(l10n.genderNonBinary),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _GenderOptionTile(
                    iconPath: AssetConstants.safeIcon,
                    label: l10n.preferNotToSay,
                    isSelected: _selected == GenderOption.preferNotToSay,
                    isPlaying: _activeSpeechText == l10n.preferNotToSay,
                    onTap: () => _select(GenderOption.preferNotToSay),
                    onAudioTap: () => _playAudio(l10n.preferNotToSay),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Privacy assurance banner
                  _PrivacyBanner(),
                ],
              ),
            ),
          ),

          // Bottom continue button — always visible
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: AppButton(
              text: l10n.continueButton,
              onPressed: _selected != null ? _onContinue : null,
            ),
          ),
        ],
      ),
    );
  }

  void _select(GenderOption option) {
    setState(() => _selected = option);
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
    context.push(AppRoutes.incidentSelection);
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Private widgets
// ────────────────────────────────────────────────────────────────────────────

/// A single selectable gender option tile matching the design.
class _GenderOptionTile extends StatelessWidget {
  const _GenderOptionTile({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.onAudioTap,
    this.isPlaying = false,
  });

  final String iconPath;
  final String label;
  final bool isSelected;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onAudioTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? AppColors.primary : AppColors.border;
    const backgroundColor = AppColors.surface;
    final borderWidth = isSelected ? 2.0 : 1.2;

    return Material(
      color: backgroundColor,
      borderRadius: AppSpacing.borderRadiusMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.borderRadiusMd,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Row(
            children: [
              // Gender icon
              Container(
                width: 36,
                height: 36,
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

              // Label
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ),

              // Audio / TTS button
              _AudioIconButton(
                onTap: onAudioTap,
                isSelected: isSelected,
                isPlaying: isPlaying,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small tappable audio icon on the right side of each option tile.
class _AudioIconButton extends StatelessWidget {
  const _AudioIconButton({
    required this.onTap,
    required this.isSelected,
    this.isPlaying = false,
  });

  final VoidCallback onTap;
  final bool isSelected;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isPlaying
        ? AppColors.primary
        : isSelected
        ? AppColors.primary.withValues(alpha: 0.12)
        : AppColors.surfaceVariant;
    final iconColor = isPlaying
        ? AppColors.textOnPrimary
        : isSelected
        ? AppColors.primary
        : AppColors.textSecondary;
    final borderColor = isPlaying
        ? AppColors.primary
        : AppColors.borderSelected;

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
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

/// Privacy assurance banner at the bottom of the selection list.
class _PrivacyBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AssetConstants.safeIcon,
            width: 18.w,
            height: 18.h,
            colorFilter: ColorFilter.mode(
              AppColors.primary.withValues(alpha: 0.7),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              context.l10n.privacyBannerText,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

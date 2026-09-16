import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/view/accessibility_page.dart';
import 'package:gbv/features/screening/bloc/screening_cubit.dart';
import 'package:gbv/features/screening/widgets/gender_option_tile.dart';
import 'package:gbv/features/screening/widgets/privacy_banner.dart';
import 'package:gbv/injection_container.dart';
import 'package:go_router/go_router.dart';

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
                  GenderOptionTile(
                    iconPath: AssetConstants.womanIcon,
                    label: l10n.genderWoman,
                    isSelected: _selected == GenderOption.woman,
                    isPlaying: _activeSpeechText == l10n.genderWoman,
                    onTap: () => _select(GenderOption.woman),
                    onAudioTap: () => _playAudio(l10n.genderWoman),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  GenderOptionTile(
                    iconPath: AssetConstants.manIcon,
                    label: l10n.genderMan,
                    isSelected: _selected == GenderOption.man,
                    isPlaying: _activeSpeechText == l10n.genderMan,
                    onTap: () => _select(GenderOption.man),
                    onAudioTap: () => _playAudio(l10n.genderMan),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  GenderOptionTile(
                    iconPath: AssetConstants.nonBinaryIcon,
                    label: l10n.genderNonBinary,
                    isSelected: _selected == GenderOption.nonBinary,
                    isPlaying: _activeSpeechText == l10n.genderNonBinary,
                    onTap: () => _select(GenderOption.nonBinary),
                    onAudioTap: () => _playAudio(l10n.genderNonBinary),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  GenderOptionTile(
                    iconPath: AssetConstants.safeIcon,
                    label: l10n.preferNotToSay,
                    isSelected: _selected == GenderOption.preferNotToSay,
                    isPlaying: _activeSpeechText == l10n.preferNotToSay,
                    onTap: () => _select(GenderOption.preferNotToSay),
                    onAudioTap: () => _playAudio(l10n.preferNotToSay),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Privacy assurance banner
                  const PrivacyBanner(),
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
    if (_selected != null) {
      context.read<ScreeningCubit>().setGender(_selected!);
    }
    context.push(AppRoutes.incidentSelection);
  }
}

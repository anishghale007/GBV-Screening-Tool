import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';
import 'package:gbv/features/screening/bloc/screening_cubit.dart';
import 'package:gbv/features/screening/data/incident_types.dart';
import 'package:gbv/features/screening/widgets/incident_category_tile.dart';
import 'package:gbv/injection_container.dart';
import 'package:go_router/go_router.dart';

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
    context.read<ScreeningCubit>().setSelectedCategories(
      _selected.toList(),
      isNotSure: _isNotSureSelected,
    );
    context.replace(AppRoutes.questions);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppScaffold(
      appBar: CommonAppBar(title: l10n.screeningTitle),
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
                    style: AppTextStyles.headlineLarge.copyWith(
                      fontSize: 20.sp,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Subtitle
                  Text(
                    l10n.incidentSelectionSubtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Category Cards
                  ...getIncidentTypes(l10n).map((data) {
                    final isSelected = _selected.contains(data.category);
                    final speechKey = '${data.title}. ${data.description}';
                    final isPlaying = _activeSpeechText == speechKey;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
                      child: IncidentCategoryTile(
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
    final colorScheme = Theme.of(context).colorScheme;
    final isHighContrast = context.select(
      (AccessibilityBloc bloc) => bloc.state.settings.isHighContrastEnabled,
    );
    final backgroundColor = (isSelected && isHighContrast)
        ? colorScheme.primaryContainer
        : colorScheme.surface;
    final borderColor = isSelected ? colorScheme.primary : colorScheme.outline;
    final borderWidth = isSelected ? 2.0 : 1.2;

    return Material(
      color: backgroundColor,
      borderRadius: AppSpacing.borderRadiusMd,
      child: InkWell(
        onTap: onTap.withMediumImpact(),
        borderRadius: AppSpacing.borderRadiusMd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  size: 20,
                  color: colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

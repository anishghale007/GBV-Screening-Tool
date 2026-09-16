import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/view/accessibility_page.dart';
import 'package:gbv/features/screening/bloc/screening_cubit.dart';
import 'package:gbv/features/screening/bloc/screening_state.dart';
import 'package:gbv/features/screening/data/screening_questions_data.dart';
import 'package:gbv/features/screening/models/screening_question.dart';
import 'package:gbv/features/screening/widgets/screening_bottom_navigation.dart';
import 'package:gbv/features/screening/widgets/screening_option_tile.dart';
import 'package:gbv/features/screening/widgets/screening_progress_header.dart';
import 'package:gbv/injection_container.dart';
import 'package:go_router/go_router.dart';

/// Interactive screening questionnaire flow using PageView.builder.
///
/// Driven by [ScreeningCubit] to dynamically inject follow-up questions,
/// enforce the 15-question cap, adapt wording by gender, and score responses.
class ScreeningQuestionsPage extends StatefulWidget {
  const ScreeningQuestionsPage({
    this.questions = defaultScreeningQuestions,
    super.key,
  });

  final List<ScreeningQuestion> questions;

  @override
  State<ScreeningQuestionsPage> createState() => _ScreeningQuestionsPageState();
}

class _ScreeningQuestionsPageState extends State<ScreeningQuestionsPage> {
  final PageController _pageController = PageController();
  final TtsHelper _tts = sl<TtsHelper>();
  StreamSubscription<TtsState>? _ttsSubscription;

  int _currentIndex = 0;
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
    _pageController.dispose();
    _ttsSubscription?.cancel();
    _tts.stop();
    super.dispose();
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

  void _onNext(int totalQuestions) {
    if (_currentIndex < totalQuestions - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<ScreeningCubit>().completeScreening();
      context.push(AppRoutes.pathway);
    }
  }

  void _onPrevious() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = context.watch<LocaleCubit>().state.languageCode;

    return BlocBuilder<ScreeningCubit, ScreeningState>(
      builder: (context, screeningState) {
        final activeList = screeningState.activeQuestions.isNotEmpty
            ? screeningState.activeQuestions
            : widget.questions;
        final total = activeList.length;
        final safeIndex = _currentIndex.clamp(0, total > 0 ? total - 1 : 0);
        final currentQuestion = total > 0 ? activeList[safeIndex] : null;
        final selectedAnswer = currentQuestion != null
            ? screeningState.answers[currentQuestion.id]
            : null;
        final isOptionSelected = selectedAnswer != null;

        return AppScaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: _onPrevious,
            ),
            title: Text(
              l10n.screeningTitle,
              style: AppTextStyles.headlineSmall,
            ),
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
              // Pinned Header with Progress Bar & Question Counter
              ScreeningProgressHeader(
                currentIndex: safeIndex,
                totalQuestions: total,
              ),

              // Scrollable and Animated PageView for Question & Options
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                    context.read<ScreeningCubit>().setCurrentIndex(index);
                    _tts.stop();
                  },
                  itemCount: total,
                  itemBuilder: (context, index) {
                    final question = activeList[index];
                    final questionText = question.text(
                      languageCode,
                      screeningState.gender,
                    );
                    final currentAnswer =
                        screeningState.answers[question.id];
                    final isPlayingQuestionAudio =
                        _activeSpeechText == questionText;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.md,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Question text & TTS Audio Button
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  questionText,
                                  style: AppTextStyles.headlineSmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                    color: AppColors.textPrimary,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              _QuestionAudioButton(
                                isPlaying: isPlayingQuestionAudio,
                                onTap: () => _playAudio(questionText),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // List of Options (Single choice per question
                          // with points)
                          ...question.options.map((option) {
                            final isSelected = currentAnswer == option.id;
                            final optionLabel = option.label(languageCode);

                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm + 2,
                              ),
                              child: ScreeningOptionTile(
                                label: optionLabel,
                                isSelected: isSelected,
                                onTap: () {
                                  context
                                      .read<ScreeningCubit>()
                                      .answerQuestion(question, option);
                                },
                              ),
                            );
                          }),

                          const SizedBox(height: AppSpacing.md),

                          // "Prefer not to say" button
                          Center(
                            child: TextButton(
                              onPressed: () {
                                context
                                    .read<ScreeningCubit>()
                                    .skipQuestion(question);
                              },
                              child: Text(
                                l10n.preferNotToSay,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: currentAnswer == 'prefer_not_to_say'
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
                                  decoration: TextDecoration.underline,
                                  fontWeight:
                                      currentAnswer == 'prefer_not_to_say'
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Pinned Bottom Navigation Action Bar
              ScreeningBottomNavigation(
                onPrevious: safeIndex > 0 ? _onPrevious : null,
                onNext: () => _onNext(total),
                isNextEnabled: isOptionSelected,
                isLastQuestion: safeIndex == total - 1,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Circular TTS audio narration button for question prompt.
class _QuestionAudioButton extends StatelessWidget {
  const _QuestionAudioButton({required this.isPlaying, required this.onTap});

  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: isPlaying ? AppColors.primary : const Color(0xFFE6EFEF),
          shape: BoxShape.circle,
          border: Border.all(
            color: isPlaying ? AppColors.primary : AppColors.borderSelected,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            AssetConstants.audioLinesIcon,
            height: 18,
            width: 18,
            colorFilter: ColorFilter.mode(
              isPlaying ? AppColors.textOnPrimary : AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

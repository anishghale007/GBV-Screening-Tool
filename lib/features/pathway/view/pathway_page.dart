import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';
import 'package:gbv/features/accessibility/view/accessibility_page.dart';
import 'package:gbv/features/pathway/widgets/assessment_gauge.dart';
import 'package:gbv/features/pathway/widgets/digital_rights_modal.dart';
import 'package:gbv/features/pathway/widgets/pathway_action_card.dart';
import 'package:gbv/features/pathway/widgets/safety_tips_modal.dart';
import 'package:gbv/features/screening/bloc/screening_cubit.dart';
import 'package:gbv/features/screening/bloc/screening_state.dart';
import 'package:url_launcher/url_launcher.dart';

/// Screening Assessment Summary & Support Pathway Page.
///
/// Displays score gauge animated on appearance, risk category pill badge,
/// personalized summary guidance, and direct support action cards.
class PathwayPage extends StatefulWidget {
  const PathwayPage({super.key});

  @override
  State<PathwayPage> createState() => _PathwayPageState();
}

class _PathwayPageState extends State<PathwayPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final reduceAnimations = context
          .read<AccessibilityBloc>()
          .state
          .settings
          .isReduceAnimationsEnabled;
      if (reduceAnimations) {
        _animationController.value = 1.0;
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _callHelpline() async {
    final uri = Uri.parse('tel:1145');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Helpline: 1145 (Free 24/7 National GBV Helpline)'),
        ),
      );
    }
  }

  String _getRiskBadgeLabel(BuildContext context, RiskRange riskRange) {
    final l10n = context.l10n;
    return switch (riskRange) {
      RiskRange.low => l10n.riskLow,
      RiskRange.moderate => l10n.riskModerate,
      RiskRange.high => l10n.riskHigh,
      RiskRange.severe => l10n.riskSevere,
    };
  }

  String _getRiskDescription(BuildContext context, RiskRange riskRange) {
    final l10n = context.l10n;
    return switch (riskRange) {
      RiskRange.low => l10n.riskLowMeaning,
      RiskRange.moderate => l10n.riskModerateMeaning,
      RiskRange.high => l10n.riskHighMeaning,
      RiskRange.severe => l10n.riskSevereMeaning,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<ScreeningCubit, ScreeningState>(
      builder: (context, state) {
        // Calculate score percentage and risk range from screening answers
        final scorePercentage = state.scorePercentage;
        final riskRange = state.riskRange;
        final riskBadgeLabel = _getRiskBadgeLabel(context, riskRange);
        final riskDescription = _getRiskDescription(context, riskRange);

        return AppScaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () => Navigator.of(context).maybePop(),
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              // horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Assessment Summary Card
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.lg,
                  ),
                  child: Column(
                    children: [
                      // Section Header
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.assessmentSummary,
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Animated Circular Progress Gauge
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, _) {
                          return AssessmentGauge(
                            percentage: scorePercentage,
                            riskRange: riskRange,
                            animationProgress: _animation.value,
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Risk Level Pill Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: riskRange.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: riskRange.borderColor,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: riskRange.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              riskBadgeLabel,
                              style: TextStyle(
                                color: riskRange.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Narrative Assessment Text
                      Text(
                        riskDescription,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 13.5,
                          height: 1.45,
                          color: const Color(0xFF334155),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // 2. Talk to a Counselor Card
                PathwayActionCard(
                  icon: SvgPicture.asset(
                    AssetConstants.phoneIcon,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: l10n.talkToCounselor,
                  subtitle: l10n.talkToCounselorDesc,
                  buttonText: l10n.callHelpline1145,
                  isFilledButton: true,
                  onPressed: _callHelpline,
                ),
                SizedBox(height: 12.h),

                // 3. Know Your Digital Rights Card
                PathwayActionCard(
                  icon: SvgPicture.asset(
                    AssetConstants.bookIcon,
                    width: 22,
                    height: 22,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  title: l10n.knowYourDigitalRights,
                  subtitle: l10n.knowYourDigitalRightsDesc,
                  buttonText: l10n.learnMore,
                  onPressed: () => DigitalRightsModal.show(context),
                ),
                SizedBox(height: 12.h),

                // 4. Safety Planning Tips Card
                PathwayActionCard(
                  icon: const Icon(
                    Icons.shield_outlined,
                    color: AppColors.primary,
                    size: 22,
                  ),
                  title: l10n.safetyPlanningTips,
                  subtitle: l10n.safetyPlanningTipsDesc,
                  buttonText: l10n.viewTips,
                  onPressed: () => SafetyTipsModal.show(context),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        );
      },
    );
  }
}

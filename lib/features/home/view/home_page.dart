import 'package:flutter/material.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/view/accessibility_page.dart';
import 'package:go_router/go_router.dart';

/// Simple Home screen serving as the central hub for the screening tool.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.appTitle,
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          const LocaleSwitch(),
          IconButton(
            icon: const Icon(Icons.accessibility_new_rounded),
            tooltip: context.l10n.accessibilitySettings,
            onPressed: () => AccessibilityBottomSheet.show(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AccessibilityBottomSheet.show(context),
        tooltip: context.l10n.accessibilitySettings,
        child: const Icon(Icons.accessible_forward_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.md),
            // Privacy banner
            Container(
              padding: AppSpacing.paddingMd,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.15),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.security_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      '100% On-device & Encrypted. No personal data leaves '
                      'this phone.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Start Screening Card
            Card(
              child: Padding(
                padding: AppSpacing.paddingLg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wellbeing Screening',
                      style: AppTextStyles.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'A quick, 15-question guided audio check to help '
                      'understand your situation and suggest safe options.',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      text: 'Start Screening',
                      icon: const Icon(Icons.play_arrow_rounded),
                      onPressed: () => context.push(AppRoutes.screening),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Support Resources Card
            Card(
              child: Padding(
                padding: AppSpacing.paddingLg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.supportResources,
                      style: AppTextStyles.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Always-accessible emergency numbers, helplines, '
                      'and local counselors in Madhesh and Lumbini.',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      text: 'View Resources',
                      variant: AppButtonVariant.outlined,
                      icon: const Icon(Icons.phone_in_talk_rounded),
                      onPressed: () => context.push(AppRoutes.support),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Quick Exit Safety Notice
            Center(
              child: TextButton.icon(
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  color: AppColors.quickExit,
                ),
                label: Text(
                  'Quick Exit (Open Calculator)',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.quickExit,
                  ),
                ),
                onPressed: () => context.go(AppRoutes.quickExit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

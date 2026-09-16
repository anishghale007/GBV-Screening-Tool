import 'package:flutter/material.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:go_router/go_router.dart';

/// Simple Home screen serving as the central hub for the screening tool.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;

    return AppScaffold(
      appBar: CommonAppBar(
        title: l10n.appTitle,
        showBackButton: false,
        titleStyle: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w700,
        ),
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
                color: colorScheme.primaryContainer,
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.35),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.security_rounded,
                    color: colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      l10n.homePrivacyBanner,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
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
                      l10n.wellbeingScreeningTitle,
                      style: AppTextStyles.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.wellbeingScreeningDesc,
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      text: l10n.startScreeningButton,
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
                      l10n.supportResources,
                      style: AppTextStyles.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.supportResourcesDesc,
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      text: l10n.viewResourcesButton,
                      variant: AppButtonVariant.outlined,
                      icon: const Icon(Icons.phone_in_talk_rounded),
                      foregroundColor: Colors.black,
                      onPressed: () => context.push(AppRoutes.support),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

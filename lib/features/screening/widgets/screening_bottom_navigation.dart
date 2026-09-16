import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gbv/core/core.dart';

/// Pinned bottom navigation row for stepping through screening questions.
class ScreeningBottomNavigation extends StatelessWidget {
  const ScreeningBottomNavigation({
    required this.onPrevious,
    required this.onNext,
    required this.isNextEnabled,
    this.isLastQuestion = false,
    super.key,
  });

  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final bool isNextEnabled;
  final bool isLastQuestion;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.only(
        left: AppSpacing.sm,
        right: AppSpacing.sm,
        top: AppSpacing.sm,
        bottom: AppSpacing.md,
      ),
      color: theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          // Previous button
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: OutlinedButton(
                onPressed: onPrevious.withMediumImpact(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: colorScheme.surface,
                  side: BorderSide(color: colorScheme.outline, width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  context.l10n.previousButton,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: onPrevious != null
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Next Step button
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: isNextEnabled ? onNext : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  disabledBackgroundColor: colorScheme.primary.withValues(
                    alpha: 0.45,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  isLastQuestion
                      ? context.l10n.submitButton
                      : context.l10n.nextButton,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

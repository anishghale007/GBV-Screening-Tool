import 'package:flutter/material.dart';
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
    return Container(
      padding: const EdgeInsets.only(
        left: AppSpacing.sm,
        right: AppSpacing.sm,
        top: AppSpacing.sm,
        bottom: AppSpacing.md,
      ),
      color: AppColors.background,
      child: Row(
        children: [
          // Previous button
          Expanded(
            child: SizedBox(
              height: 48,
              child: OutlinedButton(
                onPressed: onPrevious,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9F7F5),
                  side: const BorderSide(color: Color(0xFFE5DDD5), width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  context.l10n.previousButton,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: onPrevious != null
                        ? const Color(0xFF5D6B70)
                        : AppColors.textSecondary.withValues(alpha: 0.5),
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
              height: 48,
              child: ElevatedButton(
                onPressed: isNextEnabled ? onNext : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.primary.withValues(
                    alpha: 0.45,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isLastQuestion
                      ? context.l10n.completionTitle
                      : context.l10n.nextButton,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textOnPrimary,
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

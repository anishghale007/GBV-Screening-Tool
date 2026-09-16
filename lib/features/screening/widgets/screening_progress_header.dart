import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gbv/core/core.dart';

/// Pinned header displaying the animated progress bar, percentage,
/// and current question counter.
class ScreeningProgressHeader extends StatelessWidget {
  const ScreeningProgressHeader({
    required this.currentIndex,
    required this.totalQuestions,
    super.key,
  });

  final int currentIndex;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final progressFactor = totalQuestions > 0 && currentIndex > 0
        ? (currentIndex + 1) / totalQuestions
        : 0.0;
    final progressPercent = currentIndex == 0
        ? 0
        : (progressFactor * 100).round().clamp(0, 100);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.progressLabel(progressPercent),
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                l10n.questionProgress(currentIndex + 1, totalQuestions),
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Rounded linear progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: SizedBox(
              height: 6,
              child: Stack(
                children: [
                  Container(color: const Color(0xFFEFE8DE)),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: constraints.maxWidth * progressFactor,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

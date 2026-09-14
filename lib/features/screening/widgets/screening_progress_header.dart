import 'package:flutter/material.dart';
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
                'Progress: $progressPercent%',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                  children: [
                    const TextSpan(text: 'Question '),
                    TextSpan(
                      text: '${currentIndex + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextSpan(text: ' of $totalQuestions'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Rounded linear progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
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

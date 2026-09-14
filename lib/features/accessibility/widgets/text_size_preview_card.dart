import 'package:flutter/material.dart';
import 'package:gbv/core/enums/app_enums.dart';
import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/core/theme/app_font_sizes.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';
import 'package:gbv/features/accessibility/widgets/text_size_segment.dart';
import 'package:gbv/l10n/l10n.dart';

/// Text size selection segment and live typography preview card.
class TextSizePreviewCard extends StatelessWidget {
  const TextSizePreviewCard({
    required this.selectedOption,
    required this.onChanged,
    super.key,
  });

  final TextSizeOption selectedOption;
  final ValueChanged<TextSizeOption> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final previewFontSize = switch (selectedOption) {
      TextSizeOption.small => AppFontSizes.bodySmall,
      TextSizeOption.medium => AppFontSizes.bodyMedium,
      TextSizeOption.large => AppFontSizes.bodyLarge,
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.textSize,
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // 3-option pill selector
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                TextSizeSegment(
                  label: l10n.textSizeSmall,
                  isSelected: selectedOption == TextSizeOption.small,
                  onTap: () => onChanged(TextSizeOption.small),
                ),
                TextSizeSegment(
                  label: l10n.textSizeMedium,
                  isSelected: selectedOption == TextSizeOption.medium,
                  onTap: () => onChanged(TextSizeOption.medium),
                ),
                TextSizeSegment(
                  label: l10n.textSizeLarge,
                  isSelected: selectedOption == TextSizeOption.large,
                  onTap: () => onChanged(TextSizeOption.large),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Live preview text
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontSize: previewFontSize,
              color: AppColors.textSecondary,
              fontFamily: 'Inter',
              height: 1.35,
            ),
            child: Text(l10n.textSizePreview),
          ),
        ],
      ),
    );
  }
}

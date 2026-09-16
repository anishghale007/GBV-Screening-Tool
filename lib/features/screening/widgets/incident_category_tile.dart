import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gbv/core/constants/asset_constants.dart';
import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';
import 'package:gbv/core/utils/voidcallback_extension.dart';

/// Selectable Incident Category Tile.
class IncidentCategoryTile extends StatelessWidget {
  const IncidentCategoryTile({
    required this.iconPath,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.isPlaying,
    required this.onTap,
    required this.onAudioTap,
    super.key,
  });

  final String iconPath;
  final String title;
  final String description;
  final bool isSelected;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onAudioTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? AppColors.primary : AppColors.border;
    final borderWidth = isSelected ? 2.0 : 1.2;

    return Material(
      color: AppColors.surface,
      borderRadius: AppSpacing.borderRadiusMd,
      child: InkWell(
        onTap: onTap.withMediumImpact(),
        borderRadius: AppSpacing.borderRadiusMd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Row(
            children: [
              // Icon Circle
              Container(
                width: 38.w,
                height: 38.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : AppColors.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),

              // Audio narration button
              _AudioIconButton(onTap: onAudioTap, isPlaying: isPlaying),
              const SizedBox(width: AppSpacing.sm),

              // Custom Rounded Checkbox
              _CustomCheckbox(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Rounded Checkbox matching the design reference.
class _CustomCheckbox extends StatelessWidget {
  const _CustomCheckbox({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 22.w,
      height: 22.h,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: 1.5,
        ),
      ),
      child: isSelected
          ? const Center(
              child: Icon(
                Icons.check_rounded,
                size: 16,
                color: AppColors.textOnPrimary,
              ),
            )
          : null,
    );
  }
}

/// Audio narration button.
class _AudioIconButton extends StatelessWidget {
  const _AudioIconButton({required this.onTap, this.isPlaying = false});

  final VoidCallback onTap;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isPlaying
        ? AppColors.primary
        : AppColors.surfaceVariant;
    final iconColor = isPlaying
        ? AppColors.textOnPrimary
        : AppColors.textSecondary;
    final borderColor = isPlaying
        ? AppColors.primary
        : AppColors.borderSelected;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 36.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: SvgPicture.asset(
            AssetConstants.audioLinesIcon,
            height: 18,
            width: 18,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

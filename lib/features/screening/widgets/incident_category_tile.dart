import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gbv/core/constants/asset_constants.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';
import 'package:gbv/core/utils/voidcallback_extension.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final isHighContrast = context.select(
      (AccessibilityBloc bloc) => bloc.state.settings.isHighContrastEnabled,
    );
    final backgroundColor = (isSelected && isHighContrast)
        ? colorScheme.primaryContainer
        : colorScheme.surface;
    final borderColor = isSelected ? colorScheme.primary : colorScheme.outline;
    final borderWidth = isSelected ? 2.0 : 1.2;

    final iconBgColor = isSelected
        ? (isHighContrast
            ? colorScheme.primary
            : colorScheme.primary.withValues(alpha: 0.12))
        : colorScheme.surfaceContainerHighest;
    final iconColor = isSelected
        ? (isHighContrast ? colorScheme.onPrimary : colorScheme.primary)
        : colorScheme.primary;

    return Material(
      color: backgroundColor,
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
            color: backgroundColor,
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
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    iconColor,
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
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isSelected
                            ? colorScheme.onSurface
                            : colorScheme.onSurfaceVariant,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),

              // Audio narration button
              _AudioIconButton(
                onTap: onAudioTap,
                isSelected: isSelected,
                isPlaying: isPlaying,
              ),
              const SizedBox(width: AppSpacing.sm),

              // Custom Rounded Checkbox
              _CustomCheckbox(
                isSelected: isSelected,
                isHighContrast: isHighContrast,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Rounded Checkbox matching the design reference.
class _CustomCheckbox extends StatelessWidget {
  const _CustomCheckbox({
    required this.isSelected,
    required this.isHighContrast,
  });

  final bool isSelected;
  final bool isHighContrast;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 22.w,
      height: 22.h,
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: isSelected ? 2.0 : 1.5,
        ),
      ),
      child: isSelected
          ? Center(
              child: Icon(
                Icons.check_rounded,
                size: 16,
                color: colorScheme.onPrimary,
              ),
            )
          : null,
    );
  }
}

/// Audio narration button.
class _AudioIconButton extends StatelessWidget {
  const _AudioIconButton({
    required this.onTap,
    required this.isSelected,
    this.isPlaying = false,
  });

  final VoidCallback onTap;
  final bool isSelected;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHighContrast = context.select(
      (AccessibilityBloc bloc) => bloc.state.settings.isHighContrastEnabled,
    );
    final backgroundColor = isPlaying
        ? colorScheme.primary
        : isSelected
        ? (isHighContrast
            ? colorScheme.surface
            : colorScheme.primary.withValues(alpha: 0.12))
        : colorScheme.surfaceContainerHighest;
    final iconColor = isPlaying
        ? colorScheme.onPrimary
        : isSelected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;
    final borderColor = isPlaying
        ? colorScheme.primary
        : isSelected
        ? colorScheme.primary
        : colorScheme.outline;

    return GestureDetector(
      onTap: onTap.withMediumImpact(),
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

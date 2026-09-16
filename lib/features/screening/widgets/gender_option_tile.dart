import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';
import 'package:gbv/core/utils/voidcallback_extension.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';

class GenderOptionTile extends StatelessWidget {
  const GenderOptionTile({
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.onAudioTap,
    this.isPlaying = false,
    super.key,
  });

  final String iconPath;
  final String label;
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

    return InkWell(
      onTap: onTap.withMediumImpact(),
      borderRadius: AppSpacing.borderRadiusLg,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Row(
          children: [
            // Gender icon
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconPath,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // Label
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: colorScheme.onSurface,
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                ),
              ),
            ),

            // Audio / TTS button
            AudioIconButton(
              onTap: onAudioTap,
              isSelected: isSelected,
              isPlaying: isPlaying,
            ),
          ],
        ),
      ),
    );
  }
}

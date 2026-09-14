import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';

/// Section header with icon and styled title for accessibility options.
class AccessibilitySectionHeader extends StatelessWidget {
  const AccessibilitySectionHeader({
    required this.iconPath,
    required this.title,
    super.key,
  });

  final String iconPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isSvg = iconPath.toLowerCase().endsWith('.svg');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          if (isSvg)
            SvgPicture.asset(
              iconPath,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            )
          else
            Image.asset(
              iconPath,
              width: 18,
              height: 18,
              color: AppColors.primary,
            ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            title,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

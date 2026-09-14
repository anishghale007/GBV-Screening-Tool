import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gbv/core/constants/asset_constants.dart';
import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';
import 'package:gbv/l10n/l10n.dart';

/// Privacy assurance banner at the bottom of the selection list.
class PrivacyBanner extends StatelessWidget {
  const PrivacyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppSpacing.borderRadiusMd,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AssetConstants.safeIcon,
            width: 18.w,
            height: 18.h,
            colorFilter: ColorFilter.mode(
              AppColors.primary.withValues(alpha: 0.7),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              context.l10n.privacyBannerText,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

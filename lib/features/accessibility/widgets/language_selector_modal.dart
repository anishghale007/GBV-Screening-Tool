import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbv/core/localization/locale_cubit.dart';
import 'package:gbv/core/services/haptic_helper.dart';
import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/core/theme/app_spacing.dart';
import 'package:gbv/core/theme/app_text_styles.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';
import 'package:gbv/l10n/l10n.dart';

/// Modal bottom sheet allowing the user to select the active application
/// language.
class LanguageSelectorModal extends StatelessWidget {
  const LanguageSelectorModal({super.key});

  /// Shows the language selection bottom sheet.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const LanguageSelectorModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isNepali = context.watch<LocaleCubit>().isNepali;
    final isHaptic = context
        .watch<AccessibilityBloc>()
        .state
        .settings
        .isHapticFeedbackEnabled;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.selectAppLanguage,
              style: AppTextStyles.headlineSmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _LanguageOptionTile(
              title: l10n.english,
              subtitle: l10n.englishSubtitle,
              isSelected: !isNepali,
              onTap: () {
                HapticHelper.selectionClick(isEnabled: isHaptic);
                context.read<LocaleCubit>().setEnglish();
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            _LanguageOptionTile(
              title: l10n.nepali,
              subtitle: l10n.nepaliSubtitle,
              isSelected: isNepali,
              onTap: () {
                HapticHelper.selectionClick(isEnabled: isHaptic);
                context.read<LocaleCubit>().setNepali();
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primaryContainer : AppColors.surface,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.8 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

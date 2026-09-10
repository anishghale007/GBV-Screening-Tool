import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbv/core/core.dart';

/// A connected, segmented toggle switch for English ("EN") and Nepali ("ने").
///
/// Tapping a segment or toggle changes the language across the entire app
/// and persists the setting locally.
class LocaleSwitch extends StatelessWidget {
  const LocaleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, currentLocale) {
        final isNepali = currentLocale.languageCode == 'ne';
        final cubit = context.read<LocaleCubit>();

        return Container(
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFE2EBEB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.18),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LocaleSegment(
                  label: 'EN',
                  isActive: !isNepali,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(7),
                  ),
                  onTap: cubit.setEnglish,
                ),
                _LocaleSegment(
                  label: 'ने',
                  isActive: isNepali,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(7),
                  ),
                  onTap: cubit.setNepali,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LocaleSegment extends StatelessWidget {
  const _LocaleSegment({
    required this.label,
    required this.isActive,
    required this.borderRadius,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final BorderRadius borderRadius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: borderRadius,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.textOnPrimary : const Color(0xFF2C3E50),
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

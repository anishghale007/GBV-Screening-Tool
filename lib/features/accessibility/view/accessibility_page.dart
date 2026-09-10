import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbv/common/widgets/section_divider.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/widgets/text_size_segment.dart';

/// Accessibility settings bottom sheet matching the design reference.
///
/// Features a sticky top drag handle and header, interactive switches,
/// text-size preview selector, and dynamic language switcher powered
/// by [LocaleCubit].
class AccessibilityBottomSheet extends StatefulWidget {
  const AccessibilityBottomSheet({super.key});

  /// Helper to open the accessibility bottom sheet from any screen.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AccessibilityBottomSheet(),
    );
  }

  @override
  State<AccessibilityBottomSheet> createState() =>
      _AccessibilityBottomSheetState();
}

/// Alias for backwards compatibility with routes.
typedef AccessibilityPage = AccessibilityBottomSheet;

class _AccessibilityBottomSheetState extends State<AccessibilityBottomSheet> {
  // Audio settings
  bool _autoPlayAudio = true;
  bool _screenReaderOptimization = false;

  // Vision & Reading
  int _selectedTextSize = 1; // 0: Small, 1: Medium, 2: Large
  bool _highContrast = false;
  bool _dyslexiaFont = false;

  // Motor & Interactions
  bool _largeTouchTargets = true;
  bool _hapticFeedback = true;

  // Cognitive Support
  bool _lowLiteracy = false;
  bool _adhdMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.9,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pinned sticky top section with drag handle & title
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                bottom: AppSpacing.sm,
              ),
              child: Column(
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
                    'Accessibility',
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable settings body
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xs,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Audio Settings ──────────────────────────────────────
                    const _SectionHeader(
                      iconPath: AssetConstants.volumenIcon,
                      title: 'Audio Settings',
                    ),
                    _ToggleRow(
                      title: 'Audio narration auto-play',
                      subtitle: 'Auto-read each question aloud automatically',
                      value: _autoPlayAudio,
                      onChanged: (val) => setState(() => _autoPlayAudio = val),
                    ),
                    _ToggleRow(
                      title: 'Screen reader optimization',
                      subtitle: 'Enhanced compatibility with screen readers',
                      value: _screenReaderOptimization,
                      onChanged: (val) =>
                          setState(() => _screenReaderOptimization = val),
                    ),

                    const SectionDivider(),

                    // ── Vision & Reading ────────────────────────────────────
                    const _SectionHeader(
                      iconPath: AssetConstants.eyeIcon,
                      title: 'Vision & Reading',
                    ),
                    const SizedBox(height: AppSpacing.xs),

                    // Text size preview card
                    _TextSizeCard(
                      selectedIndex: _selectedTextSize,
                      onChanged: (index) =>
                          setState(() => _selectedTextSize = index),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    _ToggleRow(
                      title: 'High contrast mode',
                      subtitle: 'Increase contrast for better visibility',
                      value: _highContrast,
                      onChanged: (val) => setState(() => _highContrast = val),
                    ),
                    _ToggleRow(
                      title: 'Dyslexia-friendly font',
                      subtitle: 'Use a font designed for easier reading',
                      value: _dyslexiaFont,
                      onChanged: (val) => setState(() => _dyslexiaFont = val),
                    ),

                    const SectionDivider(),

                    // ── Motor & Interactions ────────────────────────────────
                    const _SectionHeader(
                      iconPath: AssetConstants.handIcon,
                      title: 'Motor & Interactions',
                    ),
                    _ToggleRow(
                      title: 'Large touch targets',
                      subtitle: 'Provide larger, easier-to-tap buttons',
                      value: _largeTouchTargets,
                      onChanged: (val) =>
                          setState(() => _largeTouchTargets = val),
                    ),
                    _ToggleRow(
                      title: 'Haptic feedback',
                      subtitle: 'Feel subtle vibrations on interactions',
                      value: _hapticFeedback,
                      onChanged: (val) =>
                          setState(() => _hapticFeedback = val),
                    ),

                    const SectionDivider(),

                    // ── Cognitive Support ───────────────────────────────────
                    const _SectionHeader(
                      iconPath: AssetConstants.bulbIcon,
                      title: 'Cognitive Support',
                    ),
                    _ToggleRow(
                      title: 'Low literacy mode',
                      subtitle: 'Simpler wording with more visual cues',
                      value: _lowLiteracy,
                      onChanged: (val) => setState(() => _lowLiteracy = val),
                    ),
                    _ToggleRow(
                      title: 'ADHD-friendly mode',
                      subtitle: 'Reduced visual clutter and distractions',
                      value: _adhdMode,
                      onChanged: (val) => setState(() => _adhdMode = val),
                    ),

                    const SectionDivider(),

                    // ── Language ────────────────────────────────────────────
                    const _SectionHeader(
                      iconPath: AssetConstants.globeIcon,
                      title: 'Language',
                    ),
                    BlocBuilder<LocaleCubit, Locale>(
                      builder: (context, locale) {
                        final isNepali = locale.languageCode == 'ne';
                        final currentLanguageName =
                            isNepali ? 'Nepali' : 'English';

                        return _LanguageRow(
                          currentLanguage: currentLanguageName,
                          onTap: () => _showLanguageModal(context, isNepali),
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageModal(BuildContext context, bool isCurrentNepali) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
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
                  'Select App Language',
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _LanguageOptionTile(
                  title: 'English',
                  subtitle: 'English (US)',
                  isSelected: !isCurrentNepali,
                  onTap: () {
                    context.read<LocaleCubit>().setEnglish();
                    Navigator.of(sheetContext).pop();
                  },
                ),
                const SizedBox(height: AppSpacing.sm),
                _LanguageOptionTile(
                  title: 'नेपाली',
                  subtitle: 'Nepali',
                  isSelected: isCurrentNepali,
                  onTap: () {
                    context.read<LocaleCubit>().setNepali();
                    Navigator.of(sheetContext).pop();
                  },
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Private Widgets
// ────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.iconPath, required this.title});

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

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Transform.scale(
            scale: 0.88,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: AppColors.primary,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFD3DCDE),
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextSizeCard extends StatelessWidget {
  const _TextSizeCard({required this.selectedIndex, required this.onChanged});

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final previewFontSize = switch (selectedIndex) {
      0 => 12.0,
      1 => 14.0,
      _ => 16.0,
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
            'Text size',
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
                  label: 'Small',
                  isSelected: selectedIndex == 0,
                  onTap: () => onChanged(0),
                ),
                TextSizeSegment(
                  label: 'Medium',
                  isSelected: selectedIndex == 1,
                  onTap: () => onChanged(1),
                ),
                TextSizeSegment(
                  label: 'Large',
                  isSelected: selectedIndex == 2,
                  onTap: () => onChanged(2),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Preview text
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontSize: previewFontSize,
              color: AppColors.textSecondary,
              fontFamily: 'Inter',
              height: 1.35,
            ),
            child: const Text(
              'Preview: This is how the text will appear in the app.',
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({required this.currentLanguage, required this.onTap});

  final String currentLanguage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App language',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    currentLanguage,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
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

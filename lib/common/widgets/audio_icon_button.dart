import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gbv/core/constants/asset_constants.dart';
import 'package:gbv/core/utils/voidcallback_extension.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';

/// Common reusable circular audio narration / TTS button.
class AudioIconButton extends StatelessWidget {
  const AudioIconButton({
    required this.onTap,
    this.isPlaying = false,
    this.isSelected = false,
    this.size,
    this.iconSize,
    super.key,
  });

  final VoidCallback onTap;
  final bool isPlaying;
  final bool isSelected;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHighContrast = context.select(
      (AccessibilityBloc bloc) => bloc.state.settings.isHighContrastEnabled,
    );

    final effectiveSize = size ?? 36.w;
    final effectiveIconSize = iconSize ?? 18.w;

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

    final borderColor = colorScheme.primary;

    return GestureDetector(
      onTap: onTap.withMediumImpact(),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: effectiveSize,
        height: effectiveSize,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: SvgPicture.asset(
            AssetConstants.audioLinesIcon,
            height: effectiveIconSize,
            width: effectiveIconSize,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

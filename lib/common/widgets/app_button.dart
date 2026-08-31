import 'package:flutter/material.dart';
import 'package:gbv/common/widgets/app_loading_indicator.dart';
import 'package:gbv/core/core.dart';

/// Button variant style.
enum AppButtonVariant {
  filled,
  outlined,
  text,
}

/// Accessible primary and secondary button complying with WCAG 2.1 AA
/// minimum touch-target requirements.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.variant = AppButtonVariant.filled,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = AppSpacing.minTouchTarget,
    this.backgroundColor,
    this.foregroundColor,
    this.semanticLabel,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height < AppSpacing.minTouchTarget
        ? AppSpacing.minTouchTarget
        : height;

    final child = isLoading
        ? AppLoadingIndicator(
            size: 20,
            color: variant == AppButtonVariant.filled
                ? (foregroundColor ?? AppColors.textOnPrimary)
                : (foregroundColor ?? context.colorScheme.primary),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                text,
                style: AppTextStyles.button.copyWith(
                  color: foregroundColor,
                ),
              ),
            ],
          );

    final buttonStyle = switch (variant) {
      AppButtonVariant.filled => ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? context.colorScheme.primary,
          foregroundColor: foregroundColor ?? AppColors.textOnPrimary,
          minimumSize: Size(
            isFullWidth ? double.infinity : 0,
            effectiveHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
        ),
      AppButtonVariant.outlined => OutlinedButton.styleFrom(
          foregroundColor: foregroundColor ?? context.colorScheme.primary,
          side: BorderSide(
            color: backgroundColor ?? context.colorScheme.primary,
          ),
          minimumSize: Size(
            isFullWidth ? double.infinity : 0,
            effectiveHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
        ),
      AppButtonVariant.text => TextButton.styleFrom(
          foregroundColor: foregroundColor ?? context.colorScheme.primary,
          minimumSize: Size(
            isFullWidth ? double.infinity : 0,
            effectiveHeight,
          ),
        ),
    };

    final buttonWidget = switch (variant) {
      AppButtonVariant.filled => ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
      AppButtonVariant.outlined => OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
      AppButtonVariant.text => TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: child,
        ),
    };

    return Semantics(
      label: semanticLabel ?? text,
      button: true,
      enabled: onPressed != null && !isLoading,
      child: buttonWidget,
    );
  }
}

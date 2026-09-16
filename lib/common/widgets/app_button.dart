import 'package:flutter/material.dart';
import 'package:gbv/common/widgets/app_loading_indicator.dart';
import 'package:gbv/core/core.dart';

/// Button variant style.
enum AppButtonVariant { filled, outlined, text }

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
    this.fontSize,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.semanticLabel,
  });

  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final double? fontSize;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
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
                style: (textStyle ?? AppTextStyles.button).copyWith(
                  color: foregroundColor,
                  fontSize: fontSize,
                ),
              ),
            ],
          );

    final buttonStyle = switch (variant) {
      AppButtonVariant.filled => ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? context.colorScheme.primary,
        foregroundColor: foregroundColor ?? AppColors.textOnPrimary,
        minimumSize: Size(isFullWidth ? double.infinity : 0, effectiveHeight),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),
      AppButtonVariant.outlined => OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.transparent,
        foregroundColor: foregroundColor ?? context.colorScheme.primary,
        side: BorderSide(
          color:
              borderColor ??
              (backgroundColor != null && backgroundColor != Colors.transparent
                  ? backgroundColor!
                  : context.colorScheme.outline),
          width: 1.2,
        ),
        minimumSize: Size(isFullWidth ? double.infinity : 0, effectiveHeight),
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),
      AppButtonVariant.text => TextButton.styleFrom(
        foregroundColor: foregroundColor ?? context.colorScheme.primary,
        minimumSize: Size(isFullWidth ? double.infinity : 0, effectiveHeight),
      ),
    };

    final effectiveOnPressed = isLoading ? null : onPressed.withMediumImpact();

    final buttonWidget = switch (variant) {
      AppButtonVariant.filled => ElevatedButton(
        onPressed: effectiveOnPressed,
        style: buttonStyle,
        child: child,
      ),
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: effectiveOnPressed,
        style: buttonStyle,
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: effectiveOnPressed,
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

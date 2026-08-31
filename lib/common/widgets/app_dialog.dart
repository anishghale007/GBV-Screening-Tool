import 'package:flutter/material.dart';
import 'package:gbv/common/widgets/app_button.dart';
import 'package:gbv/core/core.dart';

/// Reusable confirmation/alert dialog for the application.
class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    super.key,
    this.message,
    this.content,
    this.confirmText = 'OK',
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
  });

  final String title;
  final String? message;
  final Widget? content;
  final String confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;

  /// Shows the dialog via [showDialog].
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    String? message,
    Widget? content,
    String confirmText = 'OK',
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDestructive = false,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog(
        title: title,
        message: message,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDestructive: isDestructive,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      title: Text(
        title,
        style: AppTextStyles.headlineSmall.copyWith(
          color: context.colorScheme.onSurface,
        ),
      ),
      content: content ??
          (message != null
              ? Text(
                  message!,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                )
              : null),
      actionsPadding: AppSpacing.paddingMd,
      actions: [
        if (cancelText != null)
          AppButton(
            text: cancelText!,
            isFullWidth: false,
            variant: AppButtonVariant.text,
            onPressed: () {
              Navigator.of(context).pop(false);
              onCancel?.call();
            },
          ),
        AppButton(
          text: confirmText,
          isFullWidth: false,
          backgroundColor: isDestructive ? AppColors.error : null,
          onPressed: () {
            Navigator.of(context).pop(true);
            onConfirm?.call();
          },
        ),
      ],
    );
  }
}

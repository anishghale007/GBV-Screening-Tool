import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gbv/common/widgets/reading_guide.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/accessibility/view/accessibility_page.dart';

/// Base scaffold providing consistent layout, background colors, padding,
/// safe area handling, default accessibility FAB, reading guide overlay, and
/// dismiss-keyboard-on-tap behavior.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.showFloatingActionButton = true,
    this.enableReadingGuide = true,
    this.padding = AppSpacing.screenPadding,
    this.useSafeArea = true,
    this.hideKeyboardOnTap = true,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool showFloatingActionButton;
  final bool enableReadingGuide;
  final EdgeInsetsGeometry padding;
  final bool useSafeArea;
  final bool hideKeyboardOnTap;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(padding: padding, child: body);

    if (useSafeArea) {
      content = SafeArea(child: content);
    }

    if (hideKeyboardOnTap) {
      content = GestureDetector(
        onTap: context.hideKeyboard,
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }

    if (enableReadingGuide) {
      content = ReadingGuide(child: content);
    }

    final effectiveFab = showFloatingActionButton
        ? (floatingActionButton ??
              FloatingActionButton(
                onPressed: () => AccessibilityBottomSheet.show(context),
                tooltip: context.l10n.accessibilitySettings,
                child: const Icon(Icons.accessible_forward_rounded),
              ))
        : null;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: content,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: effectiveFab != null
          ? Padding(
              padding: EdgeInsets.only(bottom: 60.h),
              child: effectiveFab,
            )
          : null,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

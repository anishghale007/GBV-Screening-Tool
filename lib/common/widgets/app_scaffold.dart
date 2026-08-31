import 'package:flutter/material.dart';
import 'package:gbv/core/core.dart';

/// Base scaffold providing consistent layout, background colors, padding,
/// safe area handling, and dismiss-keyboard-on-tap behavior.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
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
  final EdgeInsetsGeometry padding;
  final bool useSafeArea;
  final bool hideKeyboardOnTap;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: padding,
      child: body,
    );

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

    return Scaffold(
      backgroundColor: backgroundColor ?? context.colorScheme.surface,
      appBar: appBar,
      body: content,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

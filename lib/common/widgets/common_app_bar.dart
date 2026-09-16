import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gbv/common/widgets/locale_switch.dart';
import 'package:gbv/core/core.dart';

/// Reusable top AppBar with back button, page title, and locale switch toggle.
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    required this.title,
    this.showBackButton = true,
    this.showLocaleSwitch = true,
    this.centerTitle = false,
    this.onBackPressed,
    this.titleStyle,
    this.actions,
    super.key,
  });

  final String title;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final bool showLocaleSwitch;
  final bool centerTitle;
  final TextStyle? titleStyle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;
    if (showBackButton) {
      leadingWidget = IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          final navigator = Navigator.of(context);
          if (onBackPressed != null) {
            onBackPressed!();
          } else if (navigator.canPop()) {
            navigator.pop();
          }
        }.withMediumImpact(),
      );
    }

    final defaultStyle = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    );

    return AppBar(
      scrolledUnderElevation: 0,
      title: Text(title, style: titleStyle ?? defaultStyle),
      centerTitle: centerTitle,
      leading: leadingWidget,
      actions: [
        ...(actions ?? []),
        if (showLocaleSwitch)
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: const LocaleSwitch(),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

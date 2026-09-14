import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gbv/common/widgets/locale_switch.dart';
import 'package:gbv/core/core.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    required this.title,
    this.leading,
    this.actions,
    super.key,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyles.headlineSmall),
      leading: Navigator.of(context).canPop()
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.h),
              onPressed: () {
                Navigator.of(context).maybePop();
              }.withMediumImpate(),
            )
          : leading,
      actions:
          actions ??
          [
            const Padding(
              padding: EdgeInsets.only(right: AppSpacing.sm),
              child: LocaleSwitch(),
            ),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

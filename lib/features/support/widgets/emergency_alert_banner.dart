import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Emergency warning banner displayed at the top of the Support Directory.
class EmergencyAlertBanner extends StatelessWidget {
  const EmergencyAlertBanner({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorColor = theme.colorScheme.error;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2F2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFED7D7), width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: errorColor, size: 24.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: errorColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w900,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/support/models/support_resource.dart';

/// Card component displaying a verified support resource and quick-call button.
class SupportResourceCard extends StatelessWidget {
  const SupportResourceCard({
    required this.resource,
    required this.languageCode,
    required this.callButtonLabel,
    required this.onCall,
    super.key,
  });

  final SupportResource resource;
  final String languageCode;
  final String callButtonLabel;
  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Circle
              Container(
                width: 48.w,
                height: 48.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5F0F0),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: _buildIcon(),
              ),
              SizedBox(width: 12.w),
              // Resource details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource.localizedName(languageCode),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      resource.localizedDescription(languageCode),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF667085),
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Tel: ${resource.displayPhone}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF216A6B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Full-width Call Button
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              onPressed: onCall.withMediumImpact(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B6B66),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                callButtonLabel,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (resource.iconAsset != null && resource.iconAsset!.endsWith('.svg')) {
      return SvgPicture.asset(
        resource.iconAsset!,
        width: 20.w,
        height: 20.w,
        colorFilter: const ColorFilter.mode(Color(0xFF1B6B66), BlendMode.srcIn),
      );
    }
    return Icon(
      resource.iconData ?? Icons.phone_rounded,
      color: const Color(0xFF1B6B66),
      size: 24.sp,
    );
  }
}

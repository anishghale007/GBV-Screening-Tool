import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:gbv/features/support/data/support_resources_data.dart';
import 'package:gbv/features/support/models/support_resource.dart';
import 'package:gbv/features/support/widgets/emergency_alert_banner.dart';
import 'package:gbv/features/support/widgets/support_resource_card.dart';
import 'package:url_launcher/url_launcher.dart';

/// Support Directory Page displaying verified helplines, shelters,
/// emergency services, and live search filtering.
class SupportDirectoryPage extends StatefulWidget {
  const SupportDirectoryPage({super.key});

  @override
  State<SupportDirectoryPage> createState() => _SupportDirectoryPageState();
}

class _SupportDirectoryPageState extends State<SupportDirectoryPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.trim().toLowerCase();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri.parse('tel:$cleanNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Helpline: $phoneNumber')));
    }
  }

  List<SupportResource> _getFilteredResources(String languageCode) {
    if (_searchQuery.isEmpty) {
      return defaultSupportResources;
    }

    return defaultSupportResources.where((resource) {
      final name = resource.name.toLowerCase();
      final nameNe = (resource.nameNe ?? '').toLowerCase();
      final desc = resource.description.toLowerCase();
      final descNe = (resource.descriptionNe ?? '').toLowerCase();
      final phone = resource.phone.toLowerCase();
      final displayPhone = resource.displayPhone.toLowerCase();

      return name.contains(_searchQuery) ||
          nameNe.contains(_searchQuery) ||
          desc.contains(_searchQuery) ||
          descNe.contains(_searchQuery) ||
          phone.contains(_searchQuery) ||
          displayPhone.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final languageCode = Localizations.localeOf(context).languageCode;
    final filteredResources = _getFilteredResources(languageCode);

    return AppScaffold(
      appBar: CommonAppBar(title: l10n.supportDirectoryTitle),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            _buildSearchBar(l10n),
            SizedBox(height: 16.h),

            // Emergency Alert Notice
            EmergencyAlertBanner(text: l10n.emergencyBannerText),
            SizedBox(height: 20.h),

            // Section Header
            Text(
              l10n.verifiedResources,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),

            // Resource Cards List or Empty State
            if (filteredResources.isEmpty)
              _buildEmptyState(l10n)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredResources.length,
                separatorBuilder: (context, index) => SizedBox(height: 14.h),
                itemBuilder: (context, index) {
                  final resource = filteredResources[index];
                  return SupportResourceCard(
                    resource: resource,
                    languageCode: languageCode,
                    callButtonLabel: l10n.callButtonLabel(
                      resource.displayPhone,
                    ),
                    onCall: () => _makePhoneCall(resource.phone),
                  );
                },
              ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(AppLocalizations l10n) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.transparent, width: 0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(fontSize: 14.5.sp, color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: l10n.searchHelplinesPlaceholder,
          hintStyle: TextStyle(
            color: const Color(0xFF667085),
            fontSize: 14.sp,
            letterSpacing: 0.2,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.black,
            size: 22.sp,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: const Color(0xFF9CA3AF),
                    size: 20.sp,
                  ),
                  onPressed: _searchController.clear,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.r),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.noResourcesFound,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.5.sp,
              color: const Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

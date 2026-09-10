import 'package:flutter/material.dart';
import 'package:gbv/core/theme/app_spacing.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Divider(color: Color(0xFFE5ECEC), thickness: 1, height: 1),
    );
  }
}

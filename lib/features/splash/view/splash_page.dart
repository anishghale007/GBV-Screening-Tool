import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gbv/common/common.dart';
import 'package:gbv/core/core.dart';
import 'package:go_router/go_router.dart';

/// Simple splash screen with branding and initial navigation.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.go(AppRoutes.home);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // App Logo / Icon Container
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              // App Title
              Text(
                context.l10n.appTitle,
                style: AppTextStyles.headlineLarge.copyWith(
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Safe & Private subtitle
              Text(
                'Safe • Confidential • Offline',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              // Loading spinner
              const AppLoadingIndicator(size: 28, color: AppColors.primary),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

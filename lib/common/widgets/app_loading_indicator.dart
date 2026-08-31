import 'package:flutter/material.dart';
import 'package:gbv/core/core.dart';

/// Accessible loading spinner with consistent color and optional size.
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.size = 24.0,
    this.color,
    this.strokeWidth = 2.5,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

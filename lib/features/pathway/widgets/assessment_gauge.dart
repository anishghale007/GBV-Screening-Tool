import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:gbv/core/enums/risk_range.dart';
import 'package:google_fonts/google_fonts.dart';

/// Animated circular gauge displaying the assessment score percentage.
class AssessmentGauge extends StatelessWidget {
  const AssessmentGauge({
    required this.percentage,
    required this.riskRange,
    required this.animationProgress,
    super.key,
    this.size = 148,
    this.strokeWidth = 14,
  });

  /// Target percentage (0 to 100).
  final double percentage;

  /// Risk range for color styling.
  final RiskRange riskRange;

  /// Animation progress value from 0.0 to 1.0.
  final double animationProgress;

  /// Diameter size of the gauge.
  final double size;

  /// Stroke width of the circular progress arc.
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final currentPercentage =
        (percentage * animationProgress).clamp(0.0, 100.0);
    final displayedInteger = currentPercentage.round();

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _GaugePainter(
              percentage: currentPercentage,
              arcColor: riskRange.color,
              trackColor: const Color(0xFFE2E8F0),
              strokeWidth: strokeWidth,
            ),
          ),
          Text(
            '$displayedInteger%',
            style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: riskRange.color,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter({
    required this.percentage,
    required this.arcColor,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double percentage;
  final Color arcColor;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background track ring
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    canvas.drawCircle(center, radius, trackPaint);

    // Active progress arc
    if (percentage > 0) {
      final arcPaint = Paint()
        ..color = arcColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      const startAngle = -math.pi / 2;
      final sweepAngle = (percentage / 100.0) * 2 * math.pi;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        arcPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.arcColor != arcColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

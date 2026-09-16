import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbv/core/theme/app_colors.dart';
import 'package:gbv/features/accessibility/bloc/accessibility_bloc.dart';

/// A Reading Guide overlay that dims everything on screen except for a
/// focused horizontal spotlight band around the line currently being read.
///
/// The user can drag the grip handle on the band up and down to track their
/// reading position. When ADHD mode is disabled, this widget returns [child]
/// directly with zero wrapper overhead.
class ReadingGuide extends StatefulWidget {
  const ReadingGuide({
    required this.child,
    this.enabled = true,
    this.bandHeight = 76.0,
    this.overlayColor,
    super.key,
  });

  final Widget child;
  final bool enabled;
  final double bandHeight;
  final Color? overlayColor;

  @override
  State<ReadingGuide> createState() => _ReadingGuideState();
}

class _ReadingGuideState extends State<ReadingGuide> {
  double? _guideY;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    final isAdhdModeEnabled = context.select(
      (AccessibilityBloc bloc) => bloc.state.settings.isAdhdModeEnabled,
    );

    if (!widget.enabled || !isAdhdModeEnabled) {
      return widget.child;
    }

    final maskColor =
        widget.overlayColor ?? Colors.black.withValues(alpha: 0.55);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxGuideY = (maxHeight - widget.bandHeight).clamp(0.0, maxHeight);

        // Initialize position to ~30% down the screen if not set or clamped
        final currentY = (_guideY ?? (maxHeight * 0.3)).clamp(0.0, maxGuideY);

        return Stack(
          fit: StackFit.expand,
          children: [
            // Underlying content (scrolls and receives pointer events normally)
            widget.child,

            // Top Dimming Mask
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: currentY,
              child: IgnorePointer(child: ColoredBox(color: maskColor)),
            ),

            // Bottom Dimming Mask
            Positioned(
              top: currentY + widget.bandHeight,
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(child: ColoredBox(color: maskColor)),
            ),

            // Reading Spotlight Band Outline & Drag Handle
            AnimatedPositioned(
              duration: _isDragging
                  ? Duration.zero
                  : const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              top: currentY,
              left: 0,
              right: 0,
              height: widget.bandHeight,
              child: Stack(
                children: [
                  // Visual guideline borders
                  IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.primary.withValues(alpha: 0.8),
                            width: 1.5,
                          ),
                          bottom: BorderSide(
                            color: AppColors.primary.withValues(alpha: 0.8),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Elegant, compact draggable grip handle on the right edge
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onVerticalDragStart: (_) {
                          setState(() => _isDragging = true);
                        },
                        onVerticalDragUpdate: (details) {
                          setState(() {
                            _guideY = ((_guideY ?? currentY) + details.delta.dy)
                                .clamp(0.0, maxGuideY);
                          });
                        },
                        onVerticalDragEnd: (_) {
                          setState(() => _isDragging = false);
                        },
                        onVerticalDragCancel: () {
                          setState(() => _isDragging = false);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 22,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(11),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(
                                  alpha: 0.35,
                                ),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 3,
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.unfold_more_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

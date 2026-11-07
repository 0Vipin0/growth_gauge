import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppProgressRing extends StatelessWidget {
  final double progress;
  final String? centerText;
  final String? subLabel;
  final double size;
  final double strokeWidth;

  const new({
    super.key,
    required this.progress,
    this.centerText,
    this.subLabel,
    this.size = 96.0,
    this.strokeWidth = 8.0,
  });

  const new compact({
    super.key,
    required this.progress,
    this.centerText,
    this.subLabel,
  }) : size = 64.0,
       strokeWidth = 6.0;

  const new hero({
    super.key,
    required this.progress,
    this.centerText,
    this.subLabel,
  }) : size = 140.0,
       strokeWidth = 12.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    final clampedProgress = progress.clamp(0.0, 1.0);
    final displayPercent = '${(clampedProgress * 100).toInt()}%';

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: clampedProgress),
            duration: disableAnimations
                ? Duration.zero
                : const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return CustomPaint(
                size: Size(size, size),
                painter: _ProgressRingPainter(
                  progress: value,
                  progressColor: colorScheme.primary,
                  trackColor: colorScheme.surfaceContainerHighest,
                  strokeWidth: strokeWidth,
                ),
              );
            },
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                centerText ?? displayPercent,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size * 0.22,
                  color: colorScheme.onSurface,
                ),
              ),
              if (subLabel != null)
                Text(
                  subLabel!,
                  style: TextStyle(
                    fontSize: size * 0.11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressRingPainter({
    required final double progress,
    required final Color progressColor,
    required final Color trackColor,
    required final double strokeWidth,
  }) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.trackColor != trackColor;
  }
}

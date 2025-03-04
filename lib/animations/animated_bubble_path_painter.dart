import 'dart:math';
import 'package:flutter/material.dart';

/// Custom painter that creates animated bubbles along a path
class AnimatedBubblePathPainter extends CustomPainter {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final Color bubbleColor;
  final Listenable repaint;

  AnimatedBubblePathPainter({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.bubbleColor,
    required this.repaint,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final double posX = 0.65;
    final double posY = 0.25;
    final Paint fillPaint = Paint()..style = PaintingStyle.fill;

    // Border paint
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 0.5;

    // Highlight paint for the shine effect
    final Paint highlightPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    final double timeBase = DateTime.now().millisecondsSinceEpoch / 1000;
    final double midX = startX + (endX - startX) * 0.5;
    final double midY = startY + (endY - startY) * 0.5;

    final offset1 = sin(timeBase * 1.0) * 3;
    final offset2 = sin(timeBase * 0.7 + pi / 5) * 4;
    final offset3 = sin(timeBase * 1.3 + pi / 2) * 2.5;

    final scale1 = 1.0 + 0.1 * sin(timeBase * 1.2);
    final scale2 = 1.0 + 0.15 * sin(timeBase * 0.8 + pi / 4);
    final scale3 = 1.0 + 0.08 * sin(timeBase * 1.5 + pi / 3);

    final opacity1 = 0.75 + 0.25 * sin(timeBase * 0.9 + pi / 6);
    final opacity2 = 0.75 + 0.25 * sin(timeBase * 1.4 + pi / 3);
    final opacity3 = 0.75 + 0.25 * sin(timeBase * 0.6 + pi / 2);

    final double radius1 = 15 * scale1;
    final double radius2 = 12 * scale2;
    final double radius3 = 18 * scale3;

    // First bubble
    final double firstX = startX + (midX - startX) * posX;
    final double firstY = startY + (midY - startY) * posY + offset1;
    fillPaint.color = bubbleColor.withAlpha((opacity1 * 255).round());
    canvas.drawCircle(Offset(firstX, firstY), radius1, fillPaint);
    canvas.drawCircle(Offset(firstX, firstY), radius1, borderPaint);
    canvas.drawCircle(Offset(firstX - radius1 * 0.3, firstY - radius1 * 0.3), radius1 * 0.25, highlightPaint);
    canvas.drawCircle(Offset(firstX - radius1 * 0, firstY - radius1 * 0.6), radius1 * 0.15, highlightPaint);

    // Middle bubble
    fillPaint.color = bubbleColor.withAlpha((opacity2 * 255).round());
    canvas.drawCircle(Offset(midX, midY + offset2), radius2, fillPaint);
    canvas.drawCircle(Offset(midX, midY + offset2), radius2, borderPaint);
    canvas.drawCircle(Offset(midX - radius2 * 0.3, midY + offset2 - radius2 * 0.3), radius2 * 0.25, highlightPaint);
    canvas.drawCircle(Offset(midX - radius2 * 0, midY + offset2 - radius2 * 0.6), radius2 * 0.15, highlightPaint);

    // Last bubble
    final double lastX = endX - (endX - midX) * posX;
    final double lastY = endY - (endY - midY) * posY + offset3;
    fillPaint.color = bubbleColor.withAlpha((opacity3 * 255).round());
    canvas.drawCircle(Offset(lastX, lastY), radius3, fillPaint);
    canvas.drawCircle(Offset(lastX, lastY), radius3, borderPaint);
    canvas.drawCircle(Offset(lastX - radius3 * 0.3, lastY - radius3 * 0.3), radius3 * 0.25, highlightPaint);
    canvas.drawCircle(Offset(lastX - radius3 * 0, lastY - radius3 * 0.6), radius3 * 0.15, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
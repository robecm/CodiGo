import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;

/// Class to store data about each floating bubble
class BubbleData {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double delay;
  final double scrollFactor;

  BubbleData({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.delay,
    required this.scrollFactor,
  });
}

/// Widget that animates a floating bubble
class FloatingBubble extends StatefulWidget {
  final double size;
  final Color color;
  final double delay;

  const FloatingBubble({
    super.key,  // Fixed: Using super parameter
    required this.size,
    required this.color,
    required this.delay,
  });

  @override
  State<FloatingBubble> createState() => _FloatingBubbleState();  // Fixed: Return type is now State<FloatingBubble>
}

class _FloatingBubbleState extends State<FloatingBubble> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _offset = 0.0;
  double _scale = 1.0;
  double _opacity = 0.7;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_updateAnimation)..start();
  }

  void _updateAnimation(Duration elapsed) {
    final timeBase = (elapsed.inMilliseconds / 1000) + widget.delay;
    setState(() {
      _offset = sin(timeBase * 0.7) * 5.0;
      _scale = 1.0 + sin(timeBase * 0.5) * 0.1;
      _opacity = 0.7 + sin(timeBase * 0.3) * 0.15;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, _offset),
      child: Transform.scale(
        scale: _scale,
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: DecoratedBubble(
            color: widget.color.withAlpha((_opacity * 255).round()),
          ),
        ),
      ),
    );
  }
}

/// Widget that creates a decorated bubble with highlights
class DecoratedBubble extends StatelessWidget {
  final Color color;

  const DecoratedBubble({
    super.key,  // Fixed: Using super parameter
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.white.withAlpha((0.6 * 255).round()), width: 0.5),  // Fixed: withOpacity -> withAlpha
      ),
      child: CustomPaint(
        painter: BubbleHighlightPainter(),
      ),
    );
  }
}

/// Custom painter that adds highlight effects to bubbles
class BubbleHighlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha((0.7 * 255).round())  // Fixed: withOpacity -> withAlpha
      ..style = PaintingStyle.fill;

    // Draw two highlight dots like in the other bubbles
    canvas.drawCircle(
      Offset(size.width * 0.3, size.height * 0.3),
      size.width * 0.15,
      paint
    );

    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * 0.2),
      size.width * 0.08,
      paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
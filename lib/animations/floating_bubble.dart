import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;
import 'decorated_bubble.dart';


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
  State<FloatingBubble> createState() => _FloatingBubbleState();  // Fixed: Return type is State<FloatingBubble>
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
            color: widget.color.withAlpha((_opacity * 255).round()),  // Fixed: withOpacity -> withAlpha
          ),
        ),
      ),
    );
  }
}

/// Widget that animates its child with a hovering effect
class AnimatedButtonHover extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedButtonHover({
    super.key,  // Fixed: Using super parameter
    required this.child,
    required this.index,
  });

  @override
  State<AnimatedButtonHover> createState() => _AnimatedButtonHoverState();  // Fixed: Return type is State<AnimatedButtonHover>
}

class _AnimatedButtonHoverState extends State<AnimatedButtonHover> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_updateOffset)..start();
  }

  void _updateOffset(Duration elapsed) {
    final double timeBase = elapsed.inMilliseconds / 1000;
    setState(() {
      _offset = sin(timeBase * (0.5 + widget.index * 0.1) + widget.index * 0.5) * 1.5;
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
      child: widget.child,
    );
  }
}

/// Class for creating a group of floating bubbles with different positions and properties
class FloatingBubbleGroup extends StatelessWidget {
  final List<BubbleData> bubbles;
  final Color baseColor;
  final double scrollOffset;

  const FloatingBubbleGroup({
    super.key,  // Fixed: Using super parameter
    required this.bubbles,
    required this.baseColor,
    this.scrollOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: bubbles.map((bubble) {
        final adjustedY = bubble.y - (scrollOffset * bubble.scrollFactor);

        return Positioned(
          left: bubble.x,
          top: adjustedY,
          child: FloatingBubble(
            size: bubble.size,
            color: baseColor.withAlpha((bubble.opacity * 255).round()),  // Fixed: withOpacity -> withAlpha
            delay: bubble.delay,
          ),
        );
      }).toList(),
    );
  }
}
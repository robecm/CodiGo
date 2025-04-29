import 'package:flutter/material.dart';
import 'decorated_bubble.dart';

class StaticBubble extends StatelessWidget {
  final double size;
  final Color color;

  const StaticBubble({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBubble(
        color: color,
      ),
    );
  }
}

class StaticBubbleGroup extends StatelessWidget {
  final List<BubbleData> bubbles;
  final Color baseColor;
  final double scrollOffset;

  const StaticBubbleGroup({
    super.key,
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
          child: StaticBubble(
            size: bubble.size,
            color: baseColor.withAlpha((bubble.opacity * 255).round()),
          ),
        );
      }).toList(),
    );
  }
}
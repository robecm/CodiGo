import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;

/// Widget that animates its child with a hovering effect
class AnimatedButtonHover extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedButtonHover({
    super.key, // Fixed: Using super parameter
    required this.child,
    required this.index,
  });

  @override
  State<AnimatedButtonHover> createState() => _AnimatedButtonHoverState(); // Fixed: Return type is State<AnimatedButtonHover>
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
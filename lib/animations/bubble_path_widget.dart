import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;
import 'animated_bubble_path_painter.dart';


class BubblePathWidget extends StatefulWidget {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final Color bubbleColor;

  const BubblePathWidget({
    super.key,
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.bubbleColor,
  });

  @override
  State<BubblePathWidget> createState() => _BubblePathWidgetState();  // Fixed: Return type is now State<BubblePathWidget>
}

class _BubblePathWidgetState extends State<BubblePathWidget> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final ValueNotifier<int> _repaintNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) {
      _repaintNotifier.value++;
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _repaintNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AnimatedBubblePathPainter(
        startX: widget.startX,
        startY: widget.startY,
        endX: widget.endX,
        endY: widget.endY,
        bubbleColor: widget.bubbleColor,
        repaint: _repaintNotifier,
      ),
    );
  }
}
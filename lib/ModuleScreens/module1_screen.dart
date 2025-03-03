import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show Ticker;

class Module1Screen extends StatefulWidget {
  const Module1Screen({super.key});

  @override
  Module1ScreenState createState() => Module1ScreenState();
}

class Module1ScreenState extends State<Module1Screen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  // Initialize with a default value instead of using late
  Color _backgroundColor = Colors.blue; // Default color
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateBackgroundColor);

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Still use post-frame callback to update with theme color when available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final baseColor = Theme.of(context).colorScheme.primary;
      setState(() {
        _backgroundColor = baseColor;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateBackgroundColor);
    _scrollController.dispose();
    _animationController.dispose(); // Dispose animation controller
    super.dispose();
  }

  void _updateBackgroundColor() {
    // Calculate scroll progress based on scroll position
    double scrollProgress = 0.0;

    if (_scrollController.position.maxScrollExtent > 0) {
      // Calculate the scroll ratio (0.0 to 1.0)
      scrollProgress = _scrollController.position.pixels /
                      _scrollController.position.maxScrollExtent;

      // Ensure it's clamped between 0.0 and 1.0
      scrollProgress = scrollProgress.clamp(0.0, 1.0);
    }

    // Get the primary color and determine darkness
    final baseColor = Theme.of(context).colorScheme.primary;
    final baseHSL = HSLColor.fromColor(baseColor);

    // Use a non-linear curve for smoother darkening effect
    // Only darken up to 40% of original lightness for best visual effect
    final darkeningAmount = 0.4 * scrollProgress;
    final newLightness = (baseHSL.lightness * (1 - darkeningAmount))
                        .clamp(0.1, baseHSL.lightness);

    setState(() {
      _backgroundColor = baseHSL.withLightness(newLightness).toColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bubbleColor = Theme.of(context).colorScheme.inversePrimary;
    Color buttonColor = const Color(0xffd8e2ff);
    final int levelCount = 15;
    double progressValue = 0.9;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Define positions for zigzag
    final leftPosition = screenWidth * 0.2;
    final middlePosition = screenWidth * 0.5;
    final rightPosition = screenWidth * 0.8;

    // Helper function to determine button position based on index
    double getPositionForIndex(int index) {
      switch (index % 4) {
        case 1:
          return leftPosition;
        case 3:
          return rightPosition;
        case 0:
        case 2:
          return middlePosition;
        default:
          return middlePosition;
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Módulo 1 - Bits', style: TextStyle(fontFamily: 'GoodMatcha'),),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 15.0,
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.white60,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
                ),
              ),
              Positioned(
                right: 16.0,
                child: Text(
                  '${(progressValue * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: _backgroundColor, // Use the dynamic background color
      body: SingleChildScrollView(
        controller: _scrollController, // Add the scroll controller here
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 50),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              for (int i = 1; i <= levelCount; i++) ...[
                // Position buttons in zigzag pattern with hovering animation
                Positioned(
                  top: 150.0 * (i - 1),
                  left: getPositionForIndex(i) - 40,
                  child: AnimatedButtonHover(
                    index: i,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(128),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: FloatingActionButton(
                          onPressed: () {
                            debugPrint('Button $i pressed');
                          },
                          heroTag: "btn$i", // Add unique hero tag for each button
                          shape: const CircleBorder(),
                          backgroundColor: i == 1 ? buttonColor : null,
                          elevation: 0,
                          highlightElevation: 0,
                          child: Text(
                            '$i',
                            style: const TextStyle(
                              fontSize: 40,
                              fontFamily: 'GoodMatcha'
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Add directional bubbles except after the last button
                if (i < levelCount)
                  _buildDirectionalBubbles(
                    i,
                    bubbleColor,
                    getPositionForIndex(i),
                    getPositionForIndex(i + 1),
                  ),
              ],
              // Add empty space at the bottom to ensure scrolling works properly
              SizedBox(height: 150.0 * levelCount),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 20,
            ),
            IconButton(
              icon: const Icon(Icons.book),
              onPressed: () {},
              iconSize: 20,
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
              iconSize: 20,
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create directional bubbles
  Widget _buildDirectionalBubbles(
      int currentButton, Color bubbleColor, double startPos, double endPos) {
    // Calculate positions
    final double startY = 150.0 * (currentButton - 1) + 80; // Bottom of current button
    final double endY = 150.0 * currentButton; // Top of next button

    return Positioned(
      top: 0,
      left: 0,
      width: MediaQuery.of(context).size.width,
      height: 150.0 * 6, // Ensure container covers all levels
      child: IgnorePointer(
        child: BubblePathWidget(
          startX: startPos,
          startY: startY,
          endX: endPos,
          endY: endY,
          bubbleColor: bubbleColor,
        ),
      ),
    );
  }
}


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
      ..strokeWidth = 0.5; // Thinner border

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

    // Adjusted bubble sizes
    final double radius1 = 15 * scale1; // Increased size
    final double radius2 = 12 * scale2; // Increased size
    final double radius3 = 18 * scale3; // Increased size

    // First bubble
    final double firstX = startX + (midX - startX) * posX;
    final double firstY = startY + (midY - startY) * posY + offset1;
    fillPaint.color = bubbleColor.withOpacity(opacity1);
    canvas.drawCircle(Offset(firstX, firstY), radius1, fillPaint);
    canvas.drawCircle(Offset(firstX, firstY), radius1, borderPaint);
    // Add highlight (small white circle)
    canvas.drawCircle(Offset(firstX - radius1 * 0.3, firstY - radius1 * 0.3), radius1 * 0.25, highlightPaint);
    canvas.drawCircle(Offset(firstX - radius1 * 0, firstY - radius1 * 0.6), radius1 * 0.15, highlightPaint);

    // Middle bubble
    fillPaint.color = bubbleColor.withOpacity(opacity2);
    canvas.drawCircle(Offset(midX, midY + offset2), radius2, fillPaint);
    canvas.drawCircle(Offset(midX, midY + offset2), radius2, borderPaint);
    // Add highlight
    canvas.drawCircle(Offset(midX - radius2 * 0.3, midY + offset2 - radius2 * 0.3), radius2 * 0.25, highlightPaint);
    canvas.drawCircle(Offset(midX - radius2 * 0, midY + offset2 - radius2 * 0.6), radius2 * 0.15, highlightPaint);

    // Last bubble
    final double lastX = endX - (endX - midX) * posX;
    final double lastY = endY - (endY - midY) * posY + offset3;
    fillPaint.color = bubbleColor.withOpacity(opacity3);
    canvas.drawCircle(Offset(lastX, lastY), radius3, fillPaint);
    canvas.drawCircle(Offset(lastX, lastY), radius3, borderPaint);
    // Add highlight
    canvas.drawCircle(Offset(lastX - radius3 * 0.3, lastY - radius3 * 0.3), radius3 * 0.25, highlightPaint);
    canvas.drawCircle(Offset(lastX - radius3 * 0, lastY - radius3 * 0.6), radius3 * 0.15, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BubblePathWidget extends StatefulWidget {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final Color bubbleColor;

  const BubblePathWidget({
    Key? key,
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.bubbleColor,
  }) : super(key: key);

  @override
  _BubblePathWidgetState createState() => _BubblePathWidgetState();
}

class _BubblePathWidgetState extends State<BubblePathWidget> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final ValueNotifier<int> _repaintNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) {
      // Increment the value to trigger a repaint
      _repaintNotifier.value++;
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _repaintNotifier.dispose(); // Also dispose the ValueNotifier
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
        repaint: _repaintNotifier, // Use ValueNotifier instead of Ticker directly
      ),
    );
  }
}

class AnimatedButtonHover extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedButtonHover({
    Key? key,
    required this.child,
    required this.index,
  }) : super(key: key);

  @override
  _AnimatedButtonHoverState createState() => _AnimatedButtonHoverState();
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
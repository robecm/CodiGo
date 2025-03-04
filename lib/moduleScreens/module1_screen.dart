import 'package:flutter/material.dart';
import 'dart:math';
import '../animations/bubble_path_widget.dart';
import '../animations/animated_button_hover.dart' show AnimatedButtonHover;
import '../animations/floating_bubble.dart' hide AnimatedButtonHover;
import '../animations/decorated_bubble.dart';
import '../exerciseScreens/multiple_option_question_screen.dart';

class Module1Screen extends StatefulWidget {
  const Module1Screen({super.key});

  @override
  Module1ScreenState createState() => Module1ScreenState();
}

class Module1ScreenState extends State<Module1Screen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  Color _backgroundColor = Colors.blue; // Default color
  late AnimationController _animationController;
  late int levelCount = 30;
  // Change from late to nullable
  List<BubbleData>? _backgroundBubbles;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateBackgroundColor);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Initialize bubbles early with a default size
    _backgroundBubbles = _generateRandomBubbles(
      800, // Default width until we get actual measurements
      150.0 * levelCount,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final baseColor = Theme.of(context).colorScheme.primary;
      setState(() {
        _backgroundColor = baseColor;
        // Re-generate with actual screen width
        _backgroundBubbles = _generateRandomBubbles(
          MediaQuery.of(context).size.width,
          150.0 * levelCount,
        );
      });
    });
  }

  List<BubbleData> _generateRandomBubbles(double screenWidth, double screenHeight) {
    final Random random = Random();
    final List<BubbleData> bubbles = [];

    final int count = random.nextInt(levelCount) + levelCount*5;

    for (int i = 0; i < count; i++) {
      bubbles.add(
        BubbleData(
          x: random.nextDouble() * screenWidth,
          y: random.nextDouble() * screenHeight * 2, // Spread throughout the content
          size: random.nextDouble() * 30 + 10, // 10-40px size
          opacity: random.nextDouble() * 0.3 + 0.1, // 0.1-0.4 opacity
          delay: random.nextDouble() * 5, // Random animation phase
          scrollFactor: random.nextDouble() * 0.4 + 0.8, // 0.8-1.2 scroll factor
        ),
      );
    }

    return bubbles;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateBackgroundColor);
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _updateBackgroundColor() {
    double scrollProgress = 0.0;

    if (_scrollController.position.maxScrollExtent > 0) {
      scrollProgress = _scrollController.position.pixels /
                      _scrollController.position.maxScrollExtent;
      scrollProgress = scrollProgress.clamp(0.0, 1.0);
    }

    final baseColor = Theme.of(context).colorScheme.primary;
    final baseHSL = HSLColor.fromColor(baseColor);

    final darkeningAmount = 0.4 * scrollProgress;
    final newLightness = (baseHSL.lightness * (1 - darkeningAmount))
                        .clamp(0.1, baseHSL.lightness);

    setState(() {
      _backgroundColor = baseHSL.withLightness(newLightness).toColor();
    });
  }

  void _navigateToQuestion(int buttonNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultipleOptionQuestionScreen(
          questionNumber: buttonNumber,
          question: "Esta es la pregunta número $buttonNumber. Selecciona la alternativa correcta.",
          options: [
            "Esta es la respuesta correcta",
            "Esta es una respuesta incorrecta",
            "Esta es otra respuesta incorrecta",
            "Esta es otra respuesta incorrecta más"
          ],
          correctOptionIndex: 0, // First option is always correct
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color bubbleColor = Theme.of(context).colorScheme.inversePrimary;
    Color buttonColor = const Color(0xffd8e2ff);
    double progressValue = 0.9;
    final double screenWidth = MediaQuery.of(context).size.width;

    final leftPosition = screenWidth * 0.2;
    final middlePosition = screenWidth * 0.5;
    final rightPosition = screenWidth * 0.8;

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
        backgroundColor: Color(0xff19253b),
        title: const Text('Módulo 1 - Bits', style: TextStyle(fontFamily: 'GoodMatcha', color: Colors.white),),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(5.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 15.0,
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.white70,
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
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 50),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Background bubbles
              if (_backgroundBubbles != null)
                Positioned.fill(
                  child: FloatingBubbleGroup(
                    bubbles: _backgroundBubbles!,
                    baseColor: Theme.of(context).colorScheme.primary,
                    scrollOffset: _scrollController.hasClients ? _scrollController.offset : 0.0,
                  ),
                ),

              for (int i = 1; i <= levelCount; i++) ...[
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
                          onPressed: () => _navigateToQuestion(i), // Updated to navigate
                          heroTag: "btn$i",
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

                if (i < levelCount)
                  _buildDirectionalBubbles(
                    i,
                    bubbleColor,
                    getPositionForIndex(i),
                    getPositionForIndex(i + 1),
                  ),
              ],
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
              color: Color(0xff19253b),
            ),
            IconButton(
              icon: const Icon(Icons.book),
              onPressed: () {},
              iconSize: 20,
              color: Color(0xff19253b)
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
              iconSize: 20,
              color: Color(0xff19253b)
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
              iconSize: 20,
              color: Color(0xff19253b)
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectionalBubbles(
      int currentButton, Color bubbleColor, double startPos, double endPos) {
    final double startY = 150.0 * (currentButton - 1) + 80;
    final double endY = 150.0 * currentButton;

    return Positioned(
      top: 0,
      left: 0,
      width: MediaQuery.of(context).size.width,
      height: 150.0 * 6,
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
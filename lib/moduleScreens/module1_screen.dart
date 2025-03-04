import 'package:flutter/material.dart';
import '../Animations/animated_button_hover.dart';
import '../Animations/bubble_path_widget.dart';

class Module1Screen extends StatefulWidget {
  const Module1Screen({super.key});

  @override
  Module1ScreenState createState() => Module1ScreenState();
}

class Module1ScreenState extends State<Module1Screen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  Color _backgroundColor = Colors.blue; // Default color
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateBackgroundColor);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

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

  @override
  Widget build(BuildContext context) {
    Color bubbleColor = Theme.of(context).colorScheme.inversePrimary;
    Color buttonColor = const Color(0xffd8e2ff);
    final double levelCount = 20;
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
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 50),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
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
                          onPressed: () {
                            debugPrint('Button $i pressed');
                          },
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
import 'package:flutter/material.dart';
import 'dart:math';
import '../animations/bubble_path_widget.dart';
import '../animations/animated_button_hover.dart' show AnimatedButtonHover;
import '../animations/floating_bubble.dart' hide AnimatedButtonHover;
import '../animations/decorated_bubble.dart';
import '../exerciseScreens/multiple_option_question_screen.dart';
import '../learningScreens/learning_topics_screen.dart';
import '../data/module1_learning_content.dart';
import '../data/module1_questions.dart';
import '../animations/static_bubble.dart';

class Module1Screen extends StatefulWidget {
  const Module1Screen({super.key});

  @override
  Module1ScreenState createState() => Module1ScreenState();
}

class Module1ScreenState extends State<Module1Screen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  // Add a ValueNotifier for the scroll offset
  final ValueNotifier<double> _scrollOffsetNotifier = ValueNotifier<double>(0.0);
  final ValueNotifier<Color> _backgroundColorNotifier = ValueNotifier<Color>(Colors.blue);
  late AnimationController _animationController;
  late int levelCount = 8;
  List<BubbleData>? _backgroundBubbles;
  final Map<int, Widget> _cachedLevelButtons = {};
  final Map<int, Widget> _cachedBubblePaths = {};
  bool _learningCompleted = false;
  Set<int> _answeredQuestions = {};
  Offset _imagePosition = const Offset(20, 20);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateBackgroundColor);

    // Add a listener that updates the scroll offset notifier immediately
    _scrollController.addListener(() {
      _scrollOffsetNotifier.value = _scrollController.offset;
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final baseColor = Theme.of(context).colorScheme.primary;
      _backgroundColorNotifier.value = baseColor;
      _generateBackgroundBubbles();
    });
  }

  void _generateBackgroundBubbles() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = 150.0 * levelCount;

    final Random random = Random();
    final int bubbleCount = (levelCount * 10).round();

    _backgroundBubbles = List.generate(
      bubbleCount,
          (i) => BubbleData(
        x: random.nextDouble() * screenWidth,
        y: random.nextDouble() * screenHeight * 1.5,
        size: random.nextDouble() * 25 + 10,
        opacity: random.nextDouble() * 0.2 + 0.1,
        delay: random.nextDouble() * 5,
        scrollFactor: 1.5 + random.nextDouble() * 0.3, // Lower value makes bubbles move faster
      ),
    );

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateBackgroundColor);
    _scrollController.dispose();
    _animationController.dispose();
    _backgroundColorNotifier.dispose();
    _scrollOffsetNotifier.dispose(); // Clean up the scroll notifier
    super.dispose();
  }

  void _updateBackgroundColor() {
    if (!_scrollController.hasClients) return;

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

    _backgroundColorNotifier.value = baseHSL.withLightness(newLightness).toColor();
  }

  void _navigateToQuestion(int buttonNumber) {
    if (!_learningCompleted) {
      _navigateToLearningSection();
      return;
    }

    // Check if this level is available: either it's the first level (1) or the previous level has been completed
    bool isAvailable = buttonNumber == 1 || _answeredQuestions.contains(buttonNumber - 1);

    // If level is not available, show message and return
    if (!isAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete el nivel anterior para desbloquear este nivel.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Get question data in the format needed by MultipleOptionQuestionScreen
    final questionData = Module1Questions.getQuestionData(buttonNumber);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultipleOptionQuestionScreen(
          questionNumber: buttonNumber,
          question: questionData['question'],
          options: questionData['options'],
          correctOptionIndex: questionData['correctOptionIndex'],
        ),
      ),
    ).then((result) {
      // Check if the question was answered correctly
      if (result is Map && result['correct'] == true) {
        setState(() {
          _answeredQuestions.add(buttonNumber);
          // Clear the cached button to force rebuild with new color
          _cachedLevelButtons.remove(buttonNumber);

          // Also clear the next button to update its availability status
          if (_cachedLevelButtons.containsKey(buttonNumber + 1)) {
            _cachedLevelButtons.remove(buttonNumber + 1);
          }
        });
      }
    });
  }

  void _navigateToLearningSection({bool isReview = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LearningTopicsScreen(
          topics: Module1LearningContent.getTopics(),
          backgroundColor: _backgroundColorNotifier.value,
          isReview: isReview,
          onCompleted: () {
            if (!isReview) {
              setState(() {
                _learningCompleted = true;
              });
            }
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildLevelButton(int index, double position) {
      // Return cached button if available
      if (_cachedLevelButtons.containsKey(index)) {
        return _cachedLevelButtons[index]!;
      }

      // Determine button color based on answer status
      Color? buttonColor = _answeredQuestions.contains(index)
          ? Colors.green // Green for correctly answered questions
          : (index == 1 ? const Color(0xffd8e2ff) : null);

      // Check if level is available (first level or previous level completed)
      bool isAvailable = index == 1 || _answeredQuestions.contains(index - 1);

      // Apply gray color for locked levels when learning is completed
      if (!isAvailable && _learningCompleted) {
        buttonColor = Colors.grey.shade400; // Gray for locked levels
      }

    // Convert numerical index to display label (A, B, C for first 3, then 1, 2, 3...)
    String buttonLabel;
    if (index <= 3) {
      // First part - use letters A, B, C
      buttonLabel = String.fromCharCode(64 + index); // ASCII: A=65, B=66, C=67
    } else {
      // Second part - use numbers starting from 1
      buttonLabel = '${index - 3}';
    }

    // Create and cache the button
    final button = Positioned(
      top: 150.0 * (index - 1),
      left: position - 40,
      child: RepaintBoundary(
        child: AnimatedButtonHover(
          index: index,
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
                onPressed: () => _navigateToQuestion(index),
                heroTag: "btn$index",
                shape: const CircleBorder(),
                backgroundColor: buttonColor,
                elevation: 0,
                highlightElevation: 0,
                child: Text(
                  buttonLabel,
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
    );

    _cachedLevelButtons[index] = button;
    return button;
  }

  Widget _buildDirectionalBubbles(int currentButton, Color bubbleColor, double startPos, double endPos) {
    final key = currentButton;

    // Return cached bubble path if available
    if (_cachedBubblePaths.containsKey(key)) {
      return _cachedBubblePaths[key]!;
    }

    final double startY = 150.0 * (currentButton - 1) + 80;
    final double endY = 150.0 * currentButton;

    final bubblePath = Positioned(
      top: 0,
      left: 0,
      width: MediaQuery.of(context).size.width,
      height: 150.0 * 6,
      child: RepaintBoundary(
        child: IgnorePointer(
          child: BubblePathWidget(
            startX: startPos,
            startY: startY,
            endX: endPos,
            endY: endY,
            bubbleColor: bubbleColor,
          ),
        ),
      ),
    );

    _cachedBubblePaths[key] = bubblePath;
    return bubblePath;
  }

  @override
  Widget build(BuildContext context) {
    final bubbleColor = Theme.of(context).colorScheme.inversePrimary;
    double progressValue = _learningCompleted
        ? (_answeredQuestions.length / levelCount.toDouble())
        : 0.0;
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

    return ValueListenableBuilder<Color>(
      valueListenable: _backgroundColorNotifier,
      builder: (context, backgroundColor, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: const Color(0xff19253b),
            title: const Text('Módulo 1 - Algoritmos', style: TextStyle(fontFamily: 'GoodMatcha', color: Colors.white)),
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
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: backgroundColor,
          body: _backgroundBubbles == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
            children: [
              // Background bubbles in a RepaintBoundary
              Positioned.fill(
                child: RepaintBoundary(
                  child: ValueListenableBuilder<double>(
                    valueListenable: _scrollOffsetNotifier,
                    builder: (context, scrollOffset, _) {
                      return StaticBubbleGroup(
                        bubbles: _backgroundBubbles!,
                        baseColor: Theme.of(context).colorScheme.primary,
                        scrollOffset: scrollOffset,
                      );
                    },
                  ),
                ),
              ),

              // Scrollable content in another layer
              _buildLevelContent(getPositionForIndex, bubbleColor),

              // Step image - moved here to stay fixed during scrolling
              _buildStepImage(),

              // Learning banner if not completed
              if (!_learningCompleted)
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: _navigateToLearningSection,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(40),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: Color(0xff19253b)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Aprende los conceptos básicos antes de responder preguntas',
                              style: TextStyle(
                                color: const Color(0xff19253b),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            height: 60,
            color: Colors.white,
            elevation: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 24,
                    color: Colors.grey.shade600
                ),
                IconButton(
                  icon: const Icon(Icons.book),
                  onPressed: () {
                    if (_learningCompleted) {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.school),
                                  title: const Text('Repasar conceptos'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    _navigateToLearningSection(isReview: true);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      _navigateToLearningSection();
                    }
                  },
                  iconSize: 24,
                  color: _learningCompleted ? Colors.grey.shade600 : const Color(0xff19253b),
                ),
                IconButton(
                    icon: const Icon(Icons.account_circle),
                    onPressed: () {},
                    iconSize: 24,
                    color: Colors.grey.shade600
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLevelContent(Function getPositionForIndex, Color bubbleColor) {
    // Calculate dynamic top padding based on whether learning banner is shown
    final double topPadding = _learningCompleted ? 50.0 : 120.0;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        return false;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: topPadding),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Bubble paths between buttons
              for (int i = 1; i < levelCount; i++)
                _buildDirectionalBubbles(
                    i,
                    bubbleColor,
                    getPositionForIndex(i),
                    getPositionForIndex(i + 1)
                ),

              // Level buttons
              for (int i = 1; i <= levelCount; i++)
                _buildLevelButton(i, getPositionForIndex(i)),

              // Step image removed from here (moved to main Stack)

              // Add padding at the bottom
              SizedBox(height: 150.0 * levelCount),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepImage() {
    // Find the highest answered question from the step questions (4-8)
    int latestAnsweredStep = 0;
    for (int i = 8; i >= 4; i--) {
      if (_answeredQuestions.contains(i)) {
        latestAnsweredStep = i;
        break;
      }
    }

    // If no steps are answered yet, don't show any image
    if (latestAnsweredStep == 0) {
      return const SizedBox.shrink();
    }

    // Convert question index to step number (4->1, 5->2, etc.)
    final int stepNumber = latestAnsweredStep - 3;

    return Positioned(
      left: _imagePosition.dx,
      top: _imagePosition.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _imagePosition = Offset(
              _imagePosition.dx + details.delta.dx,
              _imagePosition.dy + details.delta.dy,
            );
          });
        },
        onPanEnd: (details) {
          // Get screen dimensions
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;

          // Determine which corner to snap to
          final bool isLeft = _imagePosition.dx < screenWidth / 2;
          final bool isTop = _imagePosition.dy < screenHeight / 2;

          // Calculate safe area for bottom (account for navigation bar and extra padding)
          final bottomPadding = MediaQuery.of(context).padding.bottom + 80; // Increased padding

          // Get image container total height (image + padding)
          final double imageContainerHeight = 250 + 16; // max image height + container padding

          setState(() {
            // Snap to the appropriate corner
            _imagePosition = Offset(
              isLeft ? 20 : screenWidth - 170, // 150 (width) + 20 (padding)
              isTop ? 20 : screenHeight - bottomPadding - imageContainerHeight, // Safer calculation
            );
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 250, // Only cap at 250 if image exceeds this height
                  ),
                  child: Image.asset(
                    'lib/assets/step$stepNumber.png',
                    fit: BoxFit.contain,
                    width: 150,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: lib/assets/step$stepNumber.png');
                      return Container(
                        height: 150,
                        width: 150,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Add a drag handle indicator in the corner
              Positioned(
                right: 4,
                bottom: 4,
                child: Icon(
                  Icons.drag_indicator,
                  color: Colors.grey.withOpacity(0),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


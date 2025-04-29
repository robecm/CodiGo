import 'package:flutter/material.dart';
import 'dart:math';
import '../animations/floating_bubble.dart' hide AnimatedButtonHover;
import '../animations/decorated_bubble.dart';

class MultipleOptionQuestionScreen extends StatefulWidget {
  final int questionNumber;
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  const MultipleOptionQuestionScreen({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });

  @override
  State<MultipleOptionQuestionScreen> createState() => _MultipleOptionQuestionScreenState();
}

class _MultipleOptionQuestionScreenState extends State<MultipleOptionQuestionScreen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  List<BubbleData>? _backgroundBubbles;
  int? _selectedOptionIndex;
  bool _answerSubmitted = false;
  Color _backgroundColor = Colors.blue;
  late AnimationController _animationController;
  bool _showResultPopup = false;

  // Add variables for randomized options
  late List<String> _randomizedOptions;
  late int _randomizedCorrectIndex;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Randomize the options
    _randomizeOptions();

    // Initialize bubbles early with a default size
    _backgroundBubbles = _generateRandomBubbles(
      800, // Default width until we get actual measurements
      1000, // Default height
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final baseColor = Theme.of(context).colorScheme.primary;
      setState(() {
        _backgroundColor = baseColor;
        // Re-generate with actual screen dimensions
        _backgroundBubbles = _generateRandomBubbles(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        );
      });
    });
  }

  void _randomizeOptions() {
    // Create a copy of the original options
    _randomizedOptions = List<String>.from(widget.options);

    // Store the correct answer before shuffling
    final correctAnswer = widget.options[widget.correctOptionIndex];

    // Shuffle the options
    _randomizedOptions.shuffle();

    // Find the new index of the correct answer
    _randomizedCorrectIndex = _randomizedOptions.indexOf(correctAnswer);
  }

  List<BubbleData> _generateRandomBubbles(double screenWidth, double screenHeight) {
    final Random random = Random();
    final List<BubbleData> bubbles = [];

    final int count = random.nextInt(15) + 15;

    for (int i = 0; i < count; i++) {
      bubbles.add(
        BubbleData(
          x: random.nextDouble() * screenWidth,
          y: random.nextDouble() * screenHeight,
          size: random.nextDouble() * 30 + 10,
          opacity: random.nextDouble() * 0.3 + 0.1,
          delay: random.nextDouble() * 5,
          scrollFactor: random.nextDouble() * 0.4 + 0.8,
        ),
      );
    }

    return bubbles;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _selectOption(int index) {
    if (_answerSubmitted) return; // Prevent changing answer after submission

    setState(() {
      _selectedOptionIndex = index;
      _answerSubmitted = true;
      _showResultPopup = true;
    });
  }

  Color _getOptionColor(int optionIndex) {
    if (!_answerSubmitted) {
      return Colors.white;
    } else if (optionIndex == _randomizedCorrectIndex) {
      return Colors.green.shade100; // Correct answer is always green
    } else if (optionIndex == _selectedOptionIndex && optionIndex != _randomizedCorrectIndex) {
      return Colors.red.shade100; // Selected wrong answer is red
    } else {
      return Colors.white;
    }
  }

  Color _getCheckColor(int optionIndex) {
    if (!_answerSubmitted) {
      return Theme.of(context).colorScheme.inversePrimary;
    } else if (optionIndex == _randomizedCorrectIndex) {
      return Colors.green;
    } else if (optionIndex == _selectedOptionIndex && optionIndex != _randomizedCorrectIndex) {
      return Colors.red;
    } else {
      return Colors.grey.shade400;
    }
  }

  Widget _buildResultPopup() {
    bool isCorrect = _selectedOptionIndex == _randomizedCorrectIndex;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: _showResultPopup ? 1.0 : 0.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: -200 * (1 - value),
          child: Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green.shade100 : Colors.red.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(51),
                        blurRadius: 8,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          isCorrect ? '¡Correcto!' : 'Incorrecto. ¡Intenta de nuevo!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isCorrect ? Colors.green.shade800 : Colors.red.shade800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            // Return whether the answer was correct
                            Navigator.pop(context, {
                              'correct': _selectedOptionIndex == _randomizedCorrectIndex
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff19253b),
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Regresar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: _backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Pregunta ${widget.questionNumber}',
            style: const TextStyle(
              fontFamily: 'GoodMatcha',
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
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

            // Main content
            SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: screenHeight - MediaQuery.of(context).padding.top,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Question container with lighter color
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50, // Very light color for question
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(51), // 0.2 * 255 = 51
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          constraints: const BoxConstraints(
                            minHeight: 180,
                          ),
                          child: Text(
                            widget.question,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        // Options - using randomized options
                        ...List.generate(_randomizedOptions.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildOptionButton(
                              _randomizedOptions[index],
                              index,
                              _selectedOptionIndex == index,
                            ),
                          );
                        }),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Result popup
            if (_answerSubmitted)
              _buildResultPopup(),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option, int index, bool isSelected) {
    final bool isCorrectOption = index == _randomizedCorrectIndex;
    final bool showCorrectAnswer = _answerSubmitted && isCorrectOption;
    final bool showWrongAnswer = _answerSubmitted && isSelected && !isCorrectOption;

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      color: _getOptionColor(index),
      child: InkWell(
        onTap: _answerSubmitted ? null : () => _selectOption(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: showCorrectAnswer
                        ? Colors.green
                        : showWrongAnswer
                            ? Colors.red
                            : isSelected
                                ? Color(0xff19253b)
                                : Colors.grey.shade400,
                    width: 2,
                  ),
                  color: isSelected || showCorrectAnswer
                      ? _getCheckColor(index)
                      : Colors.transparent,
                ),
                child: (isSelected || showCorrectAnswer)
                    ? Icon(
                        showWrongAnswer ? Icons.close : Icons.check,
                        size: 18,
                        color: Colors.white
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected || showCorrectAnswer ? FontWeight.bold : FontWeight.normal,
                    color: showWrongAnswer
                        ? Colors.red.shade700
                        : showCorrectAnswer
                            ? Colors.green.shade700
                            : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

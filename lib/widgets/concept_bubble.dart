import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart' show Ticker;
import '../models/learning_content.dart';

class ConceptBubble extends StatefulWidget {
  final LearningConcept concept;
  final Color color;
  final double size;
  final VoidCallback onTap;
  final double delay;
  final int index;

  const ConceptBubble({
    super.key,
    required this.concept,
    required this.color,
    required this.size,
    required this.onTap,
    required this.index,
    this.delay = 0.0,
  });

  @override
  State<ConceptBubble> createState() => _ConceptBubbleState();
}

class _ConceptBubbleState extends State<ConceptBubble> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _offset = 0.0;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_updateAnimation)..start();
  }

  void _updateAnimation(Duration elapsed) {
    final timeBase = (elapsed.inMilliseconds / 1000) + widget.delay;
    setState(() {
      _offset = sin(timeBase * 0.6 + widget.index * 0.3) * 4.0;
      _scale = 1.0 + sin(timeBase * 0.4 + widget.index * 0.2) * 0.05;
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
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(70),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.concept.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
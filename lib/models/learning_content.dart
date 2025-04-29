
import 'package:flutter/material.dart';

class LearningTopic {
  final String id;
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final List<LearningConcept> concepts;

  LearningTopic({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.concepts,
  });
}

class LearningConcept {
  final String id;
  final String title;
  final String shortDescription;
  final Widget content;  // Changed from String to Widget
  final List<String> imageAssets;

  LearningConcept({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.imageAssets,
  });
}
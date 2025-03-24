import 'package:flutter/material.dart';

class LearningTopic {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<LearningConcept> concepts;
  final bool isUnlocked;

  LearningTopic({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.concepts,
    this.isUnlocked = true,
  });
}

class LearningConcept {
  final String id;
  final String title;
  final String shortDescription;
  final String content;
  final List<String> imageAssets;
  final bool hasInteractiveElement;
  final String? interactiveType;

  LearningConcept({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.content,
    this.imageAssets = const [],
    this.hasInteractiveElement = false,
    this.interactiveType,
  });
}
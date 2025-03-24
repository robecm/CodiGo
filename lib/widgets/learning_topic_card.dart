import 'package:flutter/material.dart';
import '../models/learning_content.dart';

class LearningTopicCard extends StatelessWidget {
  final LearningTopic topic;
  final Color backgroundColor;
  final Function onTap;
  final bool isReview;

  const LearningTopicCard({
    super.key,
    required this.topic,
    required this.backgroundColor,
    required this.onTap,
    this.isReview = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                topic.icon,
                size: 40,
                color: topic.color,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (isReview)
                      ElevatedButton(
                        onPressed: () => onTap(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Repasar'),
                      )
                    else
                      ElevatedButton(
                        onPressed: () => onTap(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Comenzar'),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
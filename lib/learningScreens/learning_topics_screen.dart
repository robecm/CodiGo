import 'package:flutter/material.dart';
import '../models/learning_content.dart';
import '../widgets/learning_topic_card.dart';
import 'content_detail_screen.dart';

class LearningTopicsScreen extends StatelessWidget {
  final List<LearningTopic> topics;
  final Color backgroundColor;
  final VoidCallback onCompleted;
  final bool isReview;

  const LearningTopicsScreen({
    super.key,
    required this.topics,
    required this.backgroundColor,
    required this.onCompleted,
    this.isReview = false,
  });

  void _navigateToTopicDetail(BuildContext context, LearningTopic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContentDetailScreen(
          topic: topic,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor.withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: const Color(0xff19253b),
        title: const Text(
          'Conceptos Clave',
          style: TextStyle(
            fontFamily: 'GoodMatcha',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecciona un tema para comenzar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: LearningTopicCard(
                        topic: topics[index],
                        backgroundColor: backgroundColor,
                        isReview: isReview,
                        onTap: () => _navigateToTopicDetail(context, topics[index]),
                      ),
                    );
                  },
                ),
              ),
              if (!isReview)
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: onCompleted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: backgroundColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Completar Aprendizaje'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
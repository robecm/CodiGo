import 'package:flutter/material.dart';
import '../models/learning_content.dart';
import '../widgets/concept_bubble.dart';

class ContentDetailScreen extends StatefulWidget {
  final LearningTopic topic;
  final Color backgroundColor;

  const ContentDetailScreen({
    super.key,
    required this.topic,
    required this.backgroundColor,
  });

  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}

class _ContentDetailScreenState extends State<ContentDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xff19253b),
        title: Text(
          widget.topic.title,
          style: const TextStyle(
            fontFamily: 'GoodMatcha',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Concepts bubbles at the top
          SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _buildConceptBubbles(),
            ),
          ),

          // Main content area
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.topic.concepts.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildConceptContent(widget.topic.concepts[index]);
              },
            ),
          ),

          // Navigation dots
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.topic.concepts.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConceptBubbles() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: widget.topic.concepts.length,
      itemBuilder: (context, index) {
        final concept = widget.topic.concepts[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ConceptBubble(
            concept: concept,
            color: _currentPage == index
                ? widget.topic.color
                : widget.topic.color.withOpacity(0.6),
            size: 90,
            index: index,
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildConceptContent(LearningConcept concept) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              concept.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff19253b),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              concept.shortDescription,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade700,
              ),
            ),
            const Divider(height: 32),

            // Main content
            Text(
              concept.content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            // Display images if available
            if (concept.imageAssets.isNotEmpty) ...[
              const SizedBox(height: 24),
              ...concept.imageAssets.map((imagePath) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ],
          ],
        ),
      ),
    );
  }
}
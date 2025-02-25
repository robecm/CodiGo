import 'package:flutter/material.dart';

class Module1Screen extends StatelessWidget {
  const Module1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module 1'),
      ),
      body: const Center(
        child: Text('This is Module 1'),
      )
    );
  }
}
import 'package:flutter/material.dart';
import '../ModuleScreens/module_screens.dart';
import 'dart:math' as math;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  // New blue shade for home screen
  final Color _primaryBlue = const Color(0xff2a3f67);

  // Mock data for modules - can be expanded in the future
  final List<ModuleItem> _modules = [
    ModuleItem(
      id: 1,
      title: 'Algoritmos',
      description: 'Aprende a resolver problemas mediante secuencias lógicas y diagramas de flujo',
      icon: Icons.account_tree,
      progress: 0.5,
      screen: const Module1Screen(),
    ),
    ModuleItem(
      id: 2,
      title: 'Bits',
      description: 'Explora el sistema binario y cómo se representa la información en computadoras',
      icon: Icons.memory,
      progress: 0,
      screen: null,
    ),
    ModuleItem(
      id: 3,
      title: 'Python',
      description: 'Introducción a la sintaxis y conceptos básicos del lenguaje Python',
      icon: Icons.code,
      progress: 0.0,
      screen: null,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcee3ff),
      appBar: AppBar(
        backgroundColor: _primaryBlue,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'GoodMatcha',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    _buildWelcomeSection(),
                    const SizedBox(height: 40),
                    _buildModuleSection(),
                    const SizedBox(height: 30),
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
              onPressed: () {},
              iconSize: 24,
              color: _primaryBlue,
            ),
            IconButton(
              icon: const Icon(Icons.book),
              onPressed: () {},
              iconSize: 24,
              color: Colors.grey.shade600,
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
              iconSize: 24,
              color: Colors.grey.shade600,
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
              iconSize: 24,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: BackgroundPainter(
              _primaryBlue.withOpacity(0.05),
              _controller.value,
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¡Bienvenido a CodiGo!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: _primaryBlue,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Elige un módulo para comenzar a aprender',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildModuleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Módulos',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _primaryBlue,
          ),
        ),
        const SizedBox(height: 16),
        ..._modules.map((module) => _buildModuleCard(module)),
      ],
    );
  }

  Widget _buildModuleCard(ModuleItem module) {
    bool isAvailable = module.screen != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isAvailable ? () => _navigateToModule(module) : null,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: isAvailable
                  ? LinearGradient(
                      colors: [
                        _primaryBlue.withOpacity(0.9),
                        _primaryBlue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        Colors.grey.shade400,
                        Colors.grey.shade500,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      module.icon,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Módulo ${module.id} - ${module.title}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            module.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: module.progress,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${(module.progress * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (!isAvailable)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Próximamente',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToModule(ModuleItem module) {
    if (module.screen != null) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => module.screen!,
          transitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 0.2);
            var end = Offset.zero;
            var curve = Curves.easeOutCubic;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
        ),
      );
    }
  }
}

class BackgroundPainter extends CustomPainter {
  final Color color;
  final double animValue;

  BackgroundPainter(this.color, this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Create a few subtle wave shapes
    final path = Path();

    // First wave
    final wave1Height = size.height * 0.3;
    final wave1Offset = size.height * 0.1 + math.sin(animValue * math.pi * 2) * 10;

    path.moveTo(0, wave1Offset);
    for (int i = 0; i <= size.width.toInt(); i += 60) {
      path.quadraticBezierTo(
        i + 30,
        wave1Offset + math.sin((i / size.width + animValue) * math.pi * 2) * 20,
        i + 60,
        wave1Offset,
      );
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Second wave
    final wave2Path = Path();
    final wave2Height = size.height * 0.7;
    final wave2Offset = size.height * 0.5 + math.cos(animValue * math.pi) * 15;

    wave2Path.moveTo(0, wave2Offset);
    for (int i = 0; i <= size.width.toInt(); i += 40) {
      wave2Path.quadraticBezierTo(
        i + 20,
        wave2Offset + math.sin((i / size.width + animValue + 0.5) * math.pi) * 15,
        i + 40,
        wave2Offset,
      );
    }
    wave2Path.lineTo(size.width, size.height);
    wave2Path.lineTo(0, size.height);
    wave2Path.close();

    canvas.drawPath(wave2Path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Model class for module items
class ModuleItem {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final double progress;
  final Widget? screen;

  ModuleItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.progress,
    required this.screen,
  });
}
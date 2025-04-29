import 'package:flutter/material.dart';
import '../models/learning_content.dart';

class Module1LearningContent {
  static List<LearningTopic> getTopics() {
    return [
      LearningTopic(
        id: 'algorithm_basics',
        title: 'Algoritmos',
        description: 'Secuencias de pasos para resolver problemas',
        color: Colors.blue,
        icon: Icons.auto_awesome,
        concepts: [
          // Concept 1: Definición y Características
          LearningConcept(
            id: 'definition',
            title: 'Definición y Características',
            shortDescription: 'Qué son y cómo funcionan',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🌟 ¿Qué es un Algoritmo? 🌟',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Color(0xFFFF5722),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Un algoritmo es una secuencia lógica de pasos para resolver problemas, similar a seguir una receta mágica.',
                  style: TextStyle(fontSize: 18.0, color: Colors.black87),
                ),
                SizedBox(height: 10.0),
                Text(
                  '✨ Características Clave:',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xFF9C27B0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '📋 Orden: Cada paso se ejecuta en secuencia.',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  '🔀 Decisión: Permite escoger entre diferentes caminos.',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
                Text(
                  '🔄 Repetición: Ejecuta bloques de instrucciones múltiples veces.',
                  style: TextStyle(
                    fontSize: 17.0,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // Uncomment if you want to display the image:
                // Image.asset('assets/images/recipe.png'),
              ],
            ),
            imageAssets: [],
          ),
          // Concept 2: Ejemplos de la Vida Diaria
          LearningConcept(
            id: 'real_life_examples',
            title: 'Ejemplos de la Vida Diaria',
            shortDescription: 'Los algoritmos están a nuestro alrededor',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🚀 Ejemplos Prácticos 🚀',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '🥪 Super Sándwich:',
                  style: TextStyle(
                    fontSize: 26.0,
                    backgroundColor: Color(0xFFFFEB3B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '1. Toma dos rebanadas de pan.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE65100),
                  ),
                ),
                Text(
                  '2. Unta mantequilla.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFA000),
                  ),
                ),
                Text(
                  '3. Agrega ingredientes (jamón, queso, etc.).',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF6F00),
                  ),
                ),
                Text(
                  '4. Junta las rebanadas.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF57F17),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '🏃‍♂️ Jugar a las Escondidas:',
                  style: TextStyle(
                    fontSize: 26.0,
                    backgroundColor: Color(0xFFB3E5FC),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '1. Una persona cuenta.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF0277BD),
                  ),
                ),
                Text(
                  '2. Los demás se esconden.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF01579B),
                  ),
                ),
                Text(
                  '3. Se busca al que cuenta.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF003366),
                  ),
                ),
                // Uncomment if you want to display the image:
                // Image.asset('assets/images/hide_and_seek.png'),
              ],
            ),
            imageAssets: [],
          ),
          // Concept 3: Estructuras de Control
          LearningConcept(
            id: 'control_structures',
            title: 'Estructuras de Control',
            shortDescription: 'Cómo controlar el flujo de un algoritmo',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🧠 Decisiones y Bucles 🔄',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFF7B1FA2),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black26,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '🔍 Decisiones:',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFFD81B60),
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
                Text(
                  'Utiliza condiciones para elegir el camino correcto.',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'Ejemplo: Si tienes hambre, prepara un sándwich; si no, continúa con otra tarea.',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '⭕ Bucles:',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF00838F),
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed,
                  ),
                ),
                Text(
                  'Repite instrucciones hasta cumplir un objetivo.',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  'Ejemplo: Repetir 5 veces: dar un paso y aplaudir.',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                // Uncomment if you want to display the image:
                // Image.asset('assets/images/flowchart_simple.png'),
              ],
            ),
            imageAssets: [],
          ),
          // Concept 4: Diagramas de Flujo
          LearningConcept(
            id: 'flowcharts',
            title: 'Diagramas de Flujo',
            shortDescription: 'Representación gráfica de algoritmos',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📊 Diagramas de Flujo 📈',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Color(0xFF3F51B5),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Utilizamos formas para representar las partes de un algoritmo:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '🟢 Óvalo: Inicio y Fin.',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '🟦 Rectángulo: Acción o proceso.',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFF1565C0),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '🔶 Rombo: Decisión o condición.',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFFFF8F00),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '➡️ Flechas: Indican la dirección del flujo.',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFF424242),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // Uncomment if you want to display the image:
                // Image.asset('assets/images/flowchart_symbols.png'),
              ],
            ),
            imageAssets: [],
          ),
          // Concept 5: Análisis de un Número
          LearningConcept(
            id: 'number_analysis',
            title: 'Análisis de un Número',
            shortDescription: 'Algoritmo práctico paso a paso',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🎮 Ejemplo: Análisis de un Número 🎲',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFE91E63),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 3.0,
                        color: Colors.black12,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Veamos cómo funciona este algoritmo:',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    foreground: Paint()..shader = LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFF44336)],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '🟢 Inicio',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '📝 Leer número',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF0D47A1),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '🔶 Decisión: ¿Es mayor que 10?',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFFFF8F00),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SÍ → Mostrar "Es grande"',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      Text(
                        'NO → Mostrar "Es pequeño"',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF44336),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '🟢 Fin',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                // Uncomment if you want to display the image:
                // Image.asset('assets/images/flowchart_example.png'),
              ],
            ),
            imageAssets: [],
          ),
          // Concept 6: Secuencia
          LearningConcept(
            id: 'sequence',
            title: 'Secuencia',
            shortDescription: 'Pasos en orden específico',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📋 Secuencia 🔢',
                  style: TextStyle(
                    fontSize: 32.0,
                    backgroundColor: Color(0xFFE1F5FE),
                    color: Color(0xFF01579B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'La secuencia consiste en seguir pasos en un orden específico.',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '✨ Ejemplo Visual:',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color(0xFF7B1FA2),
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '1. 💧 Lavar manos',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFF33691E),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '2. 🥕 Preparar ingredientes',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFFFF6F00),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  '3. 🍳 Cocinar',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFFD84315),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                // Uncomment if you want to display the image:
                // Image.asset('assets/images/sequence.png'),
              ],
            ),
            imageAssets: [],
          ),
          // Concept 7: Decisiones
          LearningConcept(
            id: 'decisions',
            title: 'Decisiones',
            shortDescription: 'Bifurcaciones en algoritmos',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🔀 Condicionales ❓',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFC2185B),
                    fontFamily: 'Cursive',
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Permiten ejecutar diferentes acciones según la situación.',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '🌈 Ejemplo:',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFF6A1B9A),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(15.0),
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '☀️ Si está soleado:',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Color(0xFFE65100),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Salir a jugar',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFFFF6F00),
                          ),
                        ),
                      ),
                      Text(
                        '🌧️ Si llueve:',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          'Leer un libro',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF0288D1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Uncomment if you want to display the image:
                // Image.asset('assets/images/conditional.png'),
              ],
            ),
            imageAssets: [],
          ),
          // Concept 8: Bucles
          LearningConcept(
            id: 'loops',
            title: 'Bucles',
            shortDescription: 'Repetición de instrucciones',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🔄 Bucles 🔁',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Color(0xFF00796B),
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Ejecutan repetidamente instrucciones hasta cumplir una condición.',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '🎯 Tipos:',
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Color(0xFF0277BD),
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.wavy,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '🔢 For:',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Color(0xFF303F9F),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Flexible(
                        child: Text(
                          'Repite un número específico de veces.',
                          style: TextStyle(
                            fontSize: 19.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '⏳ While:',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Color(0xFF00695C),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Flexible(
                        child: Text(
                          'Repite mientras se cumpla la condición.',
                          style: TextStyle(
                            fontSize: 19.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '🧮 Ejemplo: Sumar números del 1 al 10.',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                // Uncomment if you want to display the image:
                // Image.asset('assets/images/loops.png'),
              ],
            ),
            imageAssets: ["assets/images/loops.png"],
          ),
        ],
      ),
    ];
  }
}

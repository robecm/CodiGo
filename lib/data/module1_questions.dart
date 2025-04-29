import 'package:flutter/material.dart';
import '../models/learning_content.dart';

class Module1Questions {
  static LearningTopic getQuizTopic() {
    return LearningTopic(
      id: 'module1_quiz',
      title: 'Quiz - Conceptos Básicos',
      description: 'Pon a prueba tus conocimientos',
      color: Color(0xFF8E24AA),
      icon: Icons.quiz,
      concepts: [
        // Question A
        LearningConcept(
          id: 'qA_inicio',
          title: 'Pregunta A',
          shortDescription: 'Etapa clave',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Se trata de una etapa clave para el éxito de una tarea, ya que sirve para trazar una línea temporal de los pasos posteriores.',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF01579B),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'A) Inicio',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'B) Preparación',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'C) Final',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'D) Principio',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE1F5FE),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Respuesta correcta: A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          imageAssets: [],
        ),

        // Question B
        LearningConcept(
          id: 'qB_proceso',
          title: 'Pregunta B',
          shortDescription: 'Conjunto de fenómenos',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conjunto de fenómenos que se desarrollan en un periodo de tiempo finito o infinito y cuyas fases sucesivas suelen conducir hacia un fin específico',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF01579B),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'A) Proceso',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'B) Metodología',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'C) Desarrollo',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'D) Secuencia',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE1F5FE),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Respuesta correcta: A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          imageAssets: [],
        ),

        // Question C
        LearningConcept(
          id: 'qC_final',
          title: 'Pregunta C',
          shortDescription: 'Punto culminante',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Punto culminante o la conclusión de algo. Puede referirse al cierre de una etapa, la resolución de un conflicto o la última parte de una secuencia de eventos.',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF01579B),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'A) Final',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'B) Conclusión',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'C) Culminación',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'D) Terminación',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE1F5FE),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Respuesta correcta: A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          imageAssets: [],
        ),

        // Question 1 - Tomando Agua
        LearningConcept(
          id: 'q1_vaso',
          title: 'Pregunta 1',
          shortDescription: 'Inicio del proceso',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¿Por dónde empiezas para beber agua?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC2185B),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'A) Buscar un vaso',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'B) Bebes agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'C) Abrir el grifo',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'D) Servir el agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Respuesta correcta: A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          imageAssets: [],
        ),

        // Question 2
        LearningConcept(
          id: 'q2_fuente',
          title: 'Pregunta 2',
          shortDescription: 'Siguiente paso',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Una vez encontrado el vaso, ¿qué haces?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC2185B),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'A) Buscas una fuente de agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'B) Lo agarras',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'C) Bebes el agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'D) Limpias el vaso',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Respuesta correcta: A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          imageAssets: [],
        ),

        // Question 3
        LearningConcept(
          id: 'q3_colocar',
          title: 'Pregunta 3',
          shortDescription: 'Próximo paso',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Encontraste la fuente de agua, ¿Qué sigue?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00796B),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'A) Colocar el vaso en la salida de agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'B) Llenar el vaso',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'C) Tomar el agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'D) Abrir el grifo',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Respuesta correcta: A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          imageAssets: [],
        ),

        // Question 4
        LearningConcept(
          id: 'q4_servir',
          title: 'Pregunta 4',
          shortDescription: 'Continuación',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ya colocaste el vaso, ¿Cómo continuamos?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00796B),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'A) Te sirves la cantidad deseada',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'B) Derramas el agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'C) Tomar el agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'D) Cerrar el grifo',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Respuesta correcta: A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          imageAssets: [],
        ),

        // Question 5
        LearningConcept(
          id: 'q5_tomar',
          title: 'Pregunta 5',
          shortDescription: 'Paso final',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tienes tu vaso con la cantidad que querías, ¿Ahora qué haces?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00796B),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'A) Tomas el agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'B) Dejas el vaso',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'C) Tiras el agua',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'D) Guardas el agua para después',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Respuesta correcta: A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          imageAssets: [],
        ),
      ],
    );
  }

  static LearningConcept getQuestionByIndex(int index) {
    // Adjust index to be 0-based for array access
    int adjustedIndex = index - 1;

    // Boundary check
    if (adjustedIndex < 0 || adjustedIndex >= getQuizTopic().concepts.length) {
      // Return a default question if out of bounds
      return LearningConcept(
        id: 'error_question',
        title: 'Pregunta no disponible',
        shortDescription: 'Error',
        content: Column(
          children: [
            Text('Esta pregunta no existe'),
          ],
        ),
        imageAssets: [],
      );
    }

    return getQuizTopic().concepts[adjustedIndex];
  }

  static Map<String, dynamic> getQuestionData(int index) {
    // Return question data in the format needed by MultipleOptionQuestionScreen
    switch (index) {
      case 1:
        return {
          'question': 'Se trata de una etapa clave para el éxito de una tarea, ya que sirve para trazar una línea temporal de los pasos posteriores.',
          'options': [
            'Inicio',
            'Preparación',
            'Final',
            'Principio',
          ],
          'correctOptionIndex': 0, // Inicio is correct
        };
      case 2:
        return {
          'question': 'Conjunto de fenómenos que se desarrollan en un periodo de tiempo finito o infinito y cuyas fases sucesivas suelen conducir hacia un fin específico',
          'options': [
            'Proceso',
            'Metodología',
            'Desarrollo',
            'Secuencia',
          ],
          'correctOptionIndex': 0, // Proceso is correct
        };
      case 3:
        return {
          'question': 'Punto culminante o la conclusión de algo. Puede referirse al cierre de una etapa, la resolución de un conflicto o la última parte de una secuencia de eventos.',
          'options': [
            'Final',
            'Conclusión',
            'Culminación',
            'Terminación',
          ],
          'correctOptionIndex': 0, // Final is correct
        };
      case 4:
        return {
          'question': '¿Por dónde empiezas para beber agua?',
          'options': [
            'Buscar un vaso',
            'Bebes agua',
            'Abrir el grifo',
            'Servir el agua',
          ],
          'correctOptionIndex': 0, // Buscar un vaso is correct
        };
      case 5:
        return {
          'question': 'Una vez encontrado el vaso, ¿qué haces?',
          'options': [
            'Buscas una fuente de agua',
            'Lo agarras',
            'Bebes el agua',
            'Limpias el vaso',
          ],
          'correctOptionIndex': 0, // Buscas una fuente de agua is correct
        };
      case 6:
        return {
          'question': 'Encontraste la fuente de agua, ¿Qué sigue?',
          'options': [
            'Colocar el vaso en la salida de agua',
            'Llenar el vaso',
            'Tomar el agua',
            'Abrir el grifo',
          ],
          'correctOptionIndex': 0, // Colocar el vaso en la salida de agua is correct
        };
      case 7:
        return {
          'question': 'Ya colocaste el vaso, ¿Cómo continuamos?',
          'options': [
            'Te sirves la cantidad deseada',
            'Derramas el agua',
            'Tomar el agua',
            'Cerrar el grifo',
          ],
          'correctOptionIndex': 0, // Te sirves la cantidad deseada is correct
        };
      case 8:
        return {
          'question': 'Tienes tu vaso con la cantidad que querías, ¿Ahora qué haces?',
          'options': [
            'Tomas el agua',
            'Dejas el vaso',
            'Tiras el agua',
            'Guardas el agua para después',
          ],
          'correctOptionIndex': 0, // Tomas el agua is correct
        };
      default:
        return {
          'question': 'Pregunta no disponible',
          'options': ['Opción A', 'Opción B', 'Opción C', 'Opción D'],
          'correctOptionIndex': 0,
        };
    }
  }
}
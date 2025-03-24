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
          LearningConcept(
            id: 'definition',
            title: 'Definición y Características',
            shortDescription: 'Qué son y cómo funcionan',
            content: """# <span style="font-size: 32px; color: #FF5722">🌟 ¿Qué es un Algoritmo? 🌟</span>

Un algoritmo es una <span style="font-weight: 900; color: #1565C0">**secuencia lógica de pasos**</span> para resolver problemas, similar a seguir una <span style="font-style: italic; font-size: 18px">receta mágica</span>.

## <span style="font-size: 24px; color: #9C27B0">✨ Características Clave:</span>

- 📋 <span style="font-weight: 800; letter-spacing: 1px">**Orden:**</span> <span style="font-size: 17px">Cada paso se ejecuta en secuencia.</span>
- 🔀 <span style="font-weight: 800; letter-spacing: 1px">**Decisión:**</span> <span style="font-style: italic; font-size: 17px">Permite escoger entre diferentes caminos.</span>
- 🔄 <span style="font-weight: 800; letter-spacing: 1px">**Repetición:**</span> <span style="text-decoration: underline; font-size: 17px">Ejecuta bloques de instrucciones múltiples veces.</span>

![Receta visual](assets/images/recipe.png)
            """,
            imageAssets: [],
          ),
          LearningConcept(
            id: 'real_life_examples',
            title: 'Ejemplos de la Vida Diaria',
            shortDescription: 'Los algoritmos están a nuestro alrededor',
            content: """# <span style="font-size: 32px; color: #4CAF50">🚀 Ejemplos Prácticos 🚀</span>

## <span style="font-size: 26px; background-color: #FFEB3B; padding: 5px">🥪 **Super Sándwich:**</span>
1. <span style="font-size: 18px; font-weight: 700; color: #E65100">Toma dos rebanadas de pan.</span>
2. <span style="font-size: 18px; font-weight: 700; color: #FFA000">Unta mantequilla.</span>
3. <span style="font-size: 18px; font-weight: 700; color: #FF6F00">Agrega ingredientes (jamón, queso, etc.).</span>
4. <span style="font-size: 18px; font-weight: 700; color: #F57F17">Junta las rebanadas.</span>

## <span style="font-size: 26px; background-color: #B3E5FC; padding: 5px">🏃‍♂️ **Jugar a las Escondidas:**</span>
1. <span style="font-size: 18px; font-style: italic; color: #0277BD">Una persona cuenta.</span>
2. <span style="font-size: 18px; font-style: italic; color: #01579B">Los demás se esconden.</span>
3. <span style="font-size: 18px; font-style: italic; color: #003366">Se busca al que cuenta.</span>

![Ejemplo de juego](assets/images/hide_and_seek.png)
            """,
            imageAssets: [],
          ),
          LearningConcept(
            id: 'control_structures',
            title: 'Estructuras de Control',
            shortDescription: 'Cómo controlar el flujo de un algoritmo',
            content: """# <span style="font-size: 30px; color: #7B1FA2; text-shadow: 2px 2px 4px rgba(0,0,0,0.2)">🧠 Decisiones y Bucles 🔄</span>

## <span style="font-size: 25px; color: #D81B60; border-bottom: 3px dashed #D81B60">🔍 **Decisiones:**</span>
<span style="font-size: 18px">Utiliza condiciones para elegir el camino correcto.</span>
<span style="font-style: italic; font-size: 17px; color: #AD1457">*Ejemplo:*</span> <span style="font-weight: bold; font-size: 17px">Si tienes hambre,</span> prepara un sándwich; <span style="font-weight: bold; font-size: 17px">si no,</span> continúa con otra tarea.

## <span style="font-size: 25px; color: #00838F; border-bottom: 3px dashed #00838F">⭕ **Bucles:**</span>
<span style="font-size: 18px">Repite instrucciones hasta cumplir un objetivo.</span>
<span style="font-style: italic; font-size: 17px; color: #006064">*Ejemplo:*</span> <span style="font-weight: bold; letter-spacing: 1px">Repetir 5 veces:</span> dar un paso y aplaudir.

![Diagrama simple](assets/images/flowchart_simple.png)
            """,
            imageAssets: [],
          ),
          LearningConcept(
            id: 'flowcharts',
            title: 'Diagramas de Flujo',
            shortDescription: 'Representación gráfica de algoritmos',
            content: """# <span style="font-size: 32px; color: #3F51B5; font-weight: 900">📊 Diagramas de Flujo 📈</span>

<span style="font-size: 20px; font-style: italic">Utilizamos formas para representar las partes de un algoritmo:</span>

- <span style="font-size: 22px; color: #2E7D32">🟢 <span style="font-weight: 800">Óvalo:</span></span> <span style="font-size: 19px; font-style: italic">Inicio y Fin.</span>
- <span style="font-size: 22px; color: #1565C0">🟦 <span style="font-weight: 800">Rectángulo:</span></span> <span style="font-size: 19px; text-decoration: underline">Acción o proceso.</span>
- <span style="font-size: 22px; color: #FF8F00">🔶 <span style="font-weight: 800">Rombo:</span></span> <span style="font-size: 19px; letter-spacing: 1px">Decisión o condición.</span>
- <span style="font-size: 22px; color: #424242">➡️ <span style="font-weight: 800">Flechas:</span></span> <span style="font-size: 19px; font-weight: 600">Indican la dirección del flujo.</span>

![Símbolos de Diagrama](assets/images/flowchart_symbols.png)
            """,
            imageAssets: [],
          ),
          LearningConcept(
            id: 'number_analysis',
            title: 'Análisis de un Número',
            shortDescription: 'Algoritmo práctico paso a paso',
            content: """# <span style="font-size: 30px; color: #E91E63; text-shadow: 1px 1px 3px rgba(0,0,0,0.1)">🎮 Ejemplo: Análisis de un Número 🎲</span>

<span style="font-size: 22px; background: linear-gradient(90deg, #FF9800, #F44336); -webkit-background-clip: text; color: transparent; font-weight: bold; letter-spacing: 1.5px">Veamos cómo funciona este algoritmo:</span>

1. <span style="font-size: 20px; color: #2E7D32; font-weight: 900">**🟢 Inicio**</span>
2. <span style="font-size: 20px; color: #0D47A1; font-weight: 800">**📝 Leer número**</span>
3. <span style="font-size: 20px; color: #FF8F00; font-weight: 800">**🔶 Decisión:**</span>
   <span style="margin-left: 20px; font-size: 18px; font-style: italic">¿Es mayor que 10?</span>
   - <span style="margin-left: 30px; font-weight: 700; color: #4CAF50">SÍ → Mostrar "Es grande"</span>
   - <span style="margin-left: 30px; font-weight: 700; color: #F44336">NO → Mostrar "Es pequeño"</span>
4. <span style="font-size: 20px; color: #2E7D32; font-weight: 900">**🟢 Fin**</span>

![Diagrama de Flujo](assets/images/flowchart_example.png)
            """,
            imageAssets: [],
          ),
          LearningConcept(
            id: 'sequence',
            title: 'Secuencia',
            shortDescription: 'Pasos en orden específico',
            content: """# <span style="font-size: 32px; background-color: #E1F5FE; color: #01579B; padding: 5px; border-radius: 10px">📋 Secuencia 🔢</span>

<span style="font-size: 20px; font-weight: 700">La secuencia consiste en seguir pasos en un orden específico.</span>

## <span style="font-size: 24px; color: #7B1FA2; text-decoration: underline">✨ **Ejemplo Visual:**</span>

<div style="background-color: #F1F8E9; padding: 10px; border-radius: 8px; border-left: 5px solid #8BC34A">
<span style="font-size: 22px; color: #33691E; font-weight: 800">1. 💧 <span style="font-weight: normal">Lavar manos</span></span>
<span style="font-size: 22px; color: #FF6F00; font-weight: 800">2. 🥕 <span style="font-weight: normal">Preparar ingredientes</span></span>
<span style="font-size: 22px; color: #D84315; font-weight: 800">3. 🍳 <span style="font-weight: normal">Cocinar</span></span>
</div>

![Pasos en Secuencia](assets/images/sequence.png)
            """,
            imageAssets: [],
          ),
          LearningConcept(
            id: 'decisions',
            title: 'Decisiones',
            shortDescription: 'Bifurcaciones en algoritmos',
            content: """# <span style="font-size: 30px; color: #C2185B; font-family: cursive">🔀 Condicionales ❓</span>

<span style="font-size: 20px; font-weight: 600; letter-spacing: 0.5px">Permiten ejecutar diferentes acciones según la situación.</span>

## <span style="font-size: 25px; color: #6A1B9A; font-style: italic">🌈 *Ejemplo:*</span>

<div style="background-color: #FFF3E0; padding: 15px; border-radius: 12px; margin: 10px 0">
<span style="font-size: 22px; font-weight: 700; color: #E65100">☀️ Si está soleado:</span>
<span style="font-size: 20px; margin-left: 25px; font-style: italic; color: #FF6F00">Salir a jugar</span>

<span style="font-size: 22px; font-weight: 700; color: #1565C0">🌧️ Si llueve:</span>
<span style="font-size: 20px; margin-left: 25px; font-style: italic; color: #0288D1">Leer un libro</span>
</div>

![Decisión Visual](assets/images/conditional.png)
            """,
            imageAssets: [],
          ),
          LearningConcept(
            id: 'loops',
            title: 'Bucles',
            shortDescription: 'Repetición de instrucciones',
            content: """# <span style="font-size: 32px; color: #00796B; text-shadow: 0 2px 4px rgba(0,0,0,0.2)">🔄 Bucles 🔁</span>

<span style="font-size: 20px; color: #00695C; font-weight: 600; letter-spacing: 0.8px; line-height: 1.6">Ejecutan repetidamente instrucciones hasta cumplir una condición.</span>

## <span style="font-size: 26px; color: #0277BD; text-decoration: underline wavy">🎯 **Tipos:**</span>

<div style="background-color: #E8EAF6; padding: 10px; border-radius: 8px; margin-bottom: 15px">
<span style="font-size: 22px; color: #303F9F; font-weight: 700">🔢 **For:**</span> <span style="font-size: 19px; font-style: italic">Repite un número específico de veces.</span>
</div>

<div style="background-color: #E0F2F1; padding: 10px; border-radius: 8px; margin-bottom: 15px">
<span style="font-size: 22px; color: #00695C; font-weight: 700">⏳ **While:**</span> <span style="font-size: 19px; font-style: italic">Repite mientras se cumpla la condición.</span>
</div>

## <span style="font-size: 24px; color: #D81B60; font-style: italic">🧮 *Ejemplo:*</span>
<span style="font-size: 20px; font-weight: 700; letter-spacing: 0.5px; color: #AD1457">Sumar números del 1 al 10.</span>

![Bucle Visual](assets/images/loops.png)
            """,
            imageAssets: ["assets/images/loops.png"],
          ),
        ],
      ),
    ];
  }
}
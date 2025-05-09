import 'package:flutter/material.dart';
import '../controllers/trivia_controller.dart';

import '../services/trivia_service.dart';
import 'trivia_result_screen.dart';

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({super.key});

  @override
  State<TriviaScreen> createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  late TriviaController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questions = await TriviaService.fetchFromFirestore();
    questions.shuffle(); // Mezcla preguntas
    setState(() {
      controller = TriviaController(questions);
      isLoading = false;
    });
  }

  void _handleAnswer(int selectedIndex) {
    setState(() {
      controller.answer(selectedIndex);
    });

    // Espera un microsegundo antes de redirigir (para evitar errores de render)
    Future.delayed(const Duration(milliseconds: 100), () {
      if (controller.isFinished) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TriviaResultScreen(
              score: controller.score,
              total: controller.questions.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    if (controller.questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No se encontraron preguntas en Firestore')),
      );
    }

    if (controller.isFinished) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final q = controller.currentQuestion;

    return Scaffold(
      appBar: AppBar(title: const Text('Trivia Pokémon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              q.question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(q.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: () => _handleAnswer(index),
                  child: Text(q.options[index]),
                ),
              );
            }),
            const SizedBox(height: 16),
            Text('Pregunta ${controller.currentIndex + 1} de ${controller.questions.length}'),
          ],
        ),
      ),
    );
  }
}

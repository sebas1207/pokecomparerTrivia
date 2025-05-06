import 'package:flutter/material.dart';

class TriviaResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const TriviaResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado de Trivia')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¡Obtuviste $score de $total puntos!', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}

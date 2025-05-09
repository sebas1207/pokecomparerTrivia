import 'package:flutter/material.dart';
import '../services/trivia_service.dart';
import 'home_screen.dart';

class TriviaResultScreen extends StatefulWidget {
  final int score;
  final int total;

  const TriviaResultScreen({super.key, required this.score, required this.total});

  @override
  State<TriviaResultScreen> createState() => _TriviaResultScreenState();
}

class _TriviaResultScreenState extends State<TriviaResultScreen> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _saveScore();
  }

  Future<void> _saveScore() async {
    await TriviaService.saveScore(score: widget.score, total: widget.total);
    setState(() {
      isSaved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado de Trivia')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¡Obtuviste ${widget.score} de ${widget.total} puntos!',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            if (!isSaved) const CircularProgressIndicator(),
            if (isSaved)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Volver al inicio'),
              ),
          ],
        ),
      ),
    );
  }
}

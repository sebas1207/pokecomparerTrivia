import 'package:flutter/material.dart';
import 'select_pokemon_screen.dart';
import 'trivia_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PokéComparer & Trivia')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SelectPokemonScreen())),
              child: const Text('Comparar Pokémon'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TriviaScreen())),
              child: const Text('Trivia Pokémon'),
            ),
          ],
        ),
      ),
    );
  }
}

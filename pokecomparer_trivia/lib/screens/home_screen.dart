import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth/login_screen.dart';
import 'trivia_screen.dart';
import 'favorites_screen.dart';
import 'select_pokemon_screen.dart';
import 'trivia_history_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool resetSelection;

  const HomeScreen({super.key, this.resetSelection = false});

  void _logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Cerrar sesión')),
        ],
      ),
    );

    if (confirm == true) {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokéComparer & Trivia'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SelectPokemonScreen(clearOnLoad: true),
                  ),
                );
              },
              child: const Text('Comparar Pokémon'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TriviaScreen()));
              },
              child: const Text('Trivia Pokémon'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
              },
              child: const Text('Ver favoritos'),
            ),
             const SizedBox(height: 16),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(_) => const TriviaHistoryScreen()));
              }, 
            child: const Text('Historial de Trivia')
            ),
          ],
        ),
      ),
    );
  }
}

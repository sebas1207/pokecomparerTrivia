import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../models/pokemon.dart';
import 'compare_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<Map<String, dynamic>>> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = FavoritesService.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comparaciones favoritas')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _favorites,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No tienes favoritos aun'));
            }
            final comparisons = snapshot.data!;
            return ListView.builder(
              itemCount: comparisons.length,
              itemBuilder: (context, index) {
                final comp = comparisons[index];
                final pokemon1 = Pokemon.fromMap(comp['pokemon1']);
                final pokemon2 = Pokemon.fromMap(comp['pokemon2']);

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CompareScreen(
                              pokemon1: pokemon1, pokemon2: pokemon2),
                        ),
                      );
                    },
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                        '${pokemon1.name.toUpperCase()} vs ${pokemon2.name.toUpperCase()}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildPokemonInfo(pokemon1),
                            const SizedBox(width: 16),
                            _buildPokemonInfo(pokemon2),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  Widget _buildPokemonInfo(Pokemon pokemon) {
    return Column(
      children: [
        Image.network(pokemon.imageUrl, width: 60, height: 60),
        const SizedBox(height: 4),
        Text(pokemon.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(pokemon.types.join(', '),
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

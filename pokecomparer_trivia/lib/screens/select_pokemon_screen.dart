import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import 'compare_screen.dart';

class SelectPokemonScreen extends StatefulWidget {
  final bool clearOnLoad;
  const SelectPokemonScreen({super.key, this.clearOnLoad = false});

  @override
  State<SelectPokemonScreen> createState() => _SelectPokemonScreenState();
}

class _SelectPokemonScreenState extends State<SelectPokemonScreen> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  Pokemon? pokemon1;
  Pokemon? pokemon2;

  @override
  void initState() {
    super.initState();
    if (widget.clearOnLoad) {
      pokemon1 = null;
      pokemon2 = null;
      _controller1.clear();
      _controller2.clear();
    }
  }

  Future<void> _searchPokemon(String name, int slot) async {
    if (name.trim().isEmpty) {
      _showError('Por favor ingresa un nombre válido');
      return;
    }

    try {
      final poke = await PokemonService.fetchPokemonByName(name);
      if (poke != null) {
        setState(() {
          if (slot == 1) {
            pokemon1 = poke;
          } else {
            pokemon2 = poke;
          }
        });
      } else {
        _showError('Pokémon no encontrado');
      }
    } catch (_) {
      _showError('Error al buscar Pokémon');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildPokemonCard(Pokemon? pokemon, String label) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(12),
            image: pokemon != null
                ? DecorationImage(
                    image: NetworkImage(pokemon.imageUrl),
                    fit: BoxFit.contain,
                  )
                : const DecorationImage(
                    image: AssetImage('assets/DefaultBall.png'),
                    fit: BoxFit.contain,
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (pokemon != null)
          Column(
            children: [
              Text('HP: ${pokemon.hp}'),
              Text('ATK: ${pokemon.attack}'),
              Text('DEF: ${pokemon.defense}'),
              Text('SP.ATK: ${pokemon.specialAttack}'),
              Text('SP.DEF: ${pokemon.specialDefense}'),
              Text('SPD: ${pokemon.speed}'),
              Text('Tipo: ${pokemon.types.join(', ')}'),
            ],
          )
        else
          const Text('Información no cargada'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokéComparer & Trivia'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      _buildPokemonCard(pokemon1, 'POKÉMON 1'),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 130,
                        child: TextField(
                          controller: _controller1,
                          decoration: const InputDecoration(labelText: 'Buscar Pokémon 1'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _searchPokemon(_controller1.text, 1),
                        child: const Text('Buscar'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      _buildPokemonCard(pokemon2, 'POKÉMON 2'),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 130,
                        child: TextField(
                          controller: _controller2,
                          decoration: const InputDecoration(labelText: 'Buscar Pokémon 2'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _searchPokemon(_controller2.text, 2),
                        child: const Text('Buscar'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (pokemon1 != null && pokemon2 != null)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompareScreen(
                              pokemon1: pokemon1!,
                              pokemon2: pokemon2!,
                            ),
                          ),
                        );
                      }
                    : null,
                child: const Text('Ver gráfica de comparación'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

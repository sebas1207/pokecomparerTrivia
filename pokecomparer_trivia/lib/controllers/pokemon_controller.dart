import '../models/pokemon.dart';

class PokemonController {

  final Pokemon pokemon1;
  final Pokemon pokemon2;

  PokemonController({required this.pokemon1, required this.pokemon2});

  List<Map<String, dynamic>> getComparisonData() {
    return [
      {'stat': 'HP', 'pokemon1': pokemon1.hp, 'pokemon2': pokemon2.hp},
      {'stat': 'Attack', 'pokemon1': pokemon1.attack, 'pokemon2': pokemon2.attack},
      {'stat': 'Defense', 'pokemon1': pokemon1.defense, 'pokemon2': pokemon2.defense},
      {'stat': 'Sp. Atk', 'pokemon1': pokemon1.specialAttack, 'pokemon2': pokemon2.specialAttack},
      {'stat': 'Sp. Def', 'pokemon1': pokemon1.specialDefense, 'pokemon2': pokemon2.specialDefense},
      {'stat': 'Speed', 'pokemon1': pokemon1.speed, 'pokemon2': pokemon2.speed}
    ];
  }

  
}

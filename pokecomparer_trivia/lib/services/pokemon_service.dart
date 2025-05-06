import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static Future<List<Pokemon>> fetchPokemons() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=493');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List pokemons = data['results'];

      List<Pokemon> pokemonList = [];
      for (var poke in pokemons) {
        final pokeDetails = await http.get(Uri.parse(poke['url']));
        if (pokeDetails.statusCode == 200) {
          final pokeData = json.decode(pokeDetails.body);
          pokemonList.add(Pokemon.fromJson(pokeData));
        }
      }
      return pokemonList;
    } else {
      throw Exception('Error al cargar Pokémon');
    }
  }

  static Future<Pokemon?> fetchPokemonByName(String name) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/${name.toLowerCase()}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Pokemon.fromJson(data);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}

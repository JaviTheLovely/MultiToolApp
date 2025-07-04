import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  static Future<Map<String, dynamic>?> fetchPokemon(String name) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final abilities = (data['abilities'] as List)
            .map((a) => a['ability']['name'] as String)
            .toList();

        return {
          'image': data['sprites']['front_default'],
          'baseExperience': data['base_experience'],
          'abilities': abilities,
          'cryUrl': 'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/${data['id']}.ogg',
        };
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}

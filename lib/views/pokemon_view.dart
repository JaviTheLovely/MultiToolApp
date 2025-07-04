import 'package:flutter/material.dart';
import '../services/pokemon_service.dart';
import 'package:audioplayers/audioplayers.dart';

class PokemonView extends StatefulWidget {
  const PokemonView({super.key});

  @override
  State<PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? pokemonData;
  bool isLoading = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _searchPokemon() async {
    final name = _controller.text.trim().toLowerCase();
    if (name.isEmpty) return;

    setState(() {
      isLoading = true;
      pokemonData = null;
    });

    final data = await PokemonService.fetchPokemon(name);
    setState(() {
      pokemonData = data;
      isLoading = false;
    });

    if (data?['cryUrl'] != null) {
      await _audioPlayer.play(UrlSource(data!['cryUrl']));
    }
  }

  Widget _buildInfo() {
    if (pokemonData == null) return const Text('No se encontró el Pokémon');

    return Column(
      children: [
        Image.network(pokemonData!['image'], height: 150),
        const SizedBox(height: 10),
        Text('Experiencia base: ${pokemonData!['baseExperience']}'),
        const SizedBox(height: 10),
        Text('Habilidades: ${pokemonData!['abilities'].join(', ')}'),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _audioPlayer.play(UrlSource(pokemonData!['cryUrl']));
          },
          child: const Text('Reproducir sonido'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Pokémon')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Introduce el nombre del Pokémon (en inglés):'),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Ejemplo: pikachu',
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchPokemon,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (pokemonData != null)
              Expanded(child: _buildInfo()),
          ],
        ),
      ),
    );
  }
}
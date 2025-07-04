import 'package:flutter/material.dart';
import 'gender_predict_view.dart';
import 'age_predict_view.dart';
import 'universities_view.dart';
import 'weather_view.dart';
import 'pokemon_view.dart';
import 'wordpress_news_view.dart';
import 'about_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi Tool App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/toolbox.png', height: 150),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _navButton(context, 'Predicción de Género', const GenderPredictView()),
                _navButton(context, 'Predicción de Edad', const AgePredictView()),
                _navButton(context, 'Universidades por País', const UniversitiesView()),
                _navButton(context, 'Clima en RD', const WeatherView()),
                _navButton(context, 'Buscar Pokémon', const PokemonView()),
                _navButton(context, 'Noticias de WordPress', const WordPressNewsView()),
                _navButton(context, 'Acerca de mí', const AboutView()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, String title, Widget view) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: ElevatedButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => view)),
        child: Text(title),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '8099c78a9f52dfae903344df1f48795f';
  static const String _city = 'Santo Domingo';
  static String get _url =>
      'https://api.openweathermap.org/data/2.5/weather?q=${_city.replaceAll(' ', '+')},DO&appid=$_apiKey&units=metric&lang=es';

  static Future<Map<String, dynamic>?> getWeather() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final weather = data['weather'][0];
        final main = data['main'];

        return {
          'city': data['name'],
          'temp': main['temp'].toString(),
          'description': weather['description'],
          'iconUrl': 'https://openweathermap.org/img/wn/${weather['icon']}@2x.png',
        };
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}

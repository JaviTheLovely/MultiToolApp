import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UniversitiesService {
  static Future<List<Map<String, String>>> getUniversitiesByCountry(String country) async {
    final formattedCountry = country.replaceAll(' ', '+');
    final url = Uri.parse('http://universities.hipolabs.com/search?country=$formattedCountry');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map<Map<String, String>>((uni) {
          return {
            'name': uni['name'],
            'domain': (uni['domains'] as List).isNotEmpty ? uni['domains'][0] : '',
            'webPage': (uni['web_pages'] as List).isNotEmpty ? uni['web_pages'][0] : '',
          };
        }).toList();
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }

  static Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir el enlace: $url';
    }
  }
}

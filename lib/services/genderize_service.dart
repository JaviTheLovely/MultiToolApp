import 'dart:convert';
import 'package:http/http.dart' as http;

class GenderizeService {
  static Future<String?> predictGender(String name) async {
    final url = Uri.parse('https://api.genderize.io/?name=$name');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['gender'];
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}

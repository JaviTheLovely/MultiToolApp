import 'dart:convert';
import 'package:http/http.dart' as http;

class WordPressService {
  static const String _apiUrl = 'https://techcrunch.com/wp-json/wp/v2/posts?per_page=3';

  static Future<List<Map<String, String>>> fetchLatestPosts() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map<Map<String, String>>((post) {
          return {
            'title': post['title']['rendered'],
            'excerpt': _stripHtml(post['excerpt']['rendered']),
            'link': post['link'],
          };
        }).toList();
      } else {
        return [];
      }
    } catch (_) {
      return [];
    }
  }

  static String _stripHtml(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}

import 'package:flutter/material.dart';
import '../services/wordpress_service.dart';
import 'package:url_launcher/url_launcher.dart';

class WordPressNewsView extends StatefulWidget {
  const WordPressNewsView({super.key});

  @override
  State<WordPressNewsView> createState() => _WordPressNewsViewState();
}

class _WordPressNewsViewState extends State<WordPressNewsView> {
  bool isLoading = true;
  List<Map<String, String>> posts = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final result = await WordPressService.fetchLatestPosts();
    setState(() {
      posts = result;
      isLoading = false;
    });
  }

  Widget _buildPostCard(Map<String, String> post) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(
        title: Text(post['title'] ?? ''),
        subtitle: Text(post['excerpt'] ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.open_in_browser),
          onPressed: () {
            final url = post['link'];
            if (url != null) {
              launchUrl(Uri.parse(url));
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Noticias de WordPress')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Image.asset('assets/images/wordpress_logo.png', height: 100),
            const SizedBox(height: 20),
            const Text(
              'Últimas noticias',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: posts.map(_buildPostCard).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

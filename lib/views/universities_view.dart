import 'package:flutter/material.dart';
import '../services/universities_service.dart';

class UniversitiesView extends StatefulWidget {
  const UniversitiesView({super.key});

  @override
  State<UniversitiesView> createState() => _UniversitiesViewState();
}

class _UniversitiesViewState extends State<UniversitiesView> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  List<Map<String, String>> universities = [];

  Future<void> _fetchUniversities() async {
    final country = _controller.text.trim();
    if (country.isEmpty) return;

    setState(() {
      isLoading = true;
      universities = [];
    });

    final results = await UniversitiesService.getUniversitiesByCountry(country);

    setState(() {
      universities = results;
      isLoading = false;
    });
  }

  Widget _buildUniversityCard(Map<String, String> uni) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: ListTile(
        title: Text(uni['name'] ?? ''),
        subtitle: Text(uni['domain'] ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.open_in_browser),
          onPressed: () {
            final url = uni['webPage'];
            if (url != null) {
              UniversitiesService.launchURL(url);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universidades por País')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Escribe el país en inglés (ej: Dominican Republic)'),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Ejemplo: Dominican Republic',
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchUniversities,
              child: const Text('Buscar Universidades'),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (universities.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: universities.length,
                  itemBuilder: (context, index) {
                    return _buildUniversityCard(universities[index]);
                  },
                ),
              )
            else
              const Text('No hay universidades aún.'),
          ],
        ),
      ),
    );
  }
}

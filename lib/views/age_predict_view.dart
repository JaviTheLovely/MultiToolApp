import 'package:flutter/material.dart';
import '../services/agify_service.dart';

class AgePredictView extends StatefulWidget {
  const AgePredictView({super.key});

  @override
  State<AgePredictView> createState() => _AgePredictViewState();
}

class _AgePredictViewState extends State<AgePredictView> {
  final TextEditingController _controller = TextEditingController();
  int? age;
  String? category;
  bool isLoading = false;
  String? errorMessage;

  Future<void> _predictAge() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
      age = null;
      category = null;
    });

    final result = await AgifyService.predictAge(name);

    if (result != null) {
      String newCategory;
      if (result < 30) {
        newCategory = 'joven';
      } else if (result < 55) {
        newCategory = 'adulto';
      } else {
        newCategory = 'anciano';
      }

      setState(() {
        age = result;
        category = newCategory;
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = 'No se pudo predecir la edad para ese nombre.';
        isLoading = false;
      });
    }
  }

  String _getImagePath(String? category) {
    switch (category) {
      case 'joven':
        return 'assets/images/young.png';
      case 'adulto':
        return 'assets/images/adult.png';
      case 'anciano':
        return 'assets/images/elderly.png';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predicción de Edad')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Introduce un nombre:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Ejemplo: Meelad',
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : _predictAge,
              child: const Text('Predecir Edad'),
            ),
            const SizedBox(height: 30),
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              )
            else if (age != null && category != null)
                Column(
                  children: [
                    Text(
                      'Edad estimada: $age años',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Categoría: $category',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    if (_getImagePath(category).isNotEmpty)
                      Image.asset(
                        _getImagePath(category),
                        height: 150,
                      ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}

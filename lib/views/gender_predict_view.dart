import 'package:flutter/material.dart';
import '../services/genderize_service.dart';

class GenderPredictView extends StatefulWidget {
  const GenderPredictView({super.key});

  @override
  State<GenderPredictView> createState() => _GenderPredictViewState();
}

class _GenderPredictViewState extends State<GenderPredictView> {
  final TextEditingController _controller = TextEditingController();
  String? gender;
  bool isLoading = false;

  Future<void> _predictGender() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final result = await GenderizeService.predictGender(name);

    setState(() {
      gender = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (gender == 'male') {
      backgroundColor = Colors.blue.shade700;
    } else if (gender == 'female') {
      backgroundColor = Colors.pink.shade400;
    } else {
      backgroundColor = Colors.grey.shade800;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Predicción de Género')),
      body: Container(
        padding: const EdgeInsets.all(20),
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Introduce un nombre:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Ejemplo: Irma',
                filled: true,
                fillColor: Colors.white,
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _predictGender,
              child: const Text('Predecir Género'),
            ),
            const SizedBox(height: 30),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading && gender != null)
              Text(
                gender == 'male'
                    ? 'Género: Masculino'
                    : gender == 'female'
                    ? 'Género: Femenino'
                    : 'Género desconocido',
                style: const TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}

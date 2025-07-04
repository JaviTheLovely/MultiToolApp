import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Acerca de mí')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto personal con const porque es totalmente estático
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/icons/app_icon.png'),
              ),
              SizedBox(height: 20),

              // Textos simples con const para optimizar
              Text(
                'Javi The Lovely',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Text(
                'Estudiante de tecnología | Desarrollador Flutter',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),

              // Textos con emojis y saltos de línea NO pueden ser const
              Text(
                '📧 Email: javi@example.com\n📱 Tel: +1 809-123-4567\n🌐 GitHub: github.com/javi',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // Texto con salto de línea y estilo, solo el estilo es const
              Text(
                'Gracias por visitar mi app.\nEstoy disponible para trabajar en proyectos móviles y web.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final desarrolladores = [
      {
        'nombre': 'Cristian Ronaldo Trujillo Gómez',
        'rol': 'Líder del proyecto / Backend',
        'imagen': 'assets/images/perfil4.jpg'
      },
      {
        'nombre': 'Evelyn Jazmín Pérez Sánchez',
        'rol': 'Desarrollador Frontend',
        'imagen': 'assets/images/perfil1.jpg'
      },
      {
        'nombre': 'Bryan de Jesús Hernández Luna',
        'rol': 'Diseñador UI/UX',
        'imagen': 'assets/images/perfil3.jpg'
      },
      {
        'nombre': 'Noemisabel Zavala Ovando',
        'rol': 'Documentación',
        'imagen': 'assets/images/perfil2.jpg'
      },
      {
        'nombre': 'Gerardo',
        'rol': 'Integración, QA y soporte técnico',
        'imagen': 'assets/images/gerardo.png'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nosotros'),
        backgroundColor: const Color(0xFF2F4157),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Logo y descripción
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  padding: const EdgeInsets.all(15),
                  child: const Icon(
                    Icons.agriculture,
                    color: Color(0xFF2F4157),
                    size: 70,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'AgroMarket',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F4157),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Conectando productores y compradores',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),

            // Equipo de desarrollo
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Equipo de Desarrollo',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Lista de desarrolladores
            ...desarrolladores.map(
              (dev) => Card(
                elevation: 4,
                shadowColor: Colors.grey.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(dev['imagen']!),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text(
                    dev['nombre']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    dev['rol']!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Descripción de la plataforma
          ],
        ),
      ),
    );
  }
}

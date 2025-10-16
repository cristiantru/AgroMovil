import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final desarrolladores = [
      {
        'nombre': 'Cristian Ronaldo Trujillo Gómez',
        'rol': 'Líder del proyecto / Backend',
        'descripcion':
            'Encargado del backend y la lógica de negocio, responsable de la arquitectura de la aplicación.',
        'imagen': 'assets/images/perfil4.jpg'
      },
      {
        'nombre': 'Evelyn Jazmín Pérez Sánchez',
        'rol': 'Desarrollador Frontend',
        'descripcion':
            'Diseña la interfaz y experiencia de usuario, implementando pantallas y animaciones.',
        'imagen': 'assets/images/perfil1.jpg'
      },
      {
        'nombre': 'Bryan de Jesús Hernández Luna',
        'rol': 'Diseñador UI/UX',
        'descripcion':
            'Crea los prototipos visuales, mockups y elementos gráficos de la aplicación.',
        'imagen': 'assets/images/perfil3.jpg'
      },
      {
        'nombre': 'Noemisabel Zavala Ovando',
        'rol': 'Documentación',
        'descripcion':
            'Elabora la documentación del proyecto y guía de uso para usuarios y desarrolladores.',
        'imagen': 'assets/images/perfil2.jpg'
      },
      {
        'nombre': 'Gerardo',
        'rol': 'Integración, QA y soporte técnico',
        'descripcion':
            'Realiza pruebas, asegura la calidad del proyecto y da soporte técnico a los desarrolladores.',
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
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.agriculture,
                    color: Color(0xFF2F4157),
                    size: 80,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'AgroMarket',
                  style: TextStyle(
                    fontSize: 32,
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
                  textAlign: TextAlign.center,
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Lista de desarrolladores en tarjetas detalladas
            ...desarrolladores.map(
              (dev) => Card(
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(dev['imagen']!),
                        backgroundColor: Colors.grey[200],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dev['nombre']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF2F4157),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              dev['rol']!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              dev['descripcion']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Descripción general de la plataforma
            Card(
              elevation: 4,
              shadowColor: Colors.grey.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    Text(
                      'Sobre AgroMarket',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

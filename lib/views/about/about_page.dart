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
        'imagen': 'assets/images/image.png'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      appBar: AppBar(
        title: const Text(
          'Sobre Nosotros',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2F4157),
        centerTitle: true,
        elevation: 4,
        shadowColor: Colors.black26,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Logo principal con sombra y degradado
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2F4157), Color(0xFF4B6A89)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                children: const [
                  Icon(Icons.agriculture, color: Colors.white, size: 80),
                  SizedBox(height: 15),
                  Text(
                    'AgroMarket',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Conectando productores y compradores',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Información institucional en formato elegante
            Card(
              elevation: 8,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.school, color: Color(0xFF2F4157)),
                        SizedBox(width: 10),
                        Text(
                          'Datos Institucionales',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F4157),
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 1.2, height: 25),
                    Text(
                      '📅 CUATRIMESTRE:  Sep - Dic 2025\n'
                      'ASIGNATURA:  Desarrollo Móvil Integral\n'
                      'DOCENTE:  Armando Méndez Morales\n'
                      'UNIDAD DE APRENDIZAJE:  U2. Integración de servicios en la nube\n'
                      'EVIDENCIA DE APRENDIZAJE:  Presentación de investigación\n'
                      'GRADO, GRUPO(S):  10A\n'
                      'FECHA DE ENTREGA:  16 Oct 2025',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Título de equipo
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '👩‍💻 Equipo de Desarrollo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F4157),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Tarjetas de desarrolladores más visuales
            ...desarrolladores.map(
              (dev) => Card(
                elevation: 6,
                shadowColor: Colors.grey.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          dev['imagen']!,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
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
                                color: Colors.black54,
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

            const SizedBox(height: 35),

            // Descripción general de AgroMarket
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2F4157), Color(0xFF4B6A89)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Text(
                    'Sobre AgroMarket',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'AgroMarket es una aplicación móvil creada con el propósito de conectar a productores agrícolas con compradores interesados en adquirir productos frescos, locales y de calidad. '
                    'La plataforma promueve la digitalización del campo, integrando servicios en la nube para facilitar la comunicación, la gestión de ventas y la promoción de productos agrícolas.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

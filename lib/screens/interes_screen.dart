import 'package:flutter/material.dart';

class InteresScreen extends StatelessWidget {
  const InteresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Título principal
              const Center(
                child: Text(
                  '¿Qué te interesaría hacer dentro de nuestra aplicación?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Subtítulo
              const Center(
                child: Text(
                  'Selecciona la opción que mejor se adapte a lo que deseas realizar dentro de AgroMarket.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ✅ Opción 1: Vender mis productos
              GestureDetector(
                onTap: () {
                  // Aquí puedes navegar a la pantalla de VENDEDOR
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Vender mis productos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Registra tus cultivos o productos y conéctate con compradores interesados.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 15),
                      Image.asset(
                        'assets/vender.png', // 🌱 tu imagen
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),

              // ✅ Opción 2: Comprar productos locales
              GestureDetector(
                onTap: () {
                  // Aquí puedes navegar a la pantalla de COMPRADOR
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Comprar productos locales',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Explora cultivos y productos frescos de productores locales.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 15),
                      Image.asset(
                        'assets/comprar.png', // 🛒 tu imagen
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

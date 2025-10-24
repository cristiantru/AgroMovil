import 'package:flutter/material.dart';

class ListProductView extends StatelessWidget {
  const ListProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra de búsqueda específica para productos
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(30),
            shadowColor: Colors.black26,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Color(0xFF115213)),
                hintText: 'Buscar productos...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                enabledBorder: _buildInputBorder(const Color(0xFF115213), 1),
                focusedBorder: _buildInputBorder(const Color(0xFF115213), 2),
              ),
            ),
          ),
        ),
        
        // Contenido de productos
        Expanded(
          child: Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/logoagro.png',
                      height: 150,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Estilo del borde del campo de búsqueda
  OutlineInputBorder _buildInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
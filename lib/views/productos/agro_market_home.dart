// lib/views/productos/agro_market_home.dart
import 'dart:ui'; // necesario para BackdropFilter
import 'package:flutter/material.dart';

class AgroMarketHome extends StatefulWidget {
  final Function(String)? onCategorySelected;

  const AgroMarketHome({super.key, this.onCategorySelected});

  @override
  State<AgroMarketHome> createState() => _AgroMarketHomeState();
}

class _AgroMarketHomeState extends State<AgroMarketHome> {
  final List<Map<String, String>> categories = const [
    {"name": "Frutas", "image": "assets/frutas.png"},
    {"name": "Verduras", "image": "assets/verduras.png"},
    {"name": "Granos", "image": "assets/granos.png"},
    {"name": "Lácteos", "image": "assets/images/lacteos.jpg"},
    {"name": "Carnes", "image": "assets/images/carnes.jpg"},
    {"name": "Bebidas", "image": "assets/images/bebidas.jpg"},
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filtrar categorías según el buscador
    final filteredCategories = categories
        .where((category) =>
            category["name"]!
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6), // Fondo general
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Categorías"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "AgroMarket",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.50), // vidrioso
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF8BC34A), // borde verde
                      width: 1.2, // delgado
                    ),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Buscar categoría...",
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3 / 2,
        ),
        itemCount: filteredCategories.length,
        itemBuilder: (context, index) {
          final category = filteredCategories[index];
          return GestureDetector(
            onTap: () {
              if (widget.onCategorySelected != null) {
                widget.onCategorySelected!(category["name"]!);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(category["image"]!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Sombra para que el texto se vea mejor
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  Center(
                    child: Text(
                      category["name"]!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

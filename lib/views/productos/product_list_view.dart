import 'package:flutter/material.dart';
import 'product_detail_view.dart';

class ProductListView extends StatefulWidget {
  final String category;

  const ProductListView({super.key, required this.category});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late List<Map<String, dynamic>> allProducts;
  late List<Map<String, dynamic>> filteredProducts;
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> getProducts() {
    switch (widget.category) {
      case "Frutas":
        return [
          {
            "name": "Manzana",
            "price": 10,
            "description": "Recién cosechadas y jugosas",
            "image": "assets/frutas.png",
          },
          {
            "name": "Plátano",
            "price": 8,
            "description": "Dulces y frescos del campo",
            "image": "assets/frutas.png",
          },
        ];
      case "Verduras":
        return [
          {
            "name": "Aguacates",
            "price": 450,
            "description": "Recién cortados y frescos",
            "image": "assets/frutas.png",
          },
          {
            "name": "Zanahorias",
            "price": 80,
            "description": "Crujientes y dulces",
            "image": "assets/verduras.png",
          },
        ];
      default:
        return [
          {
            "name": "Producto genérico",
            "price": 20,
            "description": "Producto de ejemplo",
            "image": "assets/granos.png",
          }
        ];
    }
  }

  @override
  void initState() {
    super.initState();
    allProducts = getProducts();
    filteredProducts = allProducts;

    _searchController.addListener(() {
      filterProducts();
    });
  }

  void filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredProducts = allProducts
          .where((product) => product["name"].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Productos: ${widget.category}"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 Campo de búsqueda
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar producto...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🛒 Lista de productos filtrados
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailView(product: product),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Texto
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product["name"],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product["description"],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "\$${product["price"]}.0 por kilo",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Imagen
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              product["image"],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

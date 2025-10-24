import 'package:flutter/material.dart';
import 'cart.dart';
import 'cart_view.dart';

class ProductDetailView extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int quantity = 1; // cantidad inicial

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final double totalPrice = product["price"] * quantity;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(product["name"]),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(12),
                image: product["image"] != null
                    ? DecorationImage(
                        image: AssetImage(product["image"]),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: product["image"] == null
                  ? const Center(child: Text("Imagen del producto"))
                  : null,
            ),
            const SizedBox(height: 16),

            // Nombre y precio
            Text(
              product["name"],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${product["price"]}.0 por kilo",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Descripción
            Text(
              product["description"] ?? "Descripción del producto...",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            // 🔢 Selector de cantidad (kilos) con botones bonitos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón de menos
                ElevatedButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: const Color(0xFF115213), // Verde
                    elevation: 4,
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "$quantity kg",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                // Botón de más
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: const Color(0xFF115213), // Verde
                    elevation: 4,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 💰 Total dinámico
            Center(
              child: Text(
                "Total: \$${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 🛒 Botón agregar al carrito
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Cart.addItem({
                    "name": product["name"],
                    "price": product["price"],
                    "quantity": quantity,
                    "image": product["image"]
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartView(addedProduct: product),
                    ),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                label: const Text(
                  "Agregar al carrito",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 26, 128, 30),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

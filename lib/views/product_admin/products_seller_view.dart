import 'package:agromarket/estructure/product_estructure.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductEstructureView(
      currentIndex: 2, // ícono de productos activo
      showSearchBar: true, // muestra el buscador
      searchHint: 'Buscar productos...', // texto del buscador

      content: Center(
        child: Text(
          'Aquí van los productos',
          style: TextStyle(fontSize: 18),
        ),
      ),

      // Navegación entre vistas
      onHomeTap: () {
        Navigator.pushNamed(context, '/');
      },
      onProfileTap: () {
        Navigator.pushNamed(context, '/');
      },
      onProductsTap: () {
        // Ya estás en productos, puedes dejarlo vacío
      },
      onSearchTap: () {
        // Aquí podrías abrir una vista de búsqueda avanzada
      },
      onCartTap: () {
        Navigator.pushNamed(context, '/');
      },
    );
  }
}

import 'package:agromarket/estructure/product_estructure.dart';
import 'package:flutter/material.dart';

class ListProductView extends StatelessWidget {
  const ListProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductEstructureView(
      title: 'Mis Productossss',
      showSearchBar: true,
      searchHint: 'Buscar productos...',

      content: Center(
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
                  'assets/.png',
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
    );
  }
}
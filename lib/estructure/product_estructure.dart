import 'package:agromarket/views/auth/optiones_view.dart';
import 'package:agromarket/views/product_admin/list_product_view.dart';
import 'package:agromarket/views/product_admin/products_seller_view.dart';
import 'package:agromarket/views/profile/profile_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class ProductEstructureView extends StatefulWidget {
  final Widget? content;
  final String searchHint;
  final String? title; // 
  final VoidCallback? onProfileTap;
  final VoidCallback? onProductsTap;
  final VoidCallback? onCartTap;
  final Function(String)? onSearchChanged;

  final bool showSearchBar;
  final int currentIndex;

  const ProductEstructureView({
    super.key,
    this.content,
    this.title, 
    this.searchHint = "Buscar...",
    this.onProfileTap,
    this.onProductsTap,
    this.onCartTap,
    this.onSearchChanged,
    this.showSearchBar = true,
    this.currentIndex = 2, // inicializa en el ícono 
  });

  @override
  State<ProductEstructureView> createState() => _ProductEstructureViewState();
}

class _ProductEstructureViewState extends State<ProductEstructureView> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                child: Text(
                  widget.title!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF115213),
                  ),
                ),
              ),

            _buildSearchBar(),
            _buildContentArea(),
          ],
        ),
      ),
      bottomNavigationBar: _buildCurvedNavigationBar(),
    );
  }

  /// Barra de búsqueda
  Widget _buildSearchBar() {
    if (!widget.showSearchBar) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(30),
        shadowColor: Colors.black26,
        child: TextField(
          onChanged: widget.onSearchChanged,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Color(0xFF115213)),
            hintText: widget.searchHint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            enabledBorder: _buildInputBorder(const Color(0xFF115213), 1),
            focusedBorder: _buildInputBorder(const Color(0xFF115213), 2),
          ),
        ),
      ),
    );
  }


  Widget _buildContentArea() {
    return Expanded(
      child: widget.content ?? _buildEmptyContent(),
    );
  }
  Widget _buildEmptyContent() {
    return const Center(
      child: Text(
        'Contenido vacío',
        style: TextStyle(
          color: Color(0xFF666666),
          fontSize: 16,
        ),
      ),
    );
  }

  /// Barra de navegación inferior
  Widget _buildCurvedNavigationBar() {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 75,
      backgroundColor: Colors.transparent,
      color: const Color(0xFF8EBF75),
      buttonBackgroundColor: const Color(0xFF115213),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      items: _buildNavigationItems(),
      onTap: _onNavigationItemTapped,
    );
  }

  /// Elementos de navegación
  List<Widget> _buildNavigationItems() {
    return [
      _buildNavItem(Icons.home_outlined, currentIndex == 0), // Home
      _buildNavItem(Icons.apple_outlined, currentIndex == 1), // Productos
      _buildNavItem(Icons.qr_code_scanner, currentIndex == 2), // Escáner
      _buildNavItem(Icons.person, currentIndex == 3), // Perfil
    ];
  }

  /// Maneja los taps de navegación
  void _onNavigationItemTapped(int index) {
    setState(() => currentIndex = index);
    _executeNavigationCallback(index);
  }

  void _executeNavigationCallback(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OptionPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ListProductView()),
        );
        break;
      case 2:
        widget.onProductsTap?.call();
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileView()),
        );
    }
  }

  /// Estilo del borde del campo de búsqueda
  OutlineInputBorder _buildInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  /// Ícono individual de navegación
  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Icon(
      icon,
      size: 28,
      color: isSelected ? Colors.white : const Color(0xFF115213),
    );
  }
}

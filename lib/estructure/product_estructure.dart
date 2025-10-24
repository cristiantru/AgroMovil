import 'package:agromarket/views/product_admin/list_product_view.dart';
import 'package:agromarket/views/product_admin/register_product_view.dart';
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
    this.currentIndex = 0, // inicializa en home
  });

  @override
  State<ProductEstructureView> createState() => _ProductEstructureViewState();
}

class _ProductEstructureViewState extends State<ProductEstructureView> {
  late int currentIndex;
  Widget? _currentContent;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    _currentContent = widget.content ?? _getContentForIndex(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final currentTitle = _getTitleForIndex(currentIndex);
    
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentTitle != null)
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                child: Text(
                  currentTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF115213),
                  ),
                ),
              ),

            _buildContentArea(),
          ],
        ),
      ),
      bottomNavigationBar: _buildCurvedNavigationBar(),
    );
  }

  Widget _buildContentArea() {
    return Expanded(
      child: _currentContent ?? _buildEmptyContent(),
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
      color: const Color.fromARGB(255, 34, 102, 2),
      buttonBackgroundColor: const Color.fromARGB(255, 34, 102, 2),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      items: _buildNavigationItems(),
      onTap: _onNavigationItemTapped,
    );
  }

  /// Elementos de navegación
  List<Widget> _buildNavigationItems() {
    return [
      _buildNavItem(Icons.home_outlined, currentIndex == 0), 
      _buildNavItem(Icons.add, currentIndex == 1), 
      _buildNavItem(Icons.add, currentIndex == 2), 
      _buildNavItem(Icons.person, currentIndex == 3),
    ];
  }

  /// Maneja los taps de navegación
  void _onNavigationItemTapped(int index) {
    setState(() {
      currentIndex = index;
      _currentContent = _getContentForIndex(index);
    });
  }

  /// Obtiene el contenido correspondiente al índice
  Widget _getContentForIndex(int index) {
    switch (index) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const RegisterProductView();
      case 2:
        return const ListProductView();
      case 3:
        return const ProfileView();
      default:
        return _buildEmptyContent();
    }
  }

  /// Obtiene el título correspondiente al índice
  String? _getTitleForIndex(int index) {
    switch (index) {
      case 0:
        return null; 
      case 1:
        return 'Registro de productos';
      case 2:
        return 'Mis productos';
      case 3:
        return null; 
      default:
        return null;
    }
  }


  /// Contenido para la pestaña Home
  Widget _buildHomeContent() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            size: 80,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          SizedBox(height: 20),
          Text(
            'Bienvenido a AgroMarket',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF115213),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Tu plataforma de productos agrícolas',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }


  /// Ícono individual de navegación
  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Icon(
      icon,
      size: 28,
      color: isSelected ? Colors.white : const Color.fromARGB(255, 255, 255, 255),
    );
  }
}

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

/// Widget principal que proporciona una estructura base para pantallas de productos
/// con barra de búsqueda y navegación inferior curva
class ProductEstructureView extends StatefulWidget {
  // Contenido principal de la pantalla
  final Widget? content;
  
  // Texto de placeholder para la barra de búsqueda
  final String searchHint;
  
  // Callbacks para los botones de navegación
  final VoidCallback? onHomeTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onProductsTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onCartTap;
  
  // Callback para cambios en la búsqueda
  final Function(String)? onSearchChanged;
  
  // Control de visibilidad de la barra de búsqueda
  final bool showSearchBar;
  
  // Índice del botón de navegación activo
  final int currentIndex;

  const ProductEstructureView({
    super.key,
    this.content,
    this.searchHint = "Buscar...",
    this.onHomeTap,
    this.onProfileTap,
    this.onProductsTap,
    this.onSearchTap,
    this.onCartTap,
    this.onSearchChanged,
    this.showSearchBar = true,
    this.currentIndex = 2, // Por defecto, productos está activo
  });

  @override
  State<ProductEstructureView> createState() => _ProductEstructureViewState();
}

class _ProductEstructureViewState extends State<ProductEstructureView> {
  // Índice del botón de navegación actualmente seleccionado
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
          children: [
            _buildSearchBar(),
            _buildContentArea(),
          ],
        ),
      ),
      bottomNavigationBar: _buildCurvedNavigationBar(),
    );
  }

  /// Construye la barra de búsqueda con diseño mejorado
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

  /// Construye el área de contenido principal
  Widget _buildContentArea() {
    return Expanded(
      child: widget.content ?? _buildEmptyContent(),
    );
  }

  /// Construye el contenido vacío cuando no hay contenido personalizado
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

  /// Construye la barra de navegación curva
  Widget _buildCurvedNavigationBar() {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 75, // Valor máximo permitido por el paquete
      backgroundColor: Colors.transparent,
      color: const Color(0xFF8EBF75),
      buttonBackgroundColor: const Color(0xFF115213),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      items: _buildNavigationItems(),
      onTap: _onNavigationItemTapped,
    );
  }

  /// Construye los elementos de la barra de navegación
  List<Widget> _buildNavigationItems() {
    return [
      _buildNavItem(Icons.home_outlined, currentIndex == 0),
      _buildNavItem(Icons.person_outline, currentIndex == 1),
      _buildNavItem(Icons.qr_code_scanner, currentIndex == 2),
      _buildNavItem(Icons.search, currentIndex == 3),
      _buildNavItem(Icons.shopping_bag_outlined, currentIndex == 4),
    ];
  }

  /// Maneja el tap en los elementos de navegación
  void _onNavigationItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    _executeNavigationCallback(index);
  }

  /// Ejecuta el callback correspondiente según el índice seleccionado
  void _executeNavigationCallback(int index) {
    switch (index) {
      case 0:
        widget.onHomeTap?.call();
        break;
      case 1:
        widget.onProfileTap?.call();
        break;
      case 2:
        widget.onProductsTap?.call();
        break;
      case 3:
        widget.onSearchTap?.call();
        break;
      case 4:
        widget.onCartTap?.call();
        break;
    }
  }

  /// Maneja el tap en el botón de filtros
  void _onFilterPressed() {
    // Aquí podrías abrir filtros o limpiar el texto
    // Por ahora no hace nada, pero se puede implementar funcionalidad
  }

  /// Construye el borde del campo de entrada
  OutlineInputBorder _buildInputBorder(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  /// Construye un elemento individual de la barra de navegación
  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Icon(
      icon,
      size: 28,
      color: isSelected ? Colors.white : const Color(0xFF115213),
    );
  }
}

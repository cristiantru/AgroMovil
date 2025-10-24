import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:agromarket/views/productos/agro_market_home.dart';
import 'package:agromarket/views/productos/product_list_view.dart';
import 'package:agromarket/views/productos/product_detail_view.dart';
import 'package:agromarket/views/productos/cart_view.dart';
import 'package:agromarket/views/productos/payment_view.dart';



class AgroMarketEstructureView extends StatefulWidget {
  const AgroMarketEstructureView({super.key});

  @override
  State<AgroMarketEstructureView> createState() =>
      _AgroMarketEstructureViewState();
}

class _AgroMarketEstructureViewState extends State<AgroMarketEstructureView> {
  int currentIndex = 0;
  final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: currentIndex,
        children: [
          Navigator(
            key: _homeNavigatorKey,
            onGenerateRoute: (settings) {
              if (settings.name == '/list') {
                final category = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => ProductListView(category: category),
                );
              } else if (settings.name == '/detail') {
                final product = settings.arguments as Map<String, dynamic>;
                return MaterialPageRoute(
                  builder: (_) => ProductDetailView(product: product),
                );
              } else {
                return MaterialPageRoute(
                  builder: (_) => AgroMarketHome(
                    onCategorySelected: (category) {
                      _homeNavigatorKey.currentState!
                          .pushNamed('/list', arguments: category);
                    },
                  ),
                );
              }
            },
          ),
          CartView(),
          PaymentView(),
        ],
      ),
      bottomNavigationBar: _buildCurvedNavigationBar(),
    );
  }

 Widget _buildCurvedNavigationBar() {
  return CurvedNavigationBar(
    index: currentIndex,
    height: 70,
    backgroundColor: Colors.transparent,
    color: const Color(0xFFA8D5A2), // 💚 Verde más claro
    buttonBackgroundColor: const Color(0xFF115213), // Verde oscuro para el botón activo
    animationCurve: Curves.easeInOut,
    animationDuration: const Duration(milliseconds: 500),
    items: _buildNavigationItems(),
    onTap: (index) {
      setState(() {
        currentIndex = index;
      });
    },
  );
}


  List<Widget> _buildNavigationItems() {
    return [
      _buildNavItem(Icons.category_outlined, 0),
      _buildNavItem(Icons.shopping_cart_outlined, 1),
      _buildNavItem(Icons.payment_outlined, 2),
    ];
  }

  Widget _buildNavItem(IconData icon, int index) {
    return Icon(
      icon,
      size: 28,
      color: currentIndex == index ? Colors.white : const Color(0xFF115213),
    );
  }
}

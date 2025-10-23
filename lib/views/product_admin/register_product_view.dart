import 'package:flutter/material.dart';
import 'package:agromarket/views/product_admin/products_seller_view.dart';

class RegisterProductView extends StatefulWidget {
  const RegisterProductView({super.key});

  @override
  State<RegisterProductView> createState() => _RegisterProductViewState();
}

class _RegisterProductViewState extends State<RegisterProductView> with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/22.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Center(
                      child: Container(
                        width: constraints.maxWidth * 0.95,
                        height: constraints.maxHeight * 0.9,
                        margin: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.025,
                          vertical: constraints.maxHeight * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 25,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.05,
                                vertical: constraints.maxHeight * 0.02,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "REGISTRO DE PRODUCTOS",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF03083A),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                     
                                    ],
                                  ),
                                  SizedBox(height: constraints.maxHeight * 0.01),
                                  const Text(
                                    "Completa la información de tu producto",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2F4157),
                                      height: 1.4,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            
                            // Contenido con scroll
                            Expanded(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(
                                  horizontal: constraints.maxWidth * 0.05,
                                  vertical: constraints.maxHeight * 0.01,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        height: constraints.maxHeight * 0.12,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF5F5F5),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: const Color(0xFF577C8E).withOpacity(0.3),
                                            width: 2,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF4CAF50).withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.add_a_photo,
                                                color: Color(0xFF4CAF50),
                                                size: 25,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              "Toca para subir imagen",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF2F4157),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    
                                    SizedBox(height: constraints.maxHeight * 0.02),
                                    
                                    // Campos del formulario
                                    _buildFormField(
                                      label: "Nombre del producto",
                                      controller: _nameController,
                                      icon: Icons.inventory_2,
                                      constraints: constraints,
                                    ),
                                    
                                    SizedBox(height: constraints.maxHeight * 0.015),
                                    
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _buildFormField(
                                            label: "Precio",
                                            controller: _priceController,
                                            icon: Icons.attach_money,
                                            keyboardType: TextInputType.number,
                                            constraints: constraints,
                                          ),
                                        ),
                                        SizedBox(width: constraints.maxWidth * 0.03),
                                        Expanded(
                                          child: _buildFormField(
                                            label: "Stock",
                                            controller: _stockController,
                                            icon: Icons.inventory,
                                            keyboardType: TextInputType.number,
                                            constraints: constraints,
                                          ),
                                        ),
                                      ],
                                    ),
                                    
                                    SizedBox(height: constraints.maxHeight * 0.015),
                                    
                                    _buildFormField(
                                      label: "Categoría",
                                      controller: _categoryController,
                                      icon: Icons.category,
                                      constraints: constraints,
                                    ),
                                    
                                    SizedBox(height: constraints.maxHeight * 0.015),
                                    
                                    _buildFormField(
                                      label: "Descripción",
                                      controller: _descriptionController,
                                      icon: Icons.description,
                                      maxLines: 3,
                                      constraints: constraints,
                                    ),
                                    
                                    SizedBox(height: constraints.maxHeight * 0.03),
                                    
                                    // Botón de guardar
                                    SizedBox(
                                      width: double.infinity,
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const ProductsView(),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(255, 41, 78, 44),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          elevation: 5,
                                        ),
                                        child: const Text(
                                          "Guardar Producto",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    
                                    SizedBox(height: constraints.maxHeight * 0.02),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Método para crear campos de formulario con estilo consistente
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    required BoxConstraints constraints,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.04,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2F4157),
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.01),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFF577C8E).withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF4CAF50),
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.04,
                vertical: constraints.maxHeight * 0.015,
              ),
              hintText: "Ingresa $label",
              hintStyle: TextStyle(
                color: const Color(0xFF2F4157).withOpacity(0.6),
                fontSize: constraints.maxWidth * 0.035,
              ),
            ),
            style: TextStyle(
              fontSize: constraints.maxWidth * 0.035,
              color: const Color(0xFF2F4157),
            ),
          ),
        ),
      ],
    );
  }
}

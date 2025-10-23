import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agromarket/controllers/auth_controller.dart';
import 'package:agromarket/models/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nombreLocalController = TextEditingController();
  final _direccionController = TextEditingController();
  bool _obscureText = true;
  bool _obscureRepeatText = true;
  UserRole _selectedRole = UserRole.comprador;

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nombreLocalController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    
    // Validaciones básicas
    if (_nombreController.text.isEmpty) {
      _showErrorDialog('Por favor, ingresa tu nombre');
      return;
    }
    
    if (_emailController.text.isEmpty) {
      _showErrorDialog('Por favor, ingresa tu email');
      return;
    }
    
    if (_passwordController.text.isEmpty) {
      _showErrorDialog('Por favor, ingresa una contraseña');
      return;
    }
    
    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog('Las contraseñas no coinciden');
      return;
    }
    
    if (_passwordController.text.length < 6) {
      _showErrorDialog('La contraseña debe tener al menos 6 caracteres');
      return;
    }

    // Validaciones específicas por rol
    if (_selectedRole == UserRole.vendedor || _selectedRole == UserRole.ambos) {
      if (_nombreLocalController.text.isEmpty) {
        _showErrorDialog('Por favor, ingresa el nombre de tu local o empresa');
        return;
      }
      
      if (_direccionController.text.isEmpty) {
        _showErrorDialog('Por favor, ingresa la dirección de tu local');
        return;
      }
    }

    final success = await authController.registerWithRole(
      _nombreController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
      _selectedRole,
      _nombreLocalController.text.trim().isNotEmpty ? _nombreLocalController.text.trim() : null,
      _direccionController.text.trim().isNotEmpty ? _direccionController.text.trim() : null,
    );

    if (success && mounted) {
      _showSuccessDialog();
    } else if (mounted) {
      _showErrorDialog(authController.errorMessage ?? 'Error al registrarse');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registro Exitoso'),
        content: const Text('Tu cuenta ha sido creada exitosamente. Ya puedes iniciar sesión.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Fondo de hojas solo en la parte superior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.50,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/fondo.JPG'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Curva blanca decorativa
          Positioned(
            top: MediaQuery.of(context).size.height * 0.60,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 100),
              painter: SmoothWavePainter(),
            ),
          ),

          // Botón de regreso
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFDDF2DD),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 20,
                ),
              ),
            ),
          ),

          // Área blanca con contenido
          Positioned(
            top: MediaQuery.of(context).size.height * 0.30,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1B5E20),
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Crear cuenta',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1B5E20),
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        Container(
                          width: 35,
                          height: 25,
                          child: const Icon(
                            Icons.eco,
                            color: Color(0xFF2E7D32),
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    const Text(
                      'Regístrate para comenzar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Campo de nombre
                    _buildInputField(
                      controller: _nombreController,
                      hintText: 'Nombre completo',
                      icon: Icons.person,
                      keyboardType: TextInputType.text,
                    ),

                    const SizedBox(height: 20),
                    
                    // Campo de email
                    _buildInputField(
                      controller: _emailController,
                      hintText: 'Correo electrónico',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Campo de contraseña
                    _buildPasswordField(
                      controller: _passwordController,
                      hintText: 'Contraseña',
                      icon: Icons.lock,
                      obscureText: _obscureText,
                      onToggle: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Campo de confirmar contraseña
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirmar contraseña',
                      icon: Icons.lock_outline,
                      obscureText: _obscureRepeatText,
                      onToggle: () {
                        setState(() {
                          _obscureRepeatText = !_obscureRepeatText;
                        });
                      },
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Selección de rol
                    _buildRoleSelector(),
                    
                    const SizedBox(height: 20),
                    
                    // Campos condicionales para vendedores
                    if (_selectedRole == UserRole.vendedor || _selectedRole == UserRole.ambos) ...[
                      _buildInputField(
                        controller: _nombreLocalController,
                        hintText: 'Nombre del local o empresa',
                        icon: Icons.store,
                        keyboardType: TextInputType.text,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      _buildInputField(
                        controller: _direccionController,
                        hintText: 'Dirección del local',
                        icon: Icons.location_on,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                    
                    const SizedBox(height: 10),
                    
                    // Botón de registro
                    Consumer<AuthController>(
                      builder: (context, authController, child) {
                        return GestureDetector(
                          onTap: authController.isLoading ? null : _register,
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: authController.isLoading
                                  ? Colors.grey
                                  : const Color(0xFF2E7D32),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: authController.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Registrarse',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Enlace de login
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            children: [
                              TextSpan(text: "¿Ya tienes cuenta? "),
                              TextSpan(
                                text: 'Iniciar sesión',
                                style: TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[600],
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipo de cuenta',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B5E20),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildRoleOption(
                role: UserRole.comprador,
                title: 'Comprador',
                icon: Icons.shopping_cart,
                description: 'Solo comprar',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildRoleOption(
                role: UserRole.vendedor,
                title: 'Vendedor',
                icon: Icons.store,
                description: 'Solo vender',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildRoleOption(
                role: UserRole.ambos,
                title: 'Ambos',
                icon: Icons.business,
                description: 'Comprar y vender',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleOption({
    required UserRole role,
    required String title,
    required IconData icon,
    required String description,
  }) {
    final isSelected = _selectedRole == role;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E8) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF2E7D32) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF2E7D32) : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF2E7D32) : Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? const Color(0xFF2E7D32) : Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SmoothWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    
    // Crear una curva suave
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.4,
      size.width * 0.5, size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.8,
      size.width, size.height * 0.5,
    );
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
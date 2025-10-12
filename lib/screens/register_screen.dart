import 'package:flutter/material.dart';
import 'interes_screen.dart';
import 'cliente_home.dart';
import 'admin_home.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado verde curvado
            ClipPath(
              clipper: CurvedHeaderClipper(),
              child: Container(
                height: 200,
                color: const Color(0xFFA8E6A1),
                child: const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      '🥕🍅🍓',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Título principal
            const Text(
              'Registro de usuario',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            // Campo: Nombre completo
            _buildTextField('Nombre completo'),

            const SizedBox(height: 20),

            // Campo: Correo electrónico
            _buildTextField('Correo electrónico'),

            const SizedBox(height: 20),

            // Campo: Contraseña
            _buildTextField('Contraseña', obscure: true),

            const SizedBox(height: 20),

            // Dropdown Rol
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Rol'),
                    value: selectedRole,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'Cliente', child: Text('Cliente')),
                      DropdownMenuItem(value: 'Vendedor', child: Text('Vendedor')),
                      DropdownMenuItem(value: 'Administrador', child: Text('Administrador')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Enlace para ir al login
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Ya tengo una cuenta',
                style: TextStyle(color: Colors.black54),
              ),
            ),

            const SizedBox(height: 10),

            // Botón de registro
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedRole == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor selecciona un rol.'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }

                  // 🔹 Redirección según el rol seleccionado
                  Widget nextScreen;

                  switch (selectedRole) {
                    case 'Vendedor':
                      nextScreen = const InteresScreen();
                      break;
                    case 'Cliente':
                      nextScreen = const ClienteHome();
                      break;
                    case 'Administrador':
                      nextScreen = const AdminHome();
                      break;
                    default:
                      nextScreen = const InteresScreen();
                  }

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => nextScreen),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA8E6A1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Registrarme',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 🔹 Reutilizamos este método para no repetir código en los TextField
  Widget _buildTextField(String label, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

// Clipper para la forma curva verde superior
class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

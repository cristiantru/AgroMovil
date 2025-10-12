import 'package:flutter/material.dart';
import 'register_screen.dart'; // ✅ Importa la pantalla de registro

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado curvado verde con íconos o dibujos
            ClipPath(
              clipper: CurvedHeaderClipper(),
              child: Container(
                height: 200,
                color: const Color(0xFFA8E6A1), // verde claro
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
              'Bienvenido',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            // Campo: Correo electrónico
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Campo: Contraseña
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Olvidaste tu contraseña
            TextButton(
              onPressed: () {},
              child: const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.black54),
              ),
            ),

            const SizedBox(height: 20),

            // Botón de iniciar sesión
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA8E6A1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Enlace para ir al registro
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text(
                '¿No tienes una cuenta? Regístrate',
                style: TextStyle(color: Colors.black54),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// Clipper para hacer la forma curva verde superior
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

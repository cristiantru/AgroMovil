import 'package:flutter/material.dart';
import 'package:agromarket/views/auth/login_view.dart'; // ← este import no es necesario si el archivo se llama diferente
import 'splash_screen.dart';
import 'package:agromarket/views/auth/login_view.dart' show LoginPage; // 👈 Asegúrate de que este import apunte a donde está LoginPage

void main() {
  runApp(const AgroMarketApp());
}

class AgroMarketApp extends StatelessWidget {
  const AgroMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgroMarket',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
      routes: {
        '/inicio': (context) => const LoginPage(), // 👈 Aquí está el cambio
      },
    );
  }
}

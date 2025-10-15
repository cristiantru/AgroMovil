import 'package:flutter/material.dart';
import 'splash_screen.dart'; // 👈 importa tu splash

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
      home: const SplashScreen(), // 👈 aquí inicia el splash
      routes: {
        '/inicio': (context) => const InicioTemporal(), // 👈 ruta a tu pantalla principal
      },
    );
  }
}

class InicioTemporal extends StatelessWidget {
  const InicioTemporal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AgroMarket'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Bienvenido a AgroMarket 🌿',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

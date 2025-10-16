import 'package:agromarket/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:agromarket/views/auth/login_view.dart';
import 'package:agromarket/views/home/home_page.dart';
import 'package:agromarket/views/auth/optiones_view.dart';

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
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/options': (context) => const OptionPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

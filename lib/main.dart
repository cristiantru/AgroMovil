import 'package:agromarket/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agromarket/views/auth/login_view.dart';
import 'package:agromarket/views/auth/optiones_view.dart';
import 'package:agromarket/controllers/auth_controller.dart';
import 'splash_screen.dart';

void main() {
  runApp(const AgroMarketApp());
}

class AgroMarketApp extends StatelessWidget {
  const AgroMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AgroMarket',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const OptionPage(),
        },
      ),
<<<<<<< HEAD
=======
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/options': (context) => const OptionPage(),
        '/home': (context) => const HomePage(),
      },
>>>>>>> bf9ec73 (Se realizo el apartado sobre nosotros)
    );
  }
}

import 'package:agromarket/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:agromarket/views/auth/login_view.dart';
import 'package:agromarket/views/auth/optiones_view.dart';
import 'package:agromarket/controllers/auth_controller.dart';
import 'package:agromarket/firebase_options.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Firebase con opciones por defecto
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
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
        home: SplashScreen(), // Sin const
        routes: {
          '/login': (context) => LoginPage(), // Sin const
          '/home': (context) => OptionPage(), // Sin const
        },
      ),
    );
  }
}

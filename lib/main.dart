import 'package:agromarket/views/auth/login_view.dart';
import 'package:flutter/material.dart';

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
      home: const LoginPage(),
    );
  }
}



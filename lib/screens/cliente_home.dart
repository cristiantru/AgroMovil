import 'package:flutter/material.dart';

class ClienteHome extends StatelessWidget {
  const ClienteHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFA8E6A1),
        title: const Text('Inicio - Cliente'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Bienvenido, Cliente 👋',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

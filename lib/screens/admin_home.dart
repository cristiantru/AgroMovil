import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFA8E6A1),
        title: const Text('Panel del Administrador'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Bienvenido, Administrador ⚙️',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

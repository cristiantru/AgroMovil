import 'package:flutter/material.dart';
import 'cart.dart';

class PayPalForm extends StatefulWidget {
  const PayPalForm({super.key});

  @override
  State<PayPalForm> createState() => _PayPalFormState();
}

class _PayPalFormState extends State<PayPalForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final total = Cart.getTotal();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Pago con PayPal"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(
                Icons.account_balance_wallet,
                size: 70,
                color: Color.fromARGB(255, 22, 123, 25),
              ),
              const SizedBox(height: 10),
              const Text(
                "Inicia sesión en tu cuenta PayPal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: emailController,
                label: "Correo electrónico",
                icon: Icons.email,
                validator: (v) =>
                    v!.isEmpty ? "Ingrese su correo electrónico" : null,
              ),
              _buildTextField(
                controller: passwordController,
                label: "Contraseña",
                icon: Icons.lock,
                obscureText: true,
                validator: (v) =>
                    v!.isEmpty ? "Ingrese su contraseña" : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Cart.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Pago de \$$total realizado con PayPal"),
                      ),
                    );
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF115213),
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 40), // Más grande
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 6,
                ),
                child: const Text(
                  "Confirmar pago",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF115213)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

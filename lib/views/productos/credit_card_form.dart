import 'package:flutter/material.dart';
import 'cart.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final total = Cart.getTotal();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Pago con Tarjeta"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: nameController,
                label: "Nombre del titular",
                icon: Icons.person,
                validator: (v) =>
                    v!.isEmpty ? "Ingrese el nombre del titular" : null,
              ),
              _buildTextField(
                controller: cardNumberController,
                label: "Número de tarjeta",
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v!.length < 16 ? "Número de tarjeta inválido" : null,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: expiryController,
                      label: "Expiración (MM/AA)",
                      icon: Icons.date_range,
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      controller: cvvController,
                      label: "CVV",
                      icon: Icons.lock,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Cart.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Pago de \$$total realizado con tarjeta"),
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
                  elevation: 6, // Sombra un poco mayor
                ),
                child: const Text(
                  "Confirmar pago",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white, // Letra blanca
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
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
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

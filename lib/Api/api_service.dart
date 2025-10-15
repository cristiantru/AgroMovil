import 'dart:convert';
import 'package:http/http.dart' as http;

/// 🌾 Servicio API para conectar Flutter con Flask (AgroMarket)
/// Asegúrate de tener tu servidor Flask corriendo (ej: http://10.0.2.2:5000)
class ApiService {
  // 📍 Cambia esta URL por la de tu backend Flask (si usas un servidor o IP local)
  static const String baseUrl = 'http://10.0.2.2:5000';

  /// ✅ OBTENER todos los productos
  static Future<List<dynamic>> getProductos() async {
    final url = Uri.parse('$baseUrl/productos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener los productos');
    }
  }

  /// 🆕 AGREGAR un nuevo producto
  static Future<bool> agregarProducto(Map<String, dynamic> producto) async {
    final url = Uri.parse('$baseUrl/productos');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(producto),
    );

    return response.statusCode == 201;
  }

  /// ✏️ EDITAR un producto existente
  static Future<bool> editarProducto(int id, Map<String, dynamic> producto) async {
    final url = Uri.parse('$baseUrl/productos/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(producto),
    );

    return response.statusCode == 200;
  }

  /// 🗑️ ELIMINAR un producto
  static Future<bool> eliminarProducto(int id) async {
    final url = Uri.parse('$baseUrl/productos/$id');
    final response = await http.delete(url);

    return response.statusCode == 200;
  }
}

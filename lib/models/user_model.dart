enum UserRole {
  comprador,
  vendedor,
  ambos,
}

class UserModel {
  final String id; // Cambiado de int a String para Firebase UID
  final String nombre;
  final String email;
  final UserRole role;
  final String? nombreLocal; // Solo para vendedores
  final String? direccion; // Solo para vendedores
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.nombre,
    required this.email,
    required this.role,
    this.nombreLocal,
    this.direccion,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      email: json['email'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString() == 'UserRole.${json['role']}',
        orElse: () => UserRole.comprador,
      ),
      nombreLocal: json['nombre_local'],
      direccion: json['direccion'],
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'role': role.toString().split('.').last,
      if (nombreLocal != null) 'nombre_local': nombreLocal,
      if (direccion != null) 'direccion': direccion,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, nombre: $nombre, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}

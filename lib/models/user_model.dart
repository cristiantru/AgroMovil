class UserModel {
  final int id;
  final String nombre;
  final String email;
  final String? password; 

  UserModel({
    required this.id,
    required this.nombre,
    required this.email,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      nombre: json['name'] ?? json['nombre'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      if (password != null) 'password': password,
    };
  }

  factory UserModel.create({
    required String nombre,
    required String email,
    required String password,
  }) {
    return UserModel(
      id: 0, 
      nombre: nombre,
      email: email,
      password: password,
    );
  }

  UserModel copyWith({
    int? id,
    String? nombre,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, nombre: $nombre, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}

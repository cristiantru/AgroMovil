import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Registrar nuevo usuario con email y contraseña
  static Future<Map<String, dynamic>> registerWithEmail({
    required String nombre,
    required String email,
    required String password,
  }) async {
    try {
      print('Registrando usuario: $email');
      
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Guardar datos en Firestore
        await _firestore.collection('usuarios').doc(userCredential.user!.uid).set({
          'nombre': nombre,
          'email': email,
          'created_at': FieldValue.serverTimestamp(),
          'updated_at': FieldValue.serverTimestamp(),
        });

        print('Usuario registrado exitosamente');
        return {
          'success': true,
          'message': 'Usuario registrado exitosamente',
          'user': {
            'id': userCredential.user!.uid,
            'nombre': nombre,
            'email': email,
          }
        };
      } else {
        return {
          'success': false,
          'message': 'Error creando usuario',
        };
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'La contraseña es muy débil';
          break;
        case 'email-already-in-use':
          message = 'El email ya está registrado';
          break;
        case 'invalid-email':
          message = 'El email no es válido';
          break;
        default:
          message = 'Error de autenticación: ${e.message}';
      }
      
      print('Error en registro: $message');
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      print('Error inesperado en registro: $e');
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
      };
    }
  }

  /// Iniciar sesión con email y contraseña
  static Future<Map<String, dynamic>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      print('Iniciando sesión: $email');
      
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Obtener datos del usuario desde Firestore
        final userDoc = await _firestore
            .collection('usuarios')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          final userData = userDoc.data()!;
          print('Login exitoso');
          return {
            'success': true,
            'message': 'Login exitoso',
            'user': {
              'id': userCredential.user!.uid,
              'nombre': userData['nombre'],
              'email': userData['email'],
            }
          };
        } else {
          return {
            'success': false,
            'message': 'Datos de usuario no encontrados',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Error en el login',
        };
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'Usuario no encontrado';
          break;
        case 'wrong-password':
          message = 'Contraseña incorrecta';
          break;
        case 'invalid-email':
          message = 'Email no válido';
          break;
        case 'user-disabled':
          message = 'Usuario deshabilitado';
          break;
        default:
          message = 'Error de autenticación: ${e.message}';
      }
      
      print('Error en login: $message');
      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      print('Error inesperado en login: $e');
      return {
        'success': false,
        'message': 'Error inesperado: ${e.toString()}',
      };
    }
  }

  /// Cerrar sesión
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('Sesión cerrada');
    } catch (e) {
      print('Error cerrando sesión: $e');
    }
  }

  /// Obtener usuario actual
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Verificar si hay un usuario autenticado
  static bool isUserSignedIn() {
    return _auth.currentUser != null;
  }

  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Obtener datos del usuario actual
  static Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final userDoc = await _firestore
          .collection('usuarios')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        return {
          'id': user.uid,
          'nombre': data['nombre'],
          'email': data['email'],
          'created_at': data['created_at'],
          'updated_at': data['updated_at'],
        };
      }
      return null;
    } catch (e) {
      print('Error obteniendo datos del usuario: $e');
      return null;
    }
  }

  /// Actualizar datos del usuario
  static Future<bool> updateUserData(Map<String, dynamic> data) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      data.remove('id');
      data.remove('created_at');
      data['updated_at'] = FieldValue.serverTimestamp();

      await _firestore
          .collection('usuarios')
          .doc(user.uid)
          .update(data);

      print('Datos del usuario actualizados');
      return true;
    } catch (e) {
      print('Error actualizando datos del usuario: $e');
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final querySnapshot = await _firestore
          .collection('usuarios')
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'nombre': data['nombre'],
          'email': data['email'],
          'created_at': data['created_at'],
          'updated_at': data['updated_at'],
        };
      }).toList();
    } catch (e) {
      print('Error obteniendo usuarios: $e');
      return [];
    }
  }


  // Verificar conexión a Firebase
  static Future<bool> testConnection() async {
    try {
      await _firestore.collection('test').limit(1).get();
      print('Conexión a Firebase exitosa');
      return true;
    } catch (e) {
      print('Error conectando a Firebase: $e');
      return false;
    }
  }
}
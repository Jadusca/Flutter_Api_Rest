import 'dart:async'; // Importa la librería dart:async para trabajar con operaciones asíncronas
import 'dart:convert'; // Importa la librería dart:convert para codificar y decodificar objetos JSON

import 'package:flutter_api_rest/api/authentication_api.dart'; // Importa la clase AuthenticationApi
import 'package:flutter_api_rest/models/authentication_response.dart'; // Importa la clase AuthenticationResponse
import 'package:flutter_api_rest/models/session.dart'; // Importa la clase Session
import 'package:flutter_api_rest/utils/logs.dart'; // Importa la clase Logs para registrar logs
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Importa la librería FlutterSecureStorage para almacenar datos de forma segura

class AuthenticationClient { // Define la clase AuthenticationClient para gestionar la autenticación del cliente
  final FlutterSecureStorage _secureStorage; // Almacena el objeto FlutterSecureStorage para el almacenamiento seguro de datos
  final AuthenticationApi _authenticationApi; // Almacena la instancia de AuthenticationApi para realizar operaciones de autenticación

  Completer? _completer; // Define un completer para controlar las operaciones asíncronas

  AuthenticationClient(this._secureStorage, this._authenticationApi); // Constructor de la clase AuthenticationClient que recibe FlutterSecureStorage y AuthenticationApi

  void complete() { // Método para completar el completer y señalizar que la operación asíncrona ha finalizado
    if (_completer != null && !_completer!.isCompleted) { // Verifica si el completer existe y no está completado
      _completer!.complete();
    }
  }

  Future<String?> get accessToken async { // Método para obtener el token de acceso
    if (_completer != null) { // Verifica si hay una operación en curso
      await _completer!.future; // Espera a que la operación actual se complete
    }

    Logs.p.i('Llamada ${DateTime.now()}'); // Registra un mensaje de log

    _completer = Completer(); // Inicializa el completer para una nueva operación

    final data = await _secureStorage.read(key: 'SESSION'); // Lee los datos de la sesión desde el almacenamiento seguro
    if (data != null) { // Verifica si se recuperaron datos de la sesión
      final session = Session.fromJson(jsonDecode(data)); // Convierte los datos JSON en un objeto Session
      final DateTime currentDate = DateTime.now(); // Obtiene la fecha y hora actuales
      final DateTime createdAt = session.createAt; // Obtiene la fecha de creación de la sesión
      final int expiresIn = session.expiresIn; // Obtiene el tiempo de expiración del token
      final int diff = currentDate.difference(createdAt).inSeconds; // Calcula la diferencia de tiempo entre la fecha actual y la fecha de creación de la sesión
      Logs.p.i('session life time ${expiresIn - diff}'); // Registra un mensaje de log con el tiempo restante de vida de la sesión
      if ((expiresIn - diff) >= 60) { // Verifica si el token aún no ha expirado.
        complete(); // Completa la operación
        return session.token; // Retorna el token de la sesión
      }
      final response = await _authenticationApi.refreshToken(session.token); // Intenta renovar el token de acceso
      if (response.data != null) { // Verifica si se obtuvo una respuesta válida
        await saveSession(response.data!); // Guarda la nueva sesión en el almacenamiento seguro
        complete(); // Completa la operación
        return response.data!.token; // Retorna el nuevo token de acceso
      }
      complete(); // Completa la operación
      return null; // Retorna nulo en caso de que no se pueda renovar el token
    }
    complete(); // Completa la operación
    return null; // Retorna nulo si no se encontraron datos de sesión en el almacenamiento
  }

  Future<void> saveSession(AuthenticationResponse authenticationResponse) async { // Método para guardar la sesión en el almacenamiento seguro
    final Session session = Session( // Crea una nueva instancia de Session
      token: authenticationResponse.token, // Asigna el token de autenticación
      expiresIn: authenticationResponse.expiresIn, // Asigna el tiempo de expiración del token
      createAt: DateTime.now(), // Asigna la fecha y hora actual como la fecha de creación de la sesión
    );
    final data = jsonEncode(session.toJson()); // Convierte la sesión en un formato JSON
    await _secureStorage.write( // Escribe los datos de la sesión en el almacenamiento seguro
      key: 'SESSION', // Define la clave para identificar la sesión
      value: data, // Asigna los datos de la sesión
    );
  }

  Future<void> signOut() async { // Método para cerrar sesión
    await _secureStorage.deleteAll(); // Elimina todos los datos del almacenamiento seguro al cerrar sesión
  }

}

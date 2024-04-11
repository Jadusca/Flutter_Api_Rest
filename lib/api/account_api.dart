import 'dart:typed_data'; // Importa la biblioteca dart:typed_data para trabajar con datos binarios
import 'package:dio/dio.dart'; // Importa la biblioteca dio para realizar solicitudes HTTP
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importa la clase AuthenticationClient para gestionar la autenticación del usuario
import 'package:flutter_api_rest/helpers/http.dart'; // Importa la clase Http para realizar solicitudes HTTP
import 'package:flutter_api_rest/helpers/http_response.dart'; // Importa la clase HttpResponse para representar la respuesta de una solicitud HTTP
import 'package:flutter_api_rest/models/User.dart'; // Importa el modelo User para representar la información del usuario

class AccountApi { // Define la clase AccountApi para realizar operaciones relacionadas con la cuenta del usuario

  final Http _http; // Almacena una instancia de la clase Http para realizar solicitudes HTTP
  final AuthenticationClient _authenticationClient; // Almacena una instancia de la clase AuthenticationClient para gestionar la autenticación del usuario

  AccountApi(this._http, this._authenticationClient); // Constructor que recibe una instancia de Http y AuthenticationClient

  Future<HttpResponse<User>> getUserInfo() async { // Método para obtener la información del usuario
    final token = await _authenticationClient.accessToken; // Obtiene el token de acceso del usuario autenticado
    return _http.request<User>( // Realiza una solicitud HTTP de tipo GET para obtener la información del usuario
      '/user-info', // Ruta para obtener la información del usuario en el servidor
      method: 'GET', // Método HTTP GET
      headers: {
        'token' : token // Encabezado HTTP que contiene el token de acceso del usuario
      },
      parser: (data) { // Función para analizar y convertir la respuesta de la solicitud HTTP
        return User.fromJson(data); // Convierte los datos de la respuesta en un objeto User
      }
    );
  }

  Future<HttpResponse<String>> updateAvatar(Uint8List bytes, String filename) async { // Método para actualizar el avatar del usuario
    final token = await _authenticationClient.accessToken; // Obtiene el token de acceso del usuario autenticado
    return _http.request<String>( // Realiza una solicitud HTTP de tipo POST para actualizar el avatar del usuario
        '/update-avatar', // Ruta para actualizar el avatar del usuario en el servidor
        method: 'POST', // Método HTTP POST
        headers: {
          'token' : token // Encabezado HTTP que contiene el token de acceso del usuario
        },
      formData: {
        'attachment' : MultipartFile.fromBytes(bytes, filename: filename), // Adjunta el archivo de imagen (avatar) en la solicitud
      },
    );
  }

}

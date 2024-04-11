import 'package:flutter_api_rest/models/user_credential_model.dart'; // Importa el modelo UserCredentialModel
import 'package:flutter_api_rest/models/user_register_model.dart'; // Importa el modelo UserRegisterModel
import 'package:flutter_api_rest/helpers/http.dart'; // Importa la clase Http para realizar solicitudes HTTP
import 'package:flutter_api_rest/helpers/http_response.dart'; // Importa la clase HttpResponse para representar la respuesta de una solicitud HTTP
import 'package:flutter_api_rest/models/authentication_response.dart'; // Importa el modelo AuthenticationResponse

class AuthenticationApi { // Define la clase AuthenticationApi para realizar operaciones de autenticación

  final Http _http; // Almacena una instancia de la clase Http para realizar solicitudes HTTP

  AuthenticationApi(this._http); // Constructor que recibe una instancia de la clase Http

  Future<HttpResponse<AuthenticationResponse>> register({ // Método para registrar un nuevo usuario
    required UserRegisterModel userRegister, // Parámetro que contiene los datos del usuario a registrar
  }) {
    return _http.request<AuthenticationResponse>( // Realiza una solicitud HTTP de tipo POST para registrar un usuario
      '/register', // Ruta para el registro de usuario en el servidor
      method: 'POST', // Método HTTP POST
      data: {
        "username": userRegister.username, // Datos del usuario: nombre de usuario
        "email": userRegister.email, // Datos del usuario: correo electrónico
        "password": userRegister.password, // Datos del usuario: contraseña
      },
      parser: (data) { // Función para analizar y convertir la respuesta de la solicitud HTTP
        return AuthenticationResponse.fromJson(data); // Convierte los datos de la respuesta en un objeto AuthenticationResponse
      },
    );
  }

  Future<HttpResponse<AuthenticationResponse>> login({ // Método para iniciar sesión de usuario
    required UserCredentialModel userCredential, // Parámetro que contiene las credenciales del usuario para iniciar sesión
  }) async {
    return _http.request<AuthenticationResponse>( // Realiza una solicitud HTTP de tipo POST para iniciar sesión
      '/login', // Ruta para iniciar sesión en el servidor
      method: 'POST', // Método HTTP POST
      data: {
        "email": userCredential.email, // Datos del usuario: correo electrónico
        "password": userCredential.password, // Datos del usuario: contraseña
      },
      parser: (data) { // Función para analizar y convertir la respuesta de la solicitud HTTP
        return AuthenticationResponse.fromJson(data); // Convierte los datos de la respuesta en un objeto AuthenticationResponse
      },
    );
  }

  Future<HttpResponse<AuthenticationResponse>> refreshToken(String expiredToken) { // Método para refrescar el token de acceso
    return _http.request<AuthenticationResponse>( // Realiza una solicitud HTTP de tipo POST para refrescar el token
      '/refresh-token', // Ruta para refrescar el token en el servidor
      method: 'POST', // Método HTTP POST
      headers: {
        'token': expiredToken, // Encabezado HTTP que contiene el token expirado
      },
      parser: (data) { // Función para analizar y convertir la respuesta de la solicitud HTTP
        return AuthenticationResponse.fromJson(data); // Convierte los datos de la respuesta en un objeto AuthenticationResponse
      },
    );
  }

}
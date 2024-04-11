class AuthenticationResponse { // Define una clase AuthenticationResponse que representa la respuesta de autenticación

  final String token; // Token de acceso obtenido en la respuesta de autenticación
  final int expiresIn; // Tiempo de expiración del token en segundos

  AuthenticationResponse({ // Constructor de la clase AuthenticationResponse que recibe los datos de la respuesta de autenticación
    required this.token, // Token de acceso requerido en la respuesta de autenticación
    required this.expiresIn, // Tiempo de expiración requerido en la respuesta de autenticación
  });

  static AuthenticationResponse fromJson(Map<String, dynamic> json) { // Método estático para crear un objeto AuthenticationResponse a partir de un mapa JSON
    return AuthenticationResponse( // Retorna un nuevo objeto AuthenticationResponse con los datos del JSON
        token: json['token'], // Obtiene el token de acceso del JSON
        expiresIn: json['expiresIn'], // Obtiene el tiempo de expiración del JSON
    );
  }

}

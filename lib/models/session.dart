class Session { // Define una clase Session que representa una sesión de usuario

  final String token; // Token de acceso de la sesión
  final int expiresIn; // Tiempo de expiración del token en segundos
  final DateTime createAt; // Fecha y hora de creación de la sesión

  Session({ // Constructor de la clase Session que recibe los datos de la sesión
    required this.token, // Token de acceso requerido para la sesión
    required this.expiresIn, // Tiempo de expiración requerido para la sesión
    required this.createAt, // Fecha y hora de creación requerida para la sesión
  });

  static Session fromJson(Map<String, dynamic> json) { // Método estático para crear un objeto Session a partir de un mapa JSON
    return Session( // Retorna un nuevo objeto Session con los datos del JSON
      token: json['token'], // Obtiene el token de acceso del JSON
      expiresIn: json['expiresIn'], // Obtiene el tiempo de expiración del JSON
      createAt: DateTime.parse(json['createAt'],) // Convierte y asigna la fecha de creación del JSON
    );
  }

  Map<String, dynamic> toJson() { // Método para convertir un objeto Session a un mapa JSON
    return { // Retorna un mapa JSON con los datos de la sesión
      'token' : token, // Agrega el token de acceso al JSON
      'expiresIn' : expiresIn, // Agrega el tiempo de expiración al JSON
      'createAt' : createAt.toIso8601String(), // Convierte y agrega la fecha de creación al JSON
    };
  }
}

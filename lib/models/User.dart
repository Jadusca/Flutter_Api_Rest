class User { // Define una clase User que representa los datos de un usuario

  final String id; // Identificador único del usuario
  final String username; // Nombre de usuario del usuario
  final String email; // Correo electrónico del usuario
  final DateTime createdAt; // Fecha y hora de creación del usuario
  final DateTime updatedAt; // Fecha y hora de última actualización del usuario
  final String avatar; // URL del avatar del usuario

  User({ // Constructor de la clase User que recibe todos los campos requeridos
    required this.id, // Define el identificador único del usuario
    required this.username, // Define el nombre de usuario del usuario
    required this.email, // Define el correo electrónico del usuario
    required this.createdAt, // Define la fecha y hora de creación del usuario
    required this.updatedAt, // Define la fecha y hora de última actualización del usuario
    required this.avatar, // Define la URL del avatar del usuario
  });

  factory User.fromJson(Map<String, dynamic> json) => User( // Constructor de fábrica para crear un objeto User a partir de un mapa JSON
    id: json["_id"], // Asigna el identificador único del usuario desde el JSON
    username: json["username"], // Asigna el nombre de usuario del usuario desde el JSON
    email: json["email"], // Asigna el correo electrónico del usuario desde el JSON
    createdAt: DateTime.parse(json["createdAt"]), // Convierte y asigna la fecha de creación del usuario desde el JSON
    updatedAt: DateTime.parse(json["updatedAt"]), // Convierte y asigna la fecha de última actualización del usuario desde el JSON
    avatar: json['avatar'] // Asigna la URL del avatar del usuario desde el JSON
  );

  Map<String, dynamic> toJson() => { // Método para convertir un objeto User a un mapa JSON.
    "_id": id, // Agrega el identificador único del usuario al JSON
    "username": username, // Agrega el nombre de usuario del usuario al JSON
    "email": email, // Agrega el correo electrónico del usuario al JSON
    "createdAt": createdAt.toIso8601String(), // Convierte y agrega la fecha de creación del usuario al JSON
    "updatedAt": updatedAt.toIso8601String(), // Convierte y agrega la fecha de última actualización del usuario al JSON
    'avatar' : avatar, // Agrega la URL del avatar del usuario al JSON
  };

  User copyWith({ // Método para crear una copia del usuario con campos opcionales actualizados
    String? id, // Nuevo identificador único del usuario
    String? username, // Nuevo nombre de usuario del usuario
    String? email, // Nuevo correo electrónico del usuario
    DateTime? createdAt, // Nueva fecha de creación del usuario
    DateTime? updatedAt, // Nueva fecha de última actualización del usuario
    String? avatar, // Nueva URL del avatar del usuario
  }) =>
      User( // Retorna un nuevo objeto User con los campos actualizados o los mismos si no se proporcionan valores
        id: id ?? this.id, // Asigna el nuevo identificador único o mantiene el existente si no se proporciona
        username: username ?? this.username, // Asigna el nuevo nombre de usuario o mantiene el existente si no se proporciona
        email: email ?? this.email, // Asigna el nuevo correo electrónico o mantiene el existente si no se proporciona
        createdAt: createdAt ?? this.createdAt, // Asigna la nueva fecha de creación o mantiene la existente si no se proporciona
        updatedAt: updatedAt ?? this.updatedAt, // Asigna la nueva fecha de última actualización o mantiene la existente si no se proporciona
        avatar: avatar ?? this.avatar // Asigna la nueva URL del avatar o mantiene la existente si no se proporciona
      );
}

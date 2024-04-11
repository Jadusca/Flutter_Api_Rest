class UserCredentialModel { // Define una clase UserCredentialModel que representa las credenciales de usuario

  final String _email; // Correo electrónico del usuario
  final String _password; // Contraseña del usuario

  UserCredentialModel({ // Constructor de la clase UserCredentialModel que recibe las credenciales del usuario
    required String email, // Correo electrónico requerido para las credenciales
    required String password // Contraseña requerida para las credenciales
  }) : _password = password, // Asigna el valor de la contraseña
       _email = email; // Asigna el valor del correo electrónico

  String get email => _email; // Método getter para obtener el correo electrónico
  String get password => _password; // Método getter para obtener la contraseña

}

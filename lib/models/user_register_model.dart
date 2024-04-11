class UserRegisterModel { // Define una clase UserRegisterModel que representa los datos de registro de usuario

  final String _username; // Nombre de usuario del usuario
  final String _email; // Correo electrónico del usuario
  final String _password; // Contraseña del usuario

  UserRegisterModel({ // Constructor de la clase UserRegisterModel que recibe los datos de registro del usuario
    required String username, // Nombre de usuario requerido para el registro
    required String email, // Correo electrónico requerido para el registro
    required String password // Contraseña requerida para el registro
  }) : _password = password, // Asigna el valor de la contraseña
       _email = email, // Asigna el valor del correo electrónico
       _username = username; // Asigna el valor del nombre de usuario

  String get username => _username; // Método getter para obtener el nombre de usuario
  String get email => _email; // Método getter para obtener el correo electrónico
  String get password => _password; // Método getter para obtener la contraseña

}

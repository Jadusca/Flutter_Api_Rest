import 'dart:typed_data'; // Importa dart:typed_data para trabajar con bytes de forma eficiente

import 'package:flutter/material.dart'; // Importa la biblioteca de Flutter para usar widgets y herramientas de Material Design
import 'package:flutter_api_rest/api/account_api.dart'; // Importa la API de la cuenta para obtener información del usuario y actualizar el avatar
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importa el cliente de autenticación para cerrar sesión
import 'package:flutter_api_rest/models/User.dart'; // Importa el modelo User para representar los datos del usuario
import 'package:flutter_api_rest/pages/login_page.dart'; // Importa la página de inicio de sesión para navegar a ella después de cerrar sesión
import 'package:flutter_api_rest/utils/logs.dart'; // Importa la utilidad Logs para registrar información
import 'package:get_it/get_it.dart'; // Importa GetIt, un contenedor de servicios para la inyección de dependencias
import 'package:image_picker/image_picker.dart'; // Importa image_picker para seleccionar imágenes desde la galería o la cámara
import 'package:logger/logger.dart'; // Importa Logger para registrar información de forma estructurada
import 'package:path/path.dart' as path; // Importa path para trabajar con rutas de archivos de forma segura

class HomePage extends StatefulWidget { // Define una clase HomePage que es mutable

  static String routeName = 'home'; // Define el nombre de la ruta de la página de inicio

  const HomePage({super.key}); // Constructor de la clase HomePage

  @override
  State<HomePage> createState() => _HomePageState(); // Crea y devuelve el estado de la página de inicio

}

class _HomePageState extends State<HomePage> { // Define una clase privada _HomePageState que extiende State<HomePage>

  final _authenticationClient = GetIt.instance<AuthenticationClient>(); // Instancia del cliente de autenticación
  final _accountApi = GetIt.instance<AccountApi>(); // Instancia de la API de la cuenta para interactuar con el servidor
  final Logger _logger = Logger(); // Instancia de Logger para registrar información

  User? _user; // Usuario actual

  @override
  void initState() { // Método que se llama una vez cuando el estado del widget es inicializado
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { // Ejecuta el código después de que se complete la construcción del frame
      _loadUser(); // Carga la información del usuario
    });
  }

  Future<void> _loadUser() async { // Función asincrónica para cargar la información del usuario
    final response = await _accountApi.getUserInfo(); // Obtiene la información del usuario desde la API
    if (response.data != null) { // Si la respuesta contiene datos de usuario
      Logs.p.i(response.data!.createdAt); // Registra la fecha de creación del usuario
      _user = response.data!; // Actualiza el usuario con los datos obtenidos
      setState(() {}); // Notifica a Flutter que se ha producido un cambio en el estado del widget
    }
  }

  Future<void> _signOut() async { // Función asincrónica para cerrar sesión
    _authenticationClient.signOut(); // Llama al método de cierre de sesión del cliente de autenticación
    Navigator.pushNamedAndRemoveUntil( // Navega a la página de inicio de sesión y elimina todas las rutas anteriores
      context,
      LoginPage.routeName,
      (route) => false,
    );
  }

  Future<void> _pickImage() async { // Función asincrónica para seleccionar una imagen desde la galería o la cámara
    final ImagePicker imagePicker = ImagePicker(); // Instancia de ImagePicker para seleccionar imágenes
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera); // Abre la cámara para tomar una foto
    if (pickedFile != null) { // Si se seleccionó una imagen
      final Uint8List bytes = await pickedFile.readAsBytes(); // Lee los bytes de la imagen seleccionada
      final filename = path.basename(pickedFile.path); // Obtiene el nombre del archivo de la imagen
      final response = await _accountApi.updateAvatar(bytes, filename); // Actualiza el avatar del usuario en el servidor
      // ignore: unnecessary_null_comparison
      if (response != null) { // Si se recibió una respuesta del servidor
        _user = _user!.copyWith(avatar: response.data); // Actualiza el usuario con la nueva imagen de avatar
        final String imageUrl = 'http://192.168.100.16:9000${response.data}'; // Construye la URL de la imagen de avatar
        Logs.p.i(imageUrl); // Registra la URL de la imagen de avatar
        setState(() {}); // Notifica a Flutter que se ha producido un cambio en el estado del widget
      }
    }
  }

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario de la página de inicio
    return Scaffold( // Retorna un widget Scaffold que proporciona una estructura básica para la página
      body: Container( // Contenedor que contiene todos los elementos de la página
        width: double.infinity, // Ancho del contenedor igual al ancho de la pantalla
        child: Column( // Widget Column para colocar elementos verticalmente
          mainAxisAlignment: MainAxisAlignment.center, // Alinea los elementos en el centro verticalmente
          children: [
            if (_user == null) const CircularProgressIndicator(), // Muestra un indicador de carga si no se ha cargado el usuario
            if (_user != null) // Si se ha cargado el usuario
              Column( // Widget Column para colocar elementos verticalmente
                children: [
                  if (_user!.avatar != null) // Si el usuario tiene un avatar
                    ClipOval( // Widget ClipOval para recortar la imagen en forma de círculo
                      child: Image.network( // Widget Image para mostrar una imagen desde una URL
                        'http://192.168.100.16:9000${_user!.avatar}', // URL de la imagen de avatar
                        width: 100, // Ancho de la imagen de avatar
                        height: 100, // Altura de la imagen de avatar
                        fit: BoxFit.cover, // Ajusta la imagen para que cubra el espacio disponible
                      ),
                    ),
                  Text(_user!.id), // Muestra el ID del usuario
                  Text(_user!.email), // Muestra el correo electrónico del usuario
                  Text(_user!.username), // Muestra el nombre de usuario del usuario
                  Text(_user!.createdAt.toIso8601String()) // Muestra la fecha de creación del usuario en formato ISO8601
                ],
              ),
            const SizedBox(height: 30,), // Espacio vertical entre elementos
            ElevatedButton( // Widget ElevatedButton para mostrar un botón elevado
              onPressed: _pickImage, // Función que se ejecuta cuando se presiona el botón
              child: const Text('Update avatar'), // Texto del botón
            ),
            ElevatedButton( // Widget ElevatedButton para mostrar un botón elevado
              onPressed: _signOut, // Función que se ejecuta cuando se presiona el botón
              child: const Text('Sign Out'), // Texto del botón
            ),
          ],
        ),
      ),
    );
  }
}

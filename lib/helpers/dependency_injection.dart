import 'package:dio/dio.dart'; // Importa la librería Dio para realizar solicitudes HTTP
import 'package:flutter_api_rest/api/account_api.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/helpers/http.dart'; // Importa la clase Http para manejar solicitudes HTTP
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Importa la librería FlutterSecureStorage para almacenar datos de forma segura
import 'package:get_it/get_it.dart'; // Importa la librería GetIt para la inyección de dependencias

abstract class DependencyInjection { // Define una clase abstracta DependencyInjection para inicializar la inyección de dependencias
  static void initialize() { // Método estático para inicializar la inyección de dependencias
    final Dio dio = Dio( // Crea una instancia de Dio para realizar solicitudes HTTP
      BaseOptions( // Configura las opciones base para las solicitudes HTTP
        baseUrl: 'http://192.168.100.16:9000/api/v1', // Establece la URL base para las solicitudes
      ),
    );
    final Http http = Http( // Crea una instancia de la clase Http para manejar solicitudes HTTP
      dio: dio, // Proporciona el objeto Dio configurado
      logsEnable: true, // Habilita el registro de logs para las solicitudes HTTP.
    );
    final _secureStorage = FlutterSecureStorage(); // Crea una instancia de FlutterSecureStorage para almacenar datos de forma segura

    final authenticationApi = AuthenticationApi(http); // Crea una instancia de AuthenticationApi para manejar la autenticación
    final authenticationClient = AuthenticationClient(_secureStorage, authenticationApi); // Crea una instancia de AuthenticationClient para gestionar el estado de autenticación del usuario
    final accountApi = AccountApi(http, authenticationClient); // Crea una instancia de AccountApi para interactuar con la API de cuentas

    GetIt getIt = GetIt.instance; // Obtiene la instancia única de GetIt para registrar las instancias creadas
    getIt.registerSingleton<AuthenticationApi>(authenticationApi); // Registra la instancia de AuthenticationApi como un singleton en GetIt
    getIt.registerSingleton<AuthenticationClient>(authenticationClient); // Registra la instancia de AuthenticationClient como un singleton en GetIt
    getIt.registerSingleton<AccountApi>(accountApi); // Registra la instancia de AccountApi como un singleton en GetIt
  }
}

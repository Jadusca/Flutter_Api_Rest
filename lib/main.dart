// Importaciones necesarias para el proyecto Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_rest/helpers/dependency_injection.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter_api_rest/pages/register_page.dart';
import 'package:flutter_api_rest/pages/splash_page.dart';

// Función principal de inicio del programa Flutter
void main() { //Es el punto de entrada de la aplicacion Flutter
  // Inicialización de la inyección de dependencias
  DependencyInjection.initialize();
  // Ejecución de la aplicación Flutter
  runApp(const MyApp());
}

// Clase principal de la aplicación Flutter
class MyApp extends StatelessWidget { //MyApp es el widget principal de la aplicacion y StatelessWidget nos esta indicando que no tiene estado mutable
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { //El metodo build devuelve la estructura de la interfaz de usuario de la aplicacion
    // Configuración de las orientaciones preferidas de la pantalla
    SystemChrome.setPreferredOrientations([ //Este metodo restringe las orientaciones de pantalla al modo vertical, esto asegura que no se ponga en horizonal, se mantenga fijo en vertical
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    // Devuelve un MaterialApp que contiene la estructura de la aplicación
    return MaterialApp( // Es la raiz del arbol de widgets
      // Desactiva el banner de depuración
      debugShowCheckedModeBanner: false,
      // Tema de la aplicación
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Página inicial de la aplicación
      home: const SplashPage(),// el home especifica la pagina principal que se muestra al inicial la aplicacion
      // Rutas de la aplicación
      routes: { //define rutas con nombres y sus widgets correspondientes (paginas)
        RegisterPage.routeName : (_) => const RegisterPage(),
        LoginPage.routeName : (_) => const LoginPage(),
        HomePage.routeName : (_) => const HomePage(),
      },
    );
  }
}
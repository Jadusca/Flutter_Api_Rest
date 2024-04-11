import 'package:flutter/material.dart'; // Importa la biblioteca de Flutter para usar widgets y herramientas de Material Design
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importa el cliente de autenticación para verificar el acceso
import 'package:flutter_api_rest/pages/home_page.dart'; // Importa la página de inicio
import 'package:flutter_api_rest/pages/login_page.dart'; // Importa la página de inicio de sesión
import 'package:get_it/get_it.dart'; // Importa GetIt, un contenedor de servicios para la inyección de dependencias

class SplashPage extends StatefulWidget { // Define una clase llamada SplashPage que es mutable

  const SplashPage({super.key}); // Constructor de la clase SplashPage

  @override
  State<SplashPage> createState() => _SplashPageState(); // Crea y devuelve el estado de la página de saludo

}

class _SplashPageState extends State<SplashPage> { // Define una clase privada _SplashPageState que extiende State<SplashPage>

  final _authenticationClient = GetIt.instance<AuthenticationClient>(); // Instancia del cliente de autenticación

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario de la página de saludo
    return Scaffold( // Retorna un widget Scaffold que proporciona una estructura básica para la página
      body: CircularProgressIndicator(), // Muestra un indicador de progreso circular en el cuerpo de la página
    );
  }

  @override
  void initState() { // Método que se llama una vez cuando el estado del widget es inicializado
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { // Ejecuta el código después de que se complete la construcción del frame
      _checkLogin(); // Llama a la función para verificar el estado de inicio de sesión
    });
  }

  Future<void> _checkLogin() async { // Función asincrónica para verificar el estado de inicio de sesión
    final token = await _authenticationClient.accessToken; // Obtiene el token de acceso del cliente de autenticación
    if (token == null) { // Si no hay token de acceso, redirige a la página de inicio de sesión
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
      return;
    }
    Navigator.pushReplacementNamed(context, HomePage.routeName); // Si hay un token de acceso, redirige a la página de inicio
  }
}

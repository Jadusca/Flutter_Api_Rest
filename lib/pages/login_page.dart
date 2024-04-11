import 'package:flutter/material.dart'; // Importa la biblioteca de Flutter para usar widgets y herramientas de Material Design
import 'package:flutter_api_rest/utils/responsive.dart'; // Importa el utilitario Responsive para obtener dimensiones responsivas
import 'package:flutter_api_rest/widgets/circle.dart'; // Importa el widget Circle para mostrar un círculo con gradiente de colores
import 'package:flutter_api_rest/widgets/icon_container.dart'; // Importa el widget IconContainer para mostrar un contenedor con un icono
import 'package:flutter_api_rest/widgets/login_form.dart'; // Importa el widget LoginForm para mostrar el formulario de inicio de sesión

class LoginPage extends StatefulWidget { // Define una clase LoginPage que es un mutable

  static const String routeName = 'login'; // Define el nombre de la ruta de la página de inicio de sesión

  const LoginPage({super.key}); // Constructor de la clase LoginPage

  @override
  State<LoginPage> createState() => _LoginPageState(); // Crea y devuelve el estado de la página de inicio de sesión

}

class _LoginPageState extends State<LoginPage> { // Define una clase privada _LoginPageState que extiende State<LoginPage>

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario de la página de inicio de sesión
    final Responsive responsive = Responsive.of(context); // Obtiene el objeto Responsive del contexto
    final double pinkSize = responsive.wp(80); // Calcula el tamaño del círculo rosado responsivo
    final double orangeSize = responsive.wp(57); // Calcula el tamaño del círculo naranja responsivo

    return Scaffold( // Retorna un widget Scaffold que proporciona una estructura básica para la página
      body: GestureDetector( // Widget GestureDetector para detectar gestos del usuario
        onTap: () {
          FocusScope.of(context).unfocus(); // Oculta el teclado virtual cuando se toca fuera de los campos de entrada
        },
        child: SingleChildScrollView( // Widget SingleChildScrollView para hacer que el contenido sea desplazable
          child: Container( // Contenedor que contiene todos los elementos de la página
            width: double.infinity, // Ancho del contenedor igual al ancho de la pantalla
            height: responsive.height, // Altura del contenedor igual a la altura de la pantalla
            child: Stack( // Widget Stack para apilar elementos unos encima de otros
              alignment: Alignment.center, // Alinea los elementos en el centro del Stack
              children: [
                Positioned( // Widget Positioned para posicionar un elemento de forma absoluta en el Stack
                  right: -pinkSize * 0.2, // Posiciona el círculo rosado hacia la derecha
                  top: -pinkSize * 0.4, // Posiciona el círculo rosado hacia arriba
                  child: Circle( // Widget Circle para mostrar un círculo con gradiente de colores
                    size: pinkSize, // Tamaño del círculo rosado
                    colors: const [ // Colores del gradiente del círculo rosado
                      Colors.pink,
                      Colors.pinkAccent
                    ],
                  ),
                ),
                Positioned( // Widget Positioned para posicionar un elemento de forma absoluta en el Stack
                  left: -orangeSize * 0.15, // Posiciona el círculo naranja hacia la izquierda
                  top: -orangeSize * 0.55, // Posiciona el círculo naranja hacia arriba
                  child: Circle( // Widget Circle para mostrar un círculo con gradiente de colores
                    size: orangeSize, // Tamaño del círculo naranja
                    colors: const [ // Colores del gradiente del círculo naranja
                      Colors.orange,
                      Colors.deepOrangeAccent
                    ],
                  ),
                ),
                Positioned( // Widget Positioned para posicionar un elemento de forma absoluta en el Stack
                  top: pinkSize * 0.4, // Posiciona el contenedor de icono y texto hacia abajo.
                  child: Column( // Widget Column para colocar elementos verticalmente
                    children: [
                      IconContainer( // Widget IconContainer para mostrar un contenedor con un icono.
                        size: responsive.wp(17), // Tamaño del icono responsivo
                      ),
                      SizedBox( // Widget SizedBox para agregar espacio entre elementos
                        height: responsive.dp(3), // Altura del SizedBox
                      ),
                      Text( // Widget Text para mostrar texto en la pantalla
                        "Hello Again\nWelcome Back", // Texto a mostrar en dos líneas
                        textAlign: TextAlign.center, // Alineación del texto al centro
                        style: TextStyle( // Estilo del texto
                          fontSize: responsive.dp(1.7) // Tamaño de fuente responsivo
                        ),
                      ),
                    ],
                  ),
                ),
                LoginForm(), // Widget LoginForm para mostrar el formulario de inicio de sesión
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart'; // Importa la biblioteca Cupertino de Flutter para usar widgets específicos de iOS
import 'package:flutter/material.dart'; // Importa la biblioteca Material de Flutter para usar widgets y herramientas de Material Design
import 'package:flutter_api_rest/utils/responsive.dart'; // Importa el utilitario Responsive para obtener dimensiones responsivas
import 'package:flutter_api_rest/widgets/avatar_button.dart'; // Importa el widget AvatarButton para mostrar un botón con imagen de avatar
import 'package:flutter_api_rest/widgets/circle.dart'; // Importa el widget Circle para mostrar un círculo con gradiente de colores
import 'package:flutter_api_rest/widgets/register_form.dart'; // Importa el widget RegisterForm para mostrar el formulario de registro

class RegisterPage extends StatefulWidget { // Define una clase RegisterPage que es mutable

  static const String routeName = 'register'; // Define el nombre de la ruta de la página de registro

  const RegisterPage({super.key}); // Constructor de la clase RegisterPage

  @override
  State<RegisterPage> createState() => _RegisterPageState(); // Crea y devuelve el estado de la página de registro

}

class _RegisterPageState extends State<RegisterPage> { // Define una clase privada _RegisterPageState que extiende State<RegisterPage>

  @override
  Widget build(BuildContext context) { // Método para construir la interfaz de usuario de la página de registro
    final Responsive responsive = Responsive.of(context); // Obtiene el objeto Responsive del contexto
    final double pinkSize = responsive.wp(88); // Calcula el tamaño del círculo rosado responsivo
    final double orangeSize = responsive.wp(60); // Calcula el tamaño del círculo naranja responsivo

    return Scaffold( // Retorna un widget Scaffold que proporciona una estructura básica para la página
      body: GestureDetector( // Widget GestureDetector para detectar gestos del usuario
        onTap: () {
          FocusScope.of(context).unfocus(); // Oculta el teclado virtual cuando se toca fuera de los campos de entrada.
        },
        child: SingleChildScrollView( // Widget SingleChildScrollView para hacer que el contenido sea desplazable.
          child: Container( // Contenedor que contiene todos los elementos de la página
            width: double.infinity, // Ancho del contenedor igual al ancho de la pantalla
            height: responsive.height, // Altura del contenedor igual a la altura de la pantalla
            child: Stack( // Widget Stack para apilar elementos unos encima de otros
              alignment: Alignment.center, // Alinea los elementos en el centro del Stack
              children: [
                Positioned( // Widget Positioned para posicionar un elemento de forma absoluta en el Stack
                  right: -pinkSize * 0.20, // Posiciona el círculo rosado hacia la derecha
                  top: -pinkSize * 0.32, // Posiciona el círculo rosado hacia arriba
                  child: Circle( // Widget Circle para mostrar un círculo con gradiente de colores
                    size: pinkSize, // Tamaño del círculo rosado
                    colors: const [Colors.pink, Colors.pinkAccent], // Colores del gradiente del círculo rosado
                  ),
                ),
                Positioned( // Widget Positioned para posicionar un elemento de forma absoluta en el Stack
                  left: -orangeSize * 0.20, // Posiciona el círculo naranja hacia la izquierda
                  top: -orangeSize * 0.40, // Posiciona el círculo naranja hacia arriba
                  child: Circle( // Widget Circle para mostrar un círculo con gradiente de colores
                    size: orangeSize, // Tamaño del círculo naranja
                    colors: const [Colors.orange, Colors.deepOrangeAccent], // Colores del gradiente del círculo naranja
                  ),
                ),
                Positioned( // Widget Positioned para posicionar un elemento de forma absoluta en el Stack
                  top: pinkSize * 0.20, // Posiciona el texto y el botón de avatar hacia abajo
                  child: Column( // Widget Column para colocar elementos verticalmente
                    children: [
                      Text( // Widget Text para mostrar texto en la pantalla
                        "Hello\nSign up to get started", // Texto a mostrar en dos líneas
                        textAlign: TextAlign.center, // Alineación del texto al centro
                        style: TextStyle( // Estilo del texto
                            fontSize: responsive.dp(1.7), // Tamaño de fuente responsivo
                            color: Colors.white), // Color del texto
                      ),
                      SizedBox( // Widget SizedBox para agregar espacio entre elementos
                        height: responsive.dp(4.5), // Altura del SizedBox
                      ),
                      AvatarButton( // Widget AvatarButton para mostrar un botón con imagen de avatar
                        imageSize: responsive.wp(25), // Tamaño de la imagen de avatar responsivo
                      )
                    ],
                  ),
                ),
                RegisterForm(), // Widget RegisterForm para mostrar el formulario de registro
                Positioned( // Widget Positioned para posicionar un elemento de forma absoluta en el Stack
                  left: 15, // Posiciona el botón de retroceso hacia la izquierda
                  top: 15, // Posiciona el botón de retroceso hacia arriba
                  child: SafeArea( // Widget SafeArea para asegurar que el contenido esté visible en dispositivos con muesca
                    child: CupertinoButton( // Widget CupertinoButton para mostrar un botón con estilo de iOS
                      onPressed: () { // Función que se ejecuta cuando se presiona el botón
                        Navigator.pop(context); // Navega hacia atrás a la página anterior
                      },
                      padding: const EdgeInsets.all(10), // Relleno del botón
                      borderRadius: BorderRadius.circular(30), // Borde redondeado del botón
                      color: Colors.black26, // Color de fondo del botón
                      child: const Icon(Icons.arrow_back), // Icono del botón
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

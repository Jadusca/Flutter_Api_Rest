import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  // Atributo de la clase IconContainer
  final double size; // Tamaño del contenedor del icono

// Constructor de la clase IconContainer
  const IconContainer({
    super.key,
    required this.size // El tamaño debe ser obligatorio y no nulo
  }): assert(size > 0); // Assert para asegurarse de que el tamaño sea mayor que cero

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, // Establece el ancho del contenedor
      height: size, // Establece la altura del contenedor
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.15), // Establece la forma del borde del contenedor
        boxShadow: const [ // Agrega una sombra al contenedor
          BoxShadow(
              color: Colors.black12, // Color de la sombra
              blurRadius: 15, // Radio de desenfoque de la sombra
              offset: Offset(0, 15) // Desplazamiento de la sombra
          ),
        ]
      ),
      padding: EdgeInsets.all(size * 0.15),  // Establece el relleno interno del contenedor
      child: Center( // Centra el contenido del contenedor
        child: SvgPicture.asset( // Muestra un icono SVG
          'assets/icon.svg', //Ruta del archivo
          width: size * 0.6, // Ancho del icono
          height: size * 0.6, // Altura del icono
        ),
      ),
    );
  }
}

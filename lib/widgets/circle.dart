import 'package:flutter/material.dart';

class Circle extends StatelessWidget { //Se define la clase Circle que no cambia su estado

  final double size; // Tamaño del circulo
  final List<Color> colors; // los colores que forman el gradiente del círculo

  // Constructor de la clase Circle
  // Toma un tamaño y una lista de colores como argumentos
  const Circle({
    super.key,
    required this.size, // Establece el tamaño del círculo
    required this.colors // Establece los colores del gradiente del círculo
  }): assert (size > 0), // Verifica que el tamaño sea mayor que 0
        assert (colors.length >= 2); // Verifica que haya al menos 2 colores en la lista

  @override
  Widget build(BuildContext context) { //Método build para construir la representación visual del widget
    return Container( // Retorna un widget Container que contiene el círculo
      width: size, // Establece el ancho del Container como el tamaño del círculo
      height: size, // Establece la altura del Container como el tamaño del círculo
      decoration: BoxDecoration( // Define la decoración del Container
        shape: BoxShape.circle, // Se establece la forma del circulo
        gradient: LinearGradient(  // Crea un gradiente lineal para el fondo del círculo
            colors: colors,
            begin: Alignment.topCenter, // Define el inicio del gradiente en la parte superior del círculo
            end: Alignment.bottomCenter // Define el final del gradiente en la parte inferior del círculo
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart'; // Importa la biblioteca Cupertino de Flutter para usar widgets específicos de iOS
import 'package:flutter/material.dart'; // Importa la biblioteca Material de Flutter para usar widgets y herramientas de Material Design

class AvatarButton extends StatelessWidget { // Define una nueva clase llamada AvatarButton que extiende a algo inmutable

  final double imageSize; // Declara una propiedad llamada imageSize que representa el tamaño de la imagen del avatar

  // Constructor de la clase AvatarButton
  // Toma un tamaño de imagen como argumento, con un valor predeterminado de 100
  const AvatarButton({
    super.key,
    this.imageSize = 100, // Establece el tamaño de la imagen del avatar como 100 por defecto
  });

  @override
  Widget build(BuildContext context) { // Método build para construir la representación visual del widget.
    return  Stack( // Retorna un widget Stack que apila varios widgets unos encima de otros.
      children: [ // Lista de widgets apilados en el Stack
        Container( // Contenedor que contiene la imagen del avatar
          margin: const EdgeInsets.all(10), // Establece márgenes para el contenedor
          decoration: const BoxDecoration( // Define la decoración del contenedor
              color: Colors.white, // Establece el color de fondo del contenedor como blanco
              shape: BoxShape.circle, // Establece la forma del contenedor como un círculo
              boxShadow: [ // Agrega una sombra al contenedor
                BoxShadow(
                  blurRadius: 20, // Establece el radio de desenfoque de la sombra
                  color: Colors.black38, // Establece el color de la sombra como negro con transparencia
                  offset: Offset(0,20), // Establece el desplazamiento de la sombra
                ),
              ]
          ),
          child: ClipOval( // Recorta la imagen para que tenga forma de círculo
            child: Image.network( // Widget de imagen cargada desde una URL
              'https://as1.ftcdn.net/v2/jpg/01/16/24/44/1000_F_116244459_pywR1e0T3H7FPk3LTMjG6jsL3UchDpht.jpg', // URL de la imagen del avatar
              width: imageSize, // Establece el ancho de la imagen del avatar
              height: imageSize, // Establece la altura de la imagen del avatar
            ),
          ),
        ),
        Positioned( // Widget que posiciona al hijo en un lugar específico del Stack
          bottom: 5, // Establece la distancia del widget desde la parte inferior del Stack
          right: 0, // Establece la distancia del widget desde el lado derecho del Stack
          child: CupertinoButton( // Botón estilo Cupertino (iOS)
            onPressed: () {  }, // Función que se ejecuta cuando se presiona el botón (en este caso, no hace nada)
            padding: EdgeInsets.zero, // Establece el relleno del botón como cero
            borderRadius: BorderRadius.circular(30), // Establece el radio de borde del botón como circular
            child: Container( // Contenedor que contiene el icono del botón
              padding: const EdgeInsets.all(3), // Establece el relleno del contenedor
              decoration: BoxDecoration( // Define la decoración del contenedor
                  border: Border.all( // Agrega un borde al contenedor
                    color: Colors.white, // Establece el color del borde como blanco
                    width: 2, // Establece el ancho del borde como 2 píxeles
                  ),
                  color: Colors.pinkAccent, // Establece el color de fondo del contenedor como rosa
                  shape: BoxShape.circle // Establece la forma del contenedor como un círculo
              ),
              child: const Icon( // Icono dentro del contenedor
                Icons.add, // Icono de "añadir"
                color: Colors.white, // Establece el color del icono como blanco
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart'; // Importa la biblioteca Cupertino de Flutter para usar widgets específicos de iOS
import 'package:flutter/material.dart'; // Importa la biblioteca Material de Flutter para usar widgets y herramientas de Material Design

abstract class Dialogs { // Define una clase abstracta llamada Dialogs

  // Método estático para mostrar un diálogo de alerta
  static alert(
      BuildContext context,
      {required String title,
      required String description}) {
    showDialog(context: context, builder: (_) => AlertDialog( // Muestra un AlertDialog
      title: Text(title), // Establece el título del AlertDialog
      content: Text(description), // Establece el contenido del AlertDialog
      actions: [ // Lista de acciones en el AlertDialog
        ElevatedButton( // Botón de acción
            onPressed: (){
              Navigator.pop(_); // Cierra el diálogo.
            },
            child: Text('OK') // Texto del botón de acción.
        )
      ],
    ));
  }

}

abstract class ProgressDialog { // Define una clase abstracta llamada ProgressDialog.

  // Método estático para mostrar un diálogo de progreso.
  static show(BuildContext context) {
    showCupertinoModalPopup( // Muestra un diálogo modal en estilo Cupertino (iOS)
        context: context,
        builder: (_) {
          return PopScope( // Widget PopScope para controlar el comportamiento de navegación
            canPop: false, // No se permite que el usuario cierre el diálogo al hacer pop
            onPopInvoked: (didPop) { // Función que se ejecuta cuando se intenta cerrar el diálogo
              if (didPop) {
                // Aquí iría la lógica cuando se intenta cerrar el diálogo
                return;
              }
              // Aquí iría la lógica cuando se intenta ir hacia atrás
            },
            child: Container( // Contenedor que contiene el indicador de progreso
              width: double.infinity, // Ancho del contenedor igual al ancho de la pantalla
              height: double.infinity, // Altura del contenedor igual a la altura de la pantalla
              color: Colors.white.withOpacity(0.9), // Color de fondo del contenedor con opacidad
              child: const Center( // Centro el indicador de progreso en el contenedor
                child: CircularProgressIndicator(), // Indicador de progreso circular
              ),
            ),
          );
        }
    );
  }

  // Método estático para cerrar el diálogo de progreso
  static dismiss(BuildContext context) {
    Navigator.pop(context); // Cierra el diálogo de progreso
  }
}
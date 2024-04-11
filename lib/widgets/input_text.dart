import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
 // Atributos de la clase InputText
  final String label; // Etiqueta del campo de entrada
  final TextInputType keyboardType; // Tipo de teclado del campo de entrada
  final bool obscureText; // Indica si el texto debe ser oculto
  final bool borderEnabled; // Indica si se habilita el borde del campo de entrada
  final double fontSize; // Tamaño de fuente del texto
  final void Function(String text)? onChanged; // Función llamada cuando el texto cambia
  final String? Function(String? text)? validator; // Función de validación del texto

 // Constructor de la clase InputText
  const InputText({
    super.key,
    this.label = '', // Valor predeterminado para la etiqueta
    this.keyboardType = TextInputType.text, // Valor predeterminado para el tipo de teclado
    this.obscureText = false, // Valor predeterminado para el texto oculto
    this.borderEnabled = true, // Valor predeterminado para habilitar el borde
    this.fontSize = 15, // Valor predeterminado para el tamaño de fuente
    this.onChanged,
    this.validator
  });

  @override
  Widget build(BuildContext context) {
    // Establece un estilo predeterminado para el borde inferior
    const UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12),
    );
    // Retorna un campo de texto con estilo
    return TextFormField(
      keyboardType: keyboardType, // Establece el tipo de teclado
      obscureText: obscureText, // Establece el texto oculto.
      style: TextStyle(fontSize: fontSize), // Establece el tamaño de fuente del texto
      onChanged: onChanged, // Establece la función llamada cuando el texto cambia
      validator: validator, // Establece la función de validación del texto
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5), // Establece el relleno del contenido
        enabledBorder: borderEnabled ? underlineInputBorder : InputBorder.none, // Establece el borde habilitado
        labelText: label, // Establece la etiqueta del campo de entrada
        labelStyle: const TextStyle(
          color: Colors.black45, // Establece el color de la etiqueta
          fontWeight: FontWeight.w500, // Establece el peso de la fuente de la etiqueta
        ),
      ),
    );
  }
}

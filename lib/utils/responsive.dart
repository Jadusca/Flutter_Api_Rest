import 'package:flutter/material.dart';
import 'dart:math' as math;

class Responsive { // Define una clase llamada Responsive.

  double _width = 0; // Declara una variable privada para almacenar el ancho de la pantalla
  double _height = 0; // Declara una variable privada para almacenar la altura de la pantalla
  double _diagonal = 0; // Declara una variable privada para almacenar la diagonal de la pantalla
  bool _isTablet = false; // Declara una variable privada para almacenar si el dispositivo es una tableta o no

  Responsive(BuildContext context) { // Constructor de la clase Responsive. Toma un contexto de construcción como argumento
    final Size size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla del contexto
    _width = size.width; // Asigna el ancho de la pantalla
    _height = size.height; // Asigna la altura de la pantalla
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2)); // Calcula la diagonal de la pantalla utilizando el teorema de Pitágoras
    _isTablet = size.shortestSide >= 600; // Verifica si el lado más corto de la pantalla es mayor o igual a 600 píxeles para determinar si es una tableta
  }

  static Responsive of(BuildContext context) => Responsive(context); // Método estático que devuelve una instancia de Responsive a partir de un contexto

  double get width => _width; // Getter para obtener el ancho de la pantalla.
  double get height => _height; // Getter para obtener la altura de la pantalla.
  double get diagonal => _diagonal; // Getter para obtener la diagonal de la pantalla.
  bool get isTablet => _isTablet; // Getter para obtener si el dispositivo es una tableta o no.

  // Método para calcular un porcentaje del ancho de la pantalla.
  double wp(double percent) => _width * percent / 100;

  // Método para calcular un porcentaje de la altura de la pantalla.
  double hp(double percent) => _height * percent / 100;

  // Método para calcular un porcentaje de la diagonal de la pantalla.
  double dp(double percent) => _diagonal * percent / 100;
}

import 'package:logger/logger.dart'; // Importa la biblioteca de registro de Logger

class Logs { // Define una clase llamada Logs

  Logs._internal(); // Constructor privado que no permite instancias externas de la clase

  final Logger _logger = Logger(); // Crea una instancia de Logger para gestionar los registros

  static final Logs _instance = Logs._internal(); // Crea una instancia estática de la clase Logs

  // Getter estático para obtener la instancia del Logger.
  // Utiliza la convención de un getter llamado 'p' para acceder al logger de forma más concisa
  static Logger get p => _instance._logger;

}

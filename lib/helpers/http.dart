import 'package:dio/dio.dart'; // Importa la librería Dio para realizar solicitudes HTTP
import 'package:flutter_api_rest/helpers/http_response.dart'; // Importa el modelo HttpResponse para manejar respuestas HTTP
import 'package:flutter_api_rest/utils/logs.dart'; // Importa la clase Logs para el registro de logs

class Http { // Define una clase Http para realizar solicitudes HTTP

  late Dio _dio; // Objeto Dio para realizar solicitudes HTTP
  late bool _logsEnable; // Indica si se deben habilitar los registros de logs

  Http({ // Constructor de la clase Http que recibe un objeto Dio y un booleano para habilitar los logs
    required Dio dio, // Objeto Dio requerido para realizar las solicitudes HTTP
    required bool logsEnable, // Booleano que indica si se deben habilitar los logs
  }) {
    _dio = dio; // Asigna el objeto Dio recibido
    _logsEnable = logsEnable; // Asigna el valor del booleano para habilitar los logs
  }

  Future<HttpResponse<T>> request<T>( // Método para realizar una solicitud HTTP genérica
    String path, { // URL del endpoint al que se va a realizar la solicitud
    String method = 'GET', // Método HTTP de la solicitud (GET por defecto)
    Map<String, dynamic>? queryParameters, // Parámetros de consulta de la solicitud
    Map<String, dynamic>? data, // Datos del cuerpo de la solicitud (para métodos que envían datos en el cuerpo)
    Map<String, dynamic>? formData, // Datos del formulario de la solicitud (para envíos de formularios)
    Map<String, dynamic>? headers, // Cabeceras de la solicitud HTTP
    T Function(dynamic data)? parser, // Función para analizar y convertir los datos de respuesta
  }) async {
    try {
      final response = await _dio.request( // Realiza la solicitud HTTP utilizando el objeto Dio
        path,
        options: Options( // Opciones de configuración de la solicitud
          method: method, // Método HTTP de la solicitud
          headers: headers, // Cabeceras de la solicitud
        ),
        queryParameters: queryParameters, // Parámetros de consulta de la solicitud
        data: formData != null? FormData.fromMap(formData) : data, // Datos del cuerpo de la solicitud o formulario
      );
      if (_logsEnable) { // Verifica si los logs están habilitados
        Logs.p.i(response.data); // Registra los datos de la respuesta en los logs
      }

      if (parser != null) { // Verifica si se proporcionó una función de análisis
        return HttpResponse.success<T>(parser(response.data)); // Retorna una HttpResponse con los datos analizados
      }

      return HttpResponse.success<T>(response.data); // Retorna una HttpResponse con los datos de la respuesta
    } catch (e) { // Captura cualquier error durante la solicitud
      if (_logsEnable) { // Verifica si los logs están habilitados
        Logs.p.e(e); // Registra el error en los logs
      }

      int statusCode = 0; // Código de estado por defecto
      String message = 'unknown error'; // Mensaje de error por defecto
      dynamic data; // Datos de respuesta del error

      if (e is DioError) { // Verifica si el error es de tipo DioError
        statusCode = -1; // Asigna un código de estado negativo como indicador de error
        message = e.message.toString(); // Obtiene el mensaje de error
        if (e.response != null) { // Verifica si hay una respuesta asociada al error
          statusCode = e.response!.statusCode!; // Obtiene el código de estado de la respuesta
          message = e.response!.statusMessage!; // Obtiene el mensaje de estado de la respuesta
          data = e.response!.data; // Obtiene los datos de respuesta del error
        }
      }
      return HttpResponse.fail( // Retorna una HttpResponse con el estado de fallo y los detalles del error
        statusCode: statusCode, // Código de estado del error
        message: message, // Mensaje de error
        data: data, // Datos de respuesta del error
      );
    }
  }
}

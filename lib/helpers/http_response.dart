class HttpResponse<T> { // Define una clase HttpResponse que representa una respuesta HTTP genérica

  final T? data; // Datos de la respuesta HTTP
  final HttpError? error; // Error de la respuesta HTTP, si lo hay

  HttpResponse(this.data, this.error); // Constructor de la clase HttpResponse que recibe los datos y el error

  static HttpResponse<T> success<T>(T data) => HttpResponse(data, null); // Método estático para crear una respuesta HTTP exitosa

  static HttpResponse<T> fail<T>({ // Método estático para crear una respuesta HTTP de fallo
    required int statusCode, // Código de estado del error
    required String message, // Mensaje de error
    required dynamic data // Datos de respuesta del error
  }) => HttpResponse(null, HttpError( // Retorna una HttpResponse con el error
    statusCode: statusCode, // Asigna el código de estado del error
    message: message, // Asigna el mensaje de error
    data: data // Asigna los datos de respuesta del error
  ));

}

class HttpError { // Define una clase HttpError que representa un error en una respuesta HTTP

  final int statusCode; // Código de estado del error
  final String message; // Mensaje de error
  final dynamic data; // Datos de respuesta del error

  HttpError({ // Constructor de la clase HttpError que recibe los datos del error
    required this.statusCode, // Código de estado del error
    required this.message, // Mensaje de error
    required this.data // Datos de respuesta del error
  });

}

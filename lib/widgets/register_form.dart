//Importaciones necesarias para el proyecto flutter
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_api_rest/api/authentication_api.dart';
import 'package:flutter_api_rest/models/user_register_model.dart';
import 'package:flutter_api_rest/data/authentication_client.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/utils/dialogs.dart';
import 'package:flutter_api_rest/utils/responsive.dart';
import 'package:flutter_api_rest/widgets/input_text.dart';
import 'package:get_it/get_it.dart';

class RegisterForm extends StatefulWidget { //Widget de estado mutable
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final GlobalKey<FormState> _formKey = GlobalKey(); //para acceder a widgets específicos desde cualquier parte de la aplicación
  String _email = '', _password = '', _username = ''; //variables para almacenar datos de entrada
  final _authenticationApi = GetIt.instance<AuthenticationApi>(); //Instancia de la API de autenticación
  final _authenticationClient = GetIt.instance<AuthenticationClient>(); //Instancia del cliente de autenticación

  Future<void>_submit() async {//Este metodo se llama cuando el usuario envia el formulario, valida los campos
    final bool isOk = _formKey.currentState!.validate(); //Valida el formulario
    if (isOk) {
      ProgressDialog.show(context); //muestra un dialogo de progreso
      final response = await _authenticationApi.register( //Le envia una solicitud de registro a la API
          userRegister: UserRegisterModel(
              username: _username,
              email: _email,
              password: _password
          ),
      );
      ProgressDialog.dismiss(context); //Cierra el dialogo de progreso
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data!); //Guarda la sesion del usuario
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false); //Navega a la pagina de inicio y elimina rutas anteriores
      }
      else {

        String message = response.error!.message; //Mensaje de error

        if (response.error!.statusCode == -1) { //Mensaje de error a problemas de red
          message = 'Bad Network';
        }
        else if (response.error!.statusCode == 409) {
          message = 'Duplicate user ${jsonEncode(response.error!.data['duplicatedFields'])}'; //Mensaje de error para usuario duplicado
        }

        Dialogs.alert( //Muestra un mensaje de error adecuado (bad network o usuario duplicado)
            context,
            title: 'Error',
            description: message
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context); //Es para adaptar a cualquier ancho de pantalla

    return Positioned(
      bottom: 30, //ósicioa el widget en la parte inferior de la pantalla
      child: Container(
        constraints: BoxConstraints(
              maxWidth: responsive.isTablet ? 430 : 360, //Limita el ancho maximo del contenedor meidante el tamaño del dispositivo
            ),
        child: Form( //
          key: _formKey, // Asigna la clave globar al formulario
          child: Column(
          children: <Widget>[
            InputText(
              keyboardType: TextInputType.emailAddress,
              label: "USERNAME",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
              onChanged: (text){
                _username = text; // Captura el texto ingresado para el nombre de usuario
              },
              validator: (text){
                if(text!.trim().length < 5){
                  return "Invalid username"; //Valida la entrada del nombre de usuario
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(2)), //Deja espacios en blanco
            InputText(
              keyboardType: TextInputType.emailAddress,
              label: "EMAIL ADDRESS",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
              onChanged: (text){
                _email = text; // Captura el texto ingresado para la direccion de correo electronico
              },
              validator: (text){
                if(!text!.contains('@')){
                  return "Invalid email"; //Valida la entrada del correo electronico
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(2)),
            InputText(
              obscureText: true,//Hace que no este visible como en el input text normal
              label: "PASSWORD",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
              onChanged: (text){
                _password = text; // Captura el texto ingresado para la contraseña
              },
              validator: (text){
                if(text?.trim().isEmpty == true){
                  return "Invalid password"; //Valida si la entrada de la contraseña es correcta
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(8)), //Deja espacios en blanco
            SizedBox(
              width: double.infinity, //El boton ocupa todo el ancho disponible
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 15),
                color: Colors.pinkAccent,
                onPressed: (){
                  _submit(); //Maneja la accion de enviar el formulario
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: responsive.dp(2)), //Deja espacios en blanco
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Already have an account?", style: TextStyle(fontSize: responsive.dp(1.5)),),
                MaterialButton(
                  child: Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: responsive.dp(1.5),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); //Navega de vuelta a la pagina anterior
                },
                ),
              ],
            ),
            SizedBox(height: responsive.dp(10)), //Deja espacios en blanco
          ],
                ),
        ),
      ),
    );
  }
}
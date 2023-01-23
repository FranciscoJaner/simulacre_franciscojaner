import 'package:flutter/material.dart';
import 'package:simulacre_franciscojaner/screens/home_screen.dart';

import '../preferences/preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController _username =
      TextEditingController(); // Controllers per poder gestionar el textfields i poder emplear o indicar els seus valors.
  final TextEditingController _password = TextEditingController();

  RegExp emailRegExp =
      new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');

  bool mirarvalor = false; // Variable que es el valor de el checkbox.
  bool _logueado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _logueado ? HomeScreen() : loginForm(),
    );
  }

  Widget loginForm() {
    _getValor();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      scrollDirection: Axis.vertical,
      child: Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 90,
            ),
            const Divider(),
            const Text(
              // Texte de login
              'Login',
              style: TextStyle(fontSize: 25),
            ),
            const Divider(),
            // Primer textfield en el cual introduirem el nom de usuari
            TextFormField(
              validator: (text) {
                if (text!.length == 0) {
                  return "Correu es obligatori";
                } else if (!emailRegExp.hasMatch(text)) {
                  return "Format correu incorrecte";
                }
                return null;
              },
              controller: _username,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                Preferences.usuari = value;
              },
              decoration: const InputDecoration(
                labelText: 'Escrigui el seu correu',
                icon: Icon(Icons.supervised_user_circle),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3),
                ),
              ),
            ),
            const Divider(),
            // TextField en el cual introduirem la contrasenya de l'usuari.
            TextFormField(
              validator: (text) {
                if (text!.length == 0) {
                  return "Contrasenya és obligatori";
                } else if (text.length <= 5) {
                  return "Contrasenya mínim de 5 caràcters";
                } else if (!contRegExp.hasMatch(text)) {
                  return "Contrasenya incorrecte";
                }
                return null;
              },
              controller: _password,
              keyboardType: TextInputType.text,
              obscureText: true,
              onChanged: (value) {
                Preferences.contrasena = value;
              },
              decoration: const InputDecoration(
                labelText: 'Contrasenya',
                icon: Icon(Icons.password),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 3),
                ),
              ),
            ),
            const Divider(),
            CheckboxListTile(
              // CheckBox que si esta activda guardara els valors de els textfields.
              value: mirarvalor,
              title: const Text('Recordem'),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                _onChanged(value!);
              },
            ),
            const Divider(),
            _boto()
          ],
        ),
      ),
    );
  }

  // Metode que empleam per crear el boto.
  _boto() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: (() {
              if (_key.currentState!.validate()) {
                _key.currentState!.save();
                setState(() {
                  _logueado = true;
                });
              }
            }),
            child: const Text('Enviar'),
          ),
        ),
      ],
    );
  }

  _onChanged(bool value) async {
    // Metode que el que fa es mirar el valor del checkbox i quan canvia li asigna a la variable mirarvalor i a las preferences el valors de el controllers.
    setState(() {
      mirarvalor = value;
      Preferences.checkValue = mirarvalor;
      Preferences.usuari = _username.text;
      Preferences.contrasena = _password.text;
      _getValor();
    });
  }

  _getValor() async {
    // Aquest metode el que fa es segons el valor que tengui mirar valor, es guardaran els camps o no fent com un especie de recordatori per no tenir que tornar a intorduir els camps.
    setState(() {
      mirarvalor = Preferences
          .checkValue; // Assignam a mirar valor el valor de la preferencia.
      if (mirarvalor != null) {
        // Si conte algo
        if (mirarvalor) {
          // Si es true asignara als controllers els valors de las preferences.
          _username.text = Preferences.usuari;
          _password.text = Preferences.contrasena;
        } else {
          // Si es false borrara els valors dels controlles y de las preferences.
          _username.clear();
          _password.clear();
          Preferences.clear();
        }
      } else {
        mirarvalor = false;
      }
    });
  }
}

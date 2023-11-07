// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:word_detective/authentification/register.dart';
import 'package:word_detective/pages/choix.dart';
import 'package:word_detective/pages/constants/constants.dart';
import 'package:word_detective/pages/constants/strings.dart';
import 'package:word_detective/pages/game.dart';
import 'package:word_detective/routes/route.dart';
import 'package:word_detective/services/preferences.dart';
import 'package:word_detective/services/requete.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  TextEditingController email = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");
  final pref = Preferences.pref;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: double.infinity,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: buildForm(),
                ),
              ),
            ),
        ),
        ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
                bottom: 20), // Ajuste l'espace autour du logo
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                  spreadRadius: 5, // Rayon de dispersion
                  blurRadius: 7, // Flou
                  offset: const Offset(0, 3), // Décalage de l'ombre
                ),
              ],
            ),
            child: Image.asset(logo, width: 100, height: 100),
          ),

          // Logo

          const SizedBox(height: 20),
          // Texte
          const Text(
            motLogin,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            motLogin2,
            style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 40),
          // Input pour l'email
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Couleur de fond du conteneur
              borderRadius: BorderRadius.circular(30), // Bord arrondi
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                  spreadRadius: 2, // Rayon de dispersion
                  blurRadius: 7, // Flou
                  offset: const Offset(0, 3), // Décalage de l'ombre
                ),
              ],
            ),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: "Email de l'utilisateur",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  // Bordure de l'Input
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == "") {
                  return emailHint;
                }
                if (!emailRegex.hasMatch(value!)) {
                  return emailVerifHint;
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
          ),

          const SizedBox(height: 20),
          // Input pour le mot de passe
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Couleur de fond du conteneur
              borderRadius: BorderRadius.circular(30), // Bord arrondi
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                  spreadRadius: 2, // Rayon de dispersion
                  blurRadius: 7, // Flou
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                labelText: 'Mot de passe',
                border: OutlineInputBorder(
                  // Bordure de l'Input
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == "") {
                  return passwordHint;
                }
                if (!passwordRegex.hasMatch(value!)) {
                  return password8CaractHint;
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
          ),

          const SizedBox(height: 40),
          // Bouton de connexion
          ElevatedButton(
            // ignore: sort_child_properties_last
            child: const Text('Se connecter'),
            onPressed: () {
              _submitForm();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                registerStr,
                style: TextStyle(fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  navigator(context, const Register());
                },
                child: const Text(
                  registerBtn,
                  style: TextStyle(fontSize: 13, color: Colors.blue),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String isLogin = await apiLogin(_email, _password);
      if (isLogin == 'true') {
        CustomToast.show(context, "Connexion Réussie");
        pref.login();
        navigator(context, DifficultySelectionScreen());
      } else if (isLogin == 'false') {
        CustomToast.show(context, "Echec de Connexion");
      } else {
        CustomToast.show(context, "Email ou mot de passe invalide");
      }
    }
  }
}

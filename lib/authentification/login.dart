// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
final pref=Preferences.pref;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          color: Colors.white,
          child: Center(
            child: SizedBox(
              width: 350,
              height: 450,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Connexion",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    Card(
                      elevation: 5,
                      color: const Color(0xFFD46F4D),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: buildForm(),
                      ),
                    ),
                  ],
                ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: email,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFFFBF66),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              labelText: "Email de l'utilisateur",
              border: OutlineInputBorder(),
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
          const SizedBox(height: 16),
          TextFormField(
            controller: password,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFFFBF66),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              labelText: 'Mot de passe',
              border: OutlineInputBorder(),
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
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _submitForm();
            },
            child: const Text("Se connecter"),
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
   void loginSuccessful() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  // Navigue vers la page d'accueil
}
}

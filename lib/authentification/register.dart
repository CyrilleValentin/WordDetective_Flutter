// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:word_detective/authentification/login.dart';
import 'package:word_detective/pages/choix.dart';
import 'package:word_detective/pages/constants/constants.dart';
import 'package:word_detective/pages/constants/strings.dart';
import 'package:word_detective/pages/game.dart';
import 'package:word_detective/routes/route.dart';
import 'package:word_detective/services/preferences.dart';
import 'package:word_detective/services/requete.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final pref = Preferences.pref;
  String _email = '';
  String _name = '';
  String _password = '';
  String _confpassword = '';
  TextEditingController name = TextEditingController(text: "");
  TextEditingController email = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");
  TextEditingController confPassword = TextEditingController(text: "");

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
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), 
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(logo, width: 100, height: 100),
          ),

          // Logo

          const SizedBox(height: 10),
          // Texte
          const Text(
            motRegister,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            motRegister2,
            style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                labelText: "Nom de l'utilisateur",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  // Bordure de l'Input
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == "") {
                  return nameHint;
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
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
              controller: confPassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                labelText: 'Confirmer Mot de passe',
                border: OutlineInputBorder(
                  // Bordure de l'Input
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == "") {
                  return confpasswordHint;
                }
                if (!passwordRegex.hasMatch(value!)) {
                  return confVerifpasswordHint;
                }
                return null;
              },
              onSaved: (value) {
                _confpassword = value!;
              },
            ),
          ),

          const SizedBox(height: 25),
          // Bouton de connexion
          ElevatedButton(
            // ignore: sort_child_properties_last
            child: const Text("S'inscrire"),
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

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                loginStr,
                style: TextStyle(fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  navigator(context, const LoginScreen());
                },
                child: const Text(
                  loginBtn,
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
      String isRegister =
          await apiRegister(_name, _email, _password, _confpassword);
      if (isRegister == 'true') {
        CustomToast.show(context, "Inscription Réussie");
        pref.login();
        navigator(context, DifficultySelectionScreen());
      } else if (isRegister == 'false') {
        CustomToast.show(context, "Echec de l'inscription");
      } else {
        CustomToast.show(context, "Adresse email déjà utilisée");
      }
    }
  }
}

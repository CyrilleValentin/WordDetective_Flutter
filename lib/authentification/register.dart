// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:word_detective/pages/choix.dart';
import 'package:word_detective/pages/constants/constants.dart';
import 'package:word_detective/pages/constants/strings.dart';
import 'package:word_detective/pages/game.dart';
import 'package:word_detective/routes/route.dart';
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
                      "Inscription",
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
            controller: name,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFFFBF66),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              labelText: "Nom de l'utilisateur",
              border: OutlineInputBorder(),
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
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          TextFormField(
            controller: confPassword,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFFFBF66),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              labelText: 'Confirmer Mot de passe',
              border: OutlineInputBorder(),
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
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              _submitForm();
            },
            child: const Text("S'inscrire"),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String isRegister =
          await fetchData(_name, _email, _password, _confpassword);
      if (isRegister == 'true') {
        CustomToast.show(context, "Inscription Réussie");
        navigator(context, DifficultySelectionScreen());
      } else if (isRegister == 'false') {
        CustomToast.show(context, "Echec de l'inscription");
      }
      else{
        CustomToast.show(context, "Adresse email déjà utilisée");

      }
    }
  }
}

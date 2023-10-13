// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:word_detective/authentification/login.dart';
import 'package:word_detective/pages/game.dart';
import 'package:word_detective/routes/route.dart';
import 'package:word_detective/services/requete.dart';

class Compte extends StatefulWidget {
  const Compte({super.key});

  @override
  _CompteState createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () async {
                if (await apiLogout(pref.getToken!)){
                CustomToast.show(context, "Déconnexion Réussie");
                 navigator(context, const LoginScreen());
                }else{
                CustomToast.show(context, "Echec de Déconnexion ");
               
                }
              
            },
            icon: Image.asset(
              "images/logout.png",
              width: 30,
              height: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: 350,
            height: 450,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue),
                  width: 110,
                  height: 110,
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
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFFFBF66),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              labelText: "Nom de l'utilisateur",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFFFBF66),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              labelText: "Email de l'utilisateur",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFFFFBF66),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              labelText: 'Score',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red)),
            onPressed: () {
              _submitForm();
            },
            child: const Text("Supprimer mon compte"),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
}

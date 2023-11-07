import 'package:flutter/material.dart';
import 'package:word_detective/pages/constants/constants.dart';
import 'package:word_detective/pages/constants/strings.dart';

class LoginScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.only(bottom: 20), // Ajuste l'espace autour du logo
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
              style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold ),
            ),
            const SizedBox(height: 10),
            const Text(
            motLogin2,
              style: TextStyle(fontSize: 10,fontStyle: FontStyle.italic ),
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
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email), // Icône à gauche
                  hintText: 'Email', // Texte indicatif
                  border: OutlineInputBorder(
                    // Bordure de l'Input
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
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
                    offset: const Offset(0, 3), // Décalage de l'ombre
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email), // Icône à gauche
                  hintText: 'Email', // Texte indicatif
                  border: OutlineInputBorder(
                    // Bordure de l'Input
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            // Bouton de connexion
            ElevatedButton(
              child: const Text('Connexion'),
              onPressed: () {
                // Logique de connexion
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

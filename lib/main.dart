import 'package:flutter/material.dart';
import 'Jeu.dart';

void main() {
  runApp(WordDetective());
}

class WordDetective extends StatelessWidget {
  const WordDetective({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Accueil());
  }
}

class Accueil extends StatelessWidget {
  const Accueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBEDC3C),
      appBar: AppBar(
        title: const Text("Word Detective"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Ouvrir les paramètres',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A919E),
          ),
          child: const Text("Commencer"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const Niveau();
              }),
            );
          },
        ),
      ),
    );
  }
}

class Niveau extends StatelessWidget {
  const Niveau({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFBEDC3C),
        body: Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: const Text("Facile"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return MyStatefulWidget();
                        }),
                      );
                    }),
                ElevatedButton(child: const Text("Normal"), onPressed: () {}),
                ElevatedButton(
                    child: const Text("Difficile"), onPressed: () {}),
                ElevatedButton(child: const Text("Quitter"), onPressed: () {}),
              ],
            ),
          ),
        ));
  }
}

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Word Detective',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  int compteur = 0;
  String currentWord = "";
  String indice = "";
  int score = 0;
  int lives = 3;
  int timeLimit = 60;
  int timeLeft = 0;
  TextEditingController guessController = TextEditingController();
  Timer? timer;
  List<String> words = [
    "chat",
    "pain",
    "vent",
    "rose",
    "bleu",
    "feu",
    "noir",
    "lien",
    "main",
    "jour",
    "peur",
    "beau",
    "vrai",
    "haut",
    "bas",
    "froid",
    "pois",
    "dent",
    "rire",
    "fleur",
    "herbe",
    "ciel",
    "soleil",
    "pluie",
    "neige",
    "lune",
    "étoile",
    "temps",
    "vente",
    "porte",
    "table",
    "chien",
    "chaton",
    "oiseau",
    "lapin",
    "singe",
    "tigre",
    "lion",
    "ours",
    "souris",
    "pomme",
    "poire",
    "raisin",
    "melon",
    "orange",
    "citron",
    "fraise",
    "cerise",
    "sel",
    "sucre",
    "miel",
    "lait",
    "eau",
    "pain",
    "riz",
    "poule",
    "vache",
    "coq",
    "âne",
    "arbre",
    "fleur",
    "herbe",
    "racine",
    "terre",
    "pierre",
    "bois",
    "fer",
    "verre",
    "or",
    "rouge",
    "vert",
    "bleu",
    "noir",
    "blanc"
  ];

  @override
  void initState() {
    super.initState();
    newWord();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void newWord() {
    setState(() {
      currentWord = words[Random().nextInt(words.length)];
      List<String> shuffledLetters = currentWord.split('')..shuffle();
      indice = shuffledLetters.join('-');
    });
  }

  void startTimer() {
    timeLeft = timeLimit;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft -= 1;
      });
      if (timeLeft <= 0) {
        timer.cancel();
        if (lives > 1) {
          CustomToast.show(context, "Temps écoulé; le mot est: $currentWord ");
          newWord();
          startTimer();
        } else {
          endGame();
        }
      }
    });
  }

  void checkGuess() {
    String guess = guessController.text;
    if (guess == currentWord) {
      timer?.cancel();
      setState(() {
        score += 1;
        compteur += 1;
        newWord();
        startTimer();
      });
      if (compteur >= 3) {
        setState(() {
          score += 3;
        });
      }
      CustomToast.show(context, "Bravo vous avez deviné le mot!");
    } else {
      timer?.cancel();
      if (lives > 1) {
        setState(() {
          compteur = 0;
          lives -= 1;
        });
        newWord();
        startTimer();
        CustomToast.show(context, "Désolé ce n'était pas le bon mot!");
      } else {
        endGame();
      }
    }
    guessController.clear();
  }

  void endGame() async {
    timer?.cancel();
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Partie Terminée'),
          content: const Text('Voulez vous continuer?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Oui'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Non'),
            ),
          ],
        );
      },
    );
    if (result == true) {
      setState(() {
        score = 0;
        lives = 3;
      });
      newWord();
      startTimer();
    } else {
      Navigator.pop(context);
    }
  }

  String formatDuration(int seconds) {
    final formatter = NumberFormat('00');
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    final formattedMinutes = formatter.format(minutes);
    final formattedSeconds = formatter.format(remainingSeconds);
    return '$formattedMinutes:$formattedSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFFFBF66),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  child: Card(
                    color: const Color(0xFF264653),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Niveau",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Vie:$lives",
                            style: const TextStyle(
                                fontSize: 20,color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Score:$score",
                            style: const TextStyle(
                                fontSize: 20,color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Text(
                    formatDuration(timeLeft),
                    style: const TextStyle(
                        fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: SizedBox(
                    width: 350,
                    child: Card(
                      color: const Color(0xFFD46F4D),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: buildForm(),
                      ),
                    ),
                  ),
                )
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
          Text(
            indice,
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: guessController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              labelText: 'Mot à deviner ',
              hintText: 'Entrer un Mot',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFFFFBF66),
              prefixIcon: const Icon(Icons.abc_outlined),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vous devez entrer un Mot';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                checkGuess();
              }
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}

class CustomToast {
  static void show(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const ImageIcon(
              AssetImage("images/word.png"),
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),

        backgroundColor: Colors.blue,
        // Couleur de fond
        duration: const Duration(seconds: 2),
        // Durée du toast
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

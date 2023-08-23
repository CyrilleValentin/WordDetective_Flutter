import 'dart:math';

import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _mot = '';
  List<String> wordList = ["chat","pain","vent","rose","bleu","feu","noir","lien","main","jour","peur","beau","vrai","haut","bas","froid","pois","dent","rire","fleur","herbe","ciel","pluie","neige","lune","temps","vente","porte","table","chien","lapin","singe","tigre","lion","ours","pomme","poire","raisin","melon","orange","citron","fraise","cerise","tomate","oignon","sel","sucre","miel","yaourt","lait","eau","pain","riz","poule","vache","coq","âne","canard","arbre","fleur","herbe","terre","pierre","bois","fer","verre","or","rouge","vert","bleu","noir","blanc"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                child: const Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Niveau",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Vie",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Score",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                child:
                    buildCountdownTimer(), // Integrate the countdown timer here
              ),
              Container(

                child: Center(
                  child: Container(
                    width: 350, // Adjust the width as needed
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: buildForm(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCountdownTimer() {
    int countdownDuration = 60; // 1 minute in seconds
    Stream<int> countdownStream = Stream.periodic(
            Duration(seconds: 1), (int i) => countdownDuration - i - 1)
        .take(countdownDuration);

    return StreamBuilder<int>(
      stream: countdownStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (!snapshot.hasData) {
          return Text('00:00',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
        }

        int remainingSeconds = snapshot.data!;
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;

        String formattedTime = '$minutes:${seconds.toString().padLeft(2, '0')}';

        return Text(formattedTime,
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold));
      },
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            generateRandomWord(wordList), // Display a random word here
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 30),
          TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              labelText: 'Mot à deviner ',
              hintText: 'Entrer un Mot',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: const Icon(Icons.abc_outlined),
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vous devez entrer un Mot';
              }
              return null;
            },
            onSaved: (value) {
              _mot = value!;
            },
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _submitForm();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Mot: $_mot');
    }
  }
  String generateRandomWord(List<String> wordList) {
    if (wordList.isEmpty) {
      return 'No words available';
    }

    final random = Random();
    final randomIndex = random.nextInt(wordList.length);
    return wordList[randomIndex];
  }
}

// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:word_detective/navigation/bottomNavigation.dart';
import 'package:word_detective/routes/route.dart';
import 'package:word_detective/services/preferences.dart';

enum DifficultyLevel {
  // ignore: constant_identifier_names
  Facile,
  Normal,
  Difficile
}

class DifficultySelectionScreen extends StatefulWidget {
  const DifficultySelectionScreen({super.key});

  @override
  _DifficultySelectionScreenState createState() =>
      _DifficultySelectionScreenState();
}

class _DifficultySelectionScreenState extends State<DifficultySelectionScreen> {
  DifficultyLevel selectedLevel = DifficultyLevel.Facile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélection de la difficulté'),
        backgroundColor: const Color(0xFF264653),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choisissez votre niveau de difficulté:'),
            DropdownButton<DifficultyLevel>(
              value: selectedLevel,
              items: const [
                DropdownMenuItem<DifficultyLevel>(
                  value: DifficultyLevel.Facile,
                  child: Text('Facile'),
                ),
                DropdownMenuItem<DifficultyLevel>(
                  value: DifficultyLevel.Normal,
                  child: Text('Normal'),
                ),
                DropdownMenuItem<DifficultyLevel>(
                  value: DifficultyLevel.Difficile,
                  child: Text('Difficile'),
                ),
              ],
              onChanged: (level) {
                setState(() {
                  selectedLevel = level!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await Preferences.pref.niveau(selectedLevel.name);
                Navigator.pop(context, selectedLevel);
                navigator(context, const BottomNavBar());
              },
              child: const Text('Commencer le jeu'),
            ),
          ],
        ),
      ),
    );
  }
}

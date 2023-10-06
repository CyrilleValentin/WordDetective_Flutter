import 'package:flutter/material.dart';
import 'package:word_detective/navigation/bottomNavigation.dart';
import 'package:word_detective/routes/route.dart';
import 'package:word_detective/services/preferences.dart';
enum DifficultyLevel{
  facile,normal,difficile
}

class DifficultySelectionScreen extends StatefulWidget {
  @override
  _DifficultySelectionScreenState createState() => _DifficultySelectionScreenState();
}

class _DifficultySelectionScreenState extends State<DifficultySelectionScreen> {
  DifficultyLevel selectedLevel = DifficultyLevel.facile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sélection de la difficulté')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choisissez votre niveau de difficulté:'),
            DropdownButton<DifficultyLevel>(
              value: selectedLevel,
              items: const [
                DropdownMenuItem<DifficultyLevel>(
                  value: DifficultyLevel.facile,
                  child: Text('Facile'),
                ),
                DropdownMenuItem<DifficultyLevel>(
                  value: DifficultyLevel.normal,
                  child: Text('Normal'),
                ),
                DropdownMenuItem<DifficultyLevel>(
                  value: DifficultyLevel.difficile,
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
              onPressed: ()async {
                await
                Preferences.pref.niveau(selectedLevel.name);
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
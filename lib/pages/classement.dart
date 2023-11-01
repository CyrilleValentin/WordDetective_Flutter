import 'package:flutter/material.dart';
import 'package:word_detective/services/requete.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    super.key,
  });

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF264653),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Classement'),
          ],
        ),
      ),
     body: FutureBuilder<List<dynamic>>(
        future: fetchClassementData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erreur de chargement'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;

            return ListView.separated(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final name = user['name'];
                final score = user['score'];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xff764abc),
                    child: Text(name[0]), // Utilisez la première lettre du nom comme initiale
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Score: $score'),
                  trailing: Text('Rang: ${index + 1}'), // Afficher le rang ici
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey,
                );
              },
            );
          } else {
            return const Center(child: Text('Aucune donnée disponible.'));
          }
        },
      ),
    );
  }
}
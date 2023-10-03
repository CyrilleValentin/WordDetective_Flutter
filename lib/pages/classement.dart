import 'package:flutter/material.dart';
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: const Color(0xFFFFBF66),
        child: Center(
          child: Text("Classement"),
        ),
      ),
    );
  }
}

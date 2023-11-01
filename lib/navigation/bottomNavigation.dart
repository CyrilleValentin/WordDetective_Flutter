// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:word_detective/pages/classement.dart';
import 'package:word_detective/pages/compte.dart';
import 'package:word_detective/services/preferences.dart';
import '../pages/game.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 0;
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   final pref= Preferences.pref;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NavigationBar(
          indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          height: 50,
          backgroundColor: const Color(0xFF264653),
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          //indicatorColor: const Color(0xFFFFBF66),
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            const NavigationDestination(
              selectedIcon: Icon(
                Boxicons.bxs_joystick,
                color: Colors.white,
                size: 25,
              ),
              icon: Icon(
                Boxicons.bx_joystick,
                color: Color(0xFF4A919E),
                size: 30,
              ),
              label: 'Jeu',
            ),
            NavigationDestination(
              selectedIcon: Image.asset(
                "images/ranking.png",
                width: 30,
                height: 30,
                color: Colors.white,
              ),
              icon: Image.asset(
                "images/award.png",
                width: 30,
                height: 30,
                color: const Color(0xFF4A919E),
              ),
              label: 'Classement',
            ),
            const NavigationDestination(
              selectedIcon: Icon(
                Icons.person,
                color: Colors.white,
                size: 25,
              ),
              icon: Icon(
                Icons.person_outline,
                color: Color(0xFF4A919E),
                size: 30,
              ),
              label: 'Compte',
            ),
          ],
        ),
      ),
      body: <Widget>[
        const FirstScreen(),
         const SecondScreen(),
        const Compte()
      ][currentPageIndex],
    );
  }
  
}

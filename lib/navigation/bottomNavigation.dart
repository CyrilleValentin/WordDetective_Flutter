import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:global_bottom_navigation_bar/global_bottom_navigation_bar.dart';


import '../pages/game.dart';
import '../pages/classement.dart';
import '../pages/compte.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      color: Color(0xFFFFBF66),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGlobalBottomNavigation(
      backgroundColor: const Color(0xFFFFBF66),
      listOfChild: [
        const FirstScreen(),
        const SecondScreen(),
        Compte(),

      ],
      listOfBottomNavigationItem: buildBottomNavigationItemList(),
    );
  }

  List<BottomNavigationItem> buildBottomNavigationItemList() => [
    BottomNavigationItem(

      activeIcon: const Icon(
        Boxicons.bxs_joystick,
        color: Colors.white,
        size: 25,
      ),
      inActiveIcon: const Icon(
        Boxicons.bx_joystick,
        color: Color(0xFF4A919E),
        size: 30,
      ),
      title: 'Jeu',
      color:   const Color(0xFF264653),
      vSync: this,
    ),
    BottomNavigationItem(
      activeIcon: Image.asset("images/ranking.png",
        width: 30,
        height: 30,
        color: Colors.white,
      ),
      inActiveIcon: Image.asset("images/award.png",
        width: 30,
        height: 30,
        color: const Color(0xFF4A919E),

      ),
      title: 'Classement',
      color:   const Color(0xFF264653),
      vSync: this,
    ),
    BottomNavigationItem(
      activeIcon: const Icon(
        Icons.person,
        color: Colors.white,
        size: 25,
      ),
      inActiveIcon: const Icon(
        Icons.person_outline,
        color: Color(0xFF4A919E),
        size: 30,
      ),
      title: 'Profil',
      color:   const Color(0xFF264653),
      vSync: this,
    ),

  ];
}

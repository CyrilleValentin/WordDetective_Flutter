import 'package:flutter/material.dart';
import 'package:global_bottom_navigation_bar/global_bottom_navigation_bar.dart';


import 'main/first_screen.dart';
import 'main/second_screen.dart';
import 'main/third_screen.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      color: Color(0xFFFFBF66),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
        Icons.games_outlined,
        color: Colors.white,
        size: 25,
      ),
      inActiveIcon: const Icon(
        Icons.games,
        color: Color(0xFF4A919E),
        size: 30,
      ),
      title: 'Jeu',
      color:   Color(0xFF264653),
      vSync: this,
    ),
    BottomNavigationItem(
      activeIcon: const Icon(
        Icons.perm_camera_mic,
        color: Colors.white,
        size: 25,
      ),
      inActiveIcon: const Icon(
        Icons.perm_contact_calendar,
        color: Color(0xFF4A919E),
        size: 30,
      ),
      title: 'Classement',
      color:   Color(0xFF264653),
      vSync: this,
    ),
    BottomNavigationItem(
      activeIcon: Icon(
        Icons.person,
        color: Colors.white,
        size: 25,
      ),
      inActiveIcon: Icon(
        Icons.person_outline,
        color: Color(0xFF4A919E),
        size: 30,
      ),
      title: 'Profil',
      color:   Color(0xFF264653),
      vSync: this,
    ),

  ];
}

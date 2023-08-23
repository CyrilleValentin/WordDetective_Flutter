import 'package:flutter/material.dart';
import 'package:global_bottom_navigation_bar/global_bottom_navigation_bar.dart';


import 'main/first_screen.dart';
import 'main/second_screen.dart';
import 'main/third_screen.dart';



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGlobalBottomNavigation(
      backgroundColor: const Color(0xFFBEDC3C),
      listOfChild: [
        FirstScreen(),
        SecondScreen(),
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


import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static final Preferences pref=Preferences._();
  static late SharedPreferences instance;
  Preferences._();
  static Future init()async{
    instance=await SharedPreferences.getInstance();
  }
  void reset (){
    instance.clear();
  }

 
  Future<void>niveau (String niveau)async{
    await instance.setString("niveau", niveau);
  }
  String ? get getNiveau{
    return instance.getString("niveau");
  }
  


   Future<void>login ()async{
    await instance.setBool("login", true);
  } 
  bool ? get getLogin{
    return instance.getBool("login")??false;
  }

  Future<void>logout ()async{
    await instance.setBool("login", false);
  } 
  bool ? get getLogout{
    return instance.getBool("login")??false;
  }



   Future<void>token (String token)async{
    await instance.setString("token", token);
  }
  String?  get getToken{
    return instance.getString("token");
  }

   Future<void>name (String name)async{
    await instance.setString("name", name);
  }
  String?  get getName{
    return instance.getString("name");
  }

  Future<void>email (String email)async{
    await instance.setString("email", email);
  }
  String?  get getEmail{
    return instance.getString("email");
  }

  Future<void>score (int score)async{
    await instance.setInt("score", score);
  }
  int?  get getScore{
    return instance.getInt("score");
  }

 Future<void> saveUsers(List<Map<String, dynamic>> users) async {
  final prefs = await SharedPreferences.getInstance();
  final userList = users.map((user) => jsonEncode(user)).toList();
  await prefs.setStringList('users', userList);
}
Future<List> getUsers() async {
  final prefs = await SharedPreferences.getInstance();
  final userList = prefs.getStringList('users') ?? [];
  return userList.map((user) => jsonDecode(user)).toList();
}

}
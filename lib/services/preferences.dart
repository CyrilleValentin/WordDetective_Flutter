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
}
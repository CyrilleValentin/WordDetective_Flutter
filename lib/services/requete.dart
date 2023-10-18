import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:word_detective/pages/constants/strings.dart';
import 'package:word_detective/services/preferences.dart';

final pref = Preferences.pref;

Future<String> apiRegister(
    String name, String email, String password, String confpassword) async {
  final response =
      await http.post(Uri.parse('http://$ip/api/auth/register'), body: {
    "name": name,
    "email": email,
    "password": password,
    "password_confirmation": confpassword,
  });
  String jsonResponse = response.body;
  Map<String, dynamic> data = jsonDecode(jsonResponse);
  String message = data['message'];
  if (response.statusCode == 200) {
    return 'true';
  } else if (response.statusCode == 401) {
    return message;
  } else {
    return 'false';
  }
}

Future<String> apiLogin(String email, String password) async {
  final response =
      await http.post(Uri.parse('http://$ip/api/auth/login'), body: {
    "email": email,
    "password": password,
  });
  String jsonResponse = response.body;
  Map<String, dynamic> data = jsonDecode(jsonResponse);
  String message = data['message'];
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    final token = responseJson['token'];
    pref.token(token);
    return 'true';
  } else if (response.statusCode == 401) {
    return message;
  } else {
    return 'false';
  }
}

Future<bool> apiLogout(String token) async {
  final response = await http.delete(
    Uri.parse('http://$ip/api/auth/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  print(token);
  print(response.body);
  
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> apiProfile(String token) async {
  try {
    final response = await http.get(
      Uri.parse('http://$ip/api/auth/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final userProfile = json.decode(response.body)['data'];
      pref.name(userProfile['name']);
      pref.email(userProfile['email']);
      pref.score(userProfile['score']);
      
      return true; // Succès, retourne true
    } else {
      return false; // Échec, retourne false
    }
  } catch (e) {
    // ignore: avoid_print
    print('Une erreur s\'est produite : $e');
    return false; // En cas d'erreur, retourne false
  }
}


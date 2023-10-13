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
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> apiProfile(String token) async {
final response = await http.get(
  Uri.parse('http://votre-api.com/profile'),
  headers: {
    'Authorization': 'Bearer $token',
  },
);

if (response.statusCode == 200) {
  final userProfile = json.decode(response.body)['user'];
  print(userProfile);
  return true;
  // Faites quelque chose avec les données du profil
} else {
  return false;
}

}

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> apiRegister(
    String name, String email, String password, String confpassword) async {
  final response = await http
      .post(Uri.parse('http://192.168.137.2:8000/api/auth/register'), body: {
    "name": name,
    "email": email,
    "password": password,
    "password_confirmation": confpassword,
  });
  // Supposons que response contient la réponse JSON de l'API
  String jsonResponse = response.body; // C'est la chaîne JSON de la réponse

// Utilisez json.decode pour décoder la chaîne JSON en un objet Dart (Map)
  Map<String, dynamic> data = jsonDecode(jsonResponse);

// Récupérez le contenu du message
  String message = data['message'];

  if (response.statusCode == 200) {
    // La requête a réussi, vous pouvez traiter la réponse ici
    return 'true';
  } else if (response.statusCode == 401) {
    return message;
  } else {
    // La requête a échoué, vous pouvez gérer les erreurs ici
    return 'false';
  }
}

Future<String> apiLogin(String email, String password) async {
  final response = await http
      .post(Uri.parse('http://192.168.137.2:8000/api/auth/login'), body: {
    "email": email,
    "password": password,
  });
  // Supposons que response contient la réponse JSON de l'API
  String jsonResponse = response.body; // C'est la chaîne JSON de la réponse
  print(response.body);
// Utilisez json.decode pour décoder la chaîne JSON en un objet Dart (Map)
  Map<String, dynamic> data = jsonDecode(jsonResponse);

// Récupérez le contenu du message
  String message = data['message'];

  if (response.statusCode == 200) {
    // La requête a réussi, vous pouvez traiter la réponse ici
    return 'true';
  } else if (response.statusCode == 401) {
    return message;
  } else {
    // La requête a échoué, vous pouvez gérer les erreurs ici
    return 'false';
  }
}

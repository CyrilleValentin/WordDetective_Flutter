import 'dart:convert';

class User {
  int id;
  String name;
  String email;
  int score;

  User(
      {required this.id, required this.name,required this.email, required this.score});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"], name: json["name"], email: json["email"],score: json["score"]);
  }

  toJson() => {"id": id, "name": name,"email": email,"score": score};

  @override
  String toString() {
    return jsonDecode(toJson());
  }
}
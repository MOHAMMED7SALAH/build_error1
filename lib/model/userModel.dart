// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.message,
    this.user,
    this.token,
  });

  String message;
  User user;

  String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"] == null ? null : json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "user": user == null ? null : user.toJson(),
        "token": token == null ? null : token,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.points,
  });

  String id;
  String name;
  String email;
  String phone;
  String points;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        points: json["ads_points"] == null ? "0" : json["ads_points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "ads_points": points == null ? "0" : points,
      };
}

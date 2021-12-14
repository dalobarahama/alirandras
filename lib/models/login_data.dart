// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.status,
    this.status_code,
    this.message,
    this.user,
    this.token,
  });

  String? status;
  int? status_code;
  String? message;
  User1? user;
  String? token;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        status: json["status"],
        status_code: json["status_code"],
        message: json["message"],
        user: User1.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": status_code,
        "message": message,
        "user": user!.toJson(),
        "token": token,
      };
}

User1 userFromJson(String str) => User1.fromJson(json.decode(str));

String userToJson(User1 data) => json.encode(data.toJson());

class User1 {
  User1({
    this.id,
    this.name,
    this.app,
    this.email,
    this.emailVerifiedAt,
    this.signature,
    this.avatar,
    this.resetToken,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? app;
  String? email;
  dynamic? emailVerifiedAt;
  String? signature;
  String? avatar;
  dynamic? resetToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User1.fromJson(Map<String, dynamic> json) => User1(
        id: json["id"],
        name: json["name"],
        app: json["app"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        signature: json["signature"],
        avatar: json["avatar"],
        resetToken: json["reset_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "app": app,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "signature": signature,
        "avatar": avatar,
        "reset_token": resetToken,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

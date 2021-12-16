// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));

String loginDataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.status,
    this.statusCode,
    this.message,
    this.user,
    this.token,
  });

  String? status;
  dynamic statusCode;
  String? message;
  User1? user;
  String? token;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        user: json["user"] == null ? null : User1.fromJson(json["user"]),
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "user": user == null ? null : user!.toJson(),
        "token": token == null ? null : token,
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
    this.position,
    this.resetToken,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? app;
  String? email;
  DateTime? emailVerifiedAt;
  String? signature;
  String? avatar;
  dynamic position;
  dynamic resetToken;
  String? fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User1.fromJson(Map<String, dynamic> json) => User1(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        app: json["app"] == null ? null : json["app"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        signature: json["signature"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        position: json["position"],
        resetToken: json["reset_token"],
        fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "app": app == null ? null : app,
        "email": email == null ? null : email,
        "email_verified_at":
            emailVerifiedAt == null ? null : emailVerifiedAt!.toIso8601String(),
        "signature": signature,
        "avatar": avatar == null ? null : avatar,
        "position": position,
        "reset_token": resetToken,
        "fcm_token": fcmToken == null ? null : fcmToken,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

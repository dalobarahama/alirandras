// To parse this JSON data, do
//
//     final registerData = registerDataFromJson(jsonString);

import 'dart:convert';

RegisterData registerDataFromJson(String str) =>
    RegisterData.fromJson(json.decode(str));

String registerDataToJson(RegisterData data) => json.encode(data.toJson());

class RegisterData {
  RegisterData({
    this.userr,
    this.status,
    this.statusCode,
    this.message,
  });

  Userr? userr;
  String? status;
  dynamic statusCode;
  String? message;

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        userr: Userr.fromJson(json["user"]),
        status: json["status"],
        statusCode: json["status_code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user": userr!.toJson(),
        "status": status,
        "status_code": statusCode,
        "message": message,
      };
}

Userr userrFromJson(String str) => Userr.fromJson(json.decode(str));

String userrToJson(Userr data) => json.encode(data.toJson());

class Userr {
  Userr({
    this.app,
    this.name,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? app;
  String? name;
  String? email;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Userr.fromJson(Map<String, dynamic> json) => Userr(
        app: json["app"],
        name: json["name"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "app": app,
        "name": name,
        "email": email,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}

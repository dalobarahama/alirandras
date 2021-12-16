// To parse this JSON data, do
//
//     final settingPengajuanModel = settingPengajuanModelFromJson(jsonString);

import 'dart:convert';

SettingPengajuanModel settingPengajuanModelFromJson(String str) =>
    SettingPengajuanModel.fromJson(json.decode(str));

String settingPengajuanModelToJson(SettingPengajuanModel data) =>
    json.encode(data.toJson());

class SettingPengajuanModel {
  SettingPengajuanModel({
    this.status,
    this.statusCode,
    this.message,
    this.settings,
  });

  String? status;
  int? statusCode;
  String? message;
  List<SettingPengajuanData>? settings;

  factory SettingPengajuanModel.fromJson(Map<String, dynamic> json) =>
      SettingPengajuanModel(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        settings: json["settings"] == null
            ? null
            : List<SettingPengajuanData>.from(
                json["settings"].map((x) => SettingPengajuanData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "settings": settings == null
            ? null
            : List<dynamic>.from(settings!.map((x) => x.toJson())),
      };
}

class SettingPengajuanData {
  SettingPengajuanData({
    this.id,
    this.userId,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  int? level;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory SettingPengajuanData.fromJson(Map<String, dynamic> json) =>
      SettingPengajuanData(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        level: json["level"] == null ? null : json["level"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "level": level == null ? null : level,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "user": user == null ? null : user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.app,
    this.email,
    this.emailVerifiedAt,
    this.signature,
    this.avatar,
    this.position,
    this.resetToken,
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
  String? position;
  dynamic resetToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        app: json["app"] == null ? null : json["app"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        signature: json["signature"] == null ? null : json["signature"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        position: json["position"] == null ? null : json["position"],
        resetToken: json["reset_token"],
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
        "signature": signature == null ? null : signature,
        "avatar": avatar == null ? null : avatar,
        "position": position == null ? null : position,
        "reset_token": resetToken,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final settingPengajuanListSettingUser = settingPengajuanListUserFromJson(jsonString);

import 'dart:convert';

SettingPengajuanListUser settingPengajuanListUserFromJson(String str) =>
    SettingPengajuanListUser.fromJson(json.decode(str));

String settingPengajuanListUserToJson(SettingPengajuanListUser data) =>
    json.encode(data.toJson());

class SettingPengajuanListUser {
  SettingPengajuanListUser({
    this.status,
    this.statusCode,
    this.message,
    this.users,
  });

  String? status;
  int? statusCode;
  String? message;
  List<SettingUser>? users;

  factory SettingPengajuanListUser.fromJson(Map<String, dynamic> json) =>
      SettingPengajuanListUser(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        users: json["users"] == null
            ? null
            : List<SettingUser>.from(
                json["users"].map((x) => SettingUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "users": users == null
            ? null
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class SettingUser {
  SettingUser({
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
  String? position;
  dynamic resetToken;
  String? fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SettingUser.fromJson(Map<String, dynamic> json) => SettingUser(
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
        "signature": signature == null ? null : signature,
        "avatar": avatar == null ? null : avatar,
        "position": position == null ? null : position,
        "reset_token": resetToken,
        "fcm_token": fcmToken == null ? null : fcmToken,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

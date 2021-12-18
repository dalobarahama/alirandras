// To parse this JSON data, do
//
//     final updateProfileReturn = updateProfileReturnFromJson(jsonString);

import 'dart:convert';

UpdateProfileReturn updateProfileReturnFromJson(String str) => UpdateProfileReturn.fromJson(json.decode(str));

String updateProfileReturnToJson(UpdateProfileReturn data) => json.encode(data.toJson());

class UpdateProfileReturn {
    UpdateProfileReturn({
        this.user,
        this.status,
        this.statusCode,
        this.message,
    });

    UpdateUser? user;
    String? status;
    String? statusCode;
    String? message;

    factory UpdateProfileReturn.fromJson(Map<String, dynamic> json) => UpdateProfileReturn(
        user: json["user"] == null ? null : UpdateUser.fromJson(json["user"]),
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
    };
}
String updateUserToJson(UpdateUser data) => json.encode(data.toJson());

class UpdateUser {
    UpdateUser({
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
    dynamic emailVerifiedAt;
    dynamic signature;
    dynamic avatar;
    dynamic position;
    dynamic resetToken;
    dynamic fcmToken;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        app: json["app"] == null ? null : json["app"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        signature: json["signature"],
        avatar: json["avatar"],
        position: json["position"],
        resetToken: json["reset_token"],
        fcmToken: json["fcm_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "app": app == null ? null : app,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "signature": signature,
        "avatar": avatar,
        "position": position,
        "reset_token": resetToken,
        "fcm_token": fcmToken,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}

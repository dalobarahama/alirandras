// To parse this JSON data, do
//
//     final notifModel = notifModelFromJson(jsonString);

import 'dart:convert';

NotifModel notifModelFromJson(String str) => NotifModel.fromJson(json.decode(str));

String notifModelToJson(NotifModel data) => json.encode(data.toJson());

class NotifModel {
    NotifModel({
        this.notifications,
        this.status,
        this.statusCode,
        this.message,
    });

    List<NotificationData>? notifications;
    String? status;
    String? statusCode;
    String? message;

    factory NotifModel.fromJson(Map<String, dynamic> json) => NotifModel(
        notifications: json["notifications"] == null ? null : List<NotificationData>.from(json["notifications"].map((x) => NotificationData.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "notifications": notifications == null ? null : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
    };
}

class NotificationData {
    NotificationData({
        this.id,
        this.userId,
        this.title,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    int? userId;
    String? title;
    String? status;
    DateTime? createdAt;
    dynamic updatedAt;

    factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        title: json["title"] == null ? null : json["title"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "title": title == null ? null : title,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt,
    };
}

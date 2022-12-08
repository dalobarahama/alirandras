// To parse this JSON data, do
//
//     final updateProfileReturn = updateProfileReturnFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_application_3/models/login_data.dart';

UpdateProfileReturn updateProfileReturnFromJson(String str) =>
    UpdateProfileReturn.fromJson(json.decode(str));

String updateProfileReturnToJson(UpdateProfileReturn data) =>
    json.encode(data.toJson());

class UpdateProfileReturn {
  UpdateProfileReturn({
    this.user,
    this.status,
    this.statusCode,
    this.message,
  });

  User1? user;
  String? status;
  String? statusCode;
  String? message;

  factory UpdateProfileReturn.fromJson(Map<String, dynamic> json) =>
      UpdateProfileReturn(
        user: json["user"] == null ? null : User1.fromJson(json["user"]),
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

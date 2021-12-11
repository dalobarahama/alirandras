// To parse this JSON data, do
//
//     final listPengajuan = listPengajuanFromJson(jsonString);

import 'dart:convert';

ListPengajuan listPengajuanFromJson(String str) =>
    ListPengajuan.fromJson(json.decode(str));

String listPengajuanToJson(ListPengajuan data) => json.encode(data.toJson());

class ListPengajuan {
  ListPengajuan({
    this.status,
    this.statusCode,
    this.message,
    this.registrationForms,
  });

  String? status;
  int? statusCode;
  String? message;
  List<RegistrationForm1>? registrationForms;

  factory ListPengajuan.fromJson(Map<String, dynamic> json) => ListPengajuan(
        status: json["status"],
        statusCode: json["status_code"],
        message: json["message"],
        registrationForms: List<RegistrationForm1>.from(
            json["registration_forms"]
                .map((x) => RegistrationForm1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "message": message,
        "registration_forms":
            List<dynamic>.from(registrationForms!.map((x) => x.toJson())),
      };
}

class RegistrationForm1 {
  RegistrationForm1({
    this.id,
    this.userId,
    this.type,
    this.district,
    this.subdistrict,
    this.buildingArea,
    this.landArea,
    this.buildingLocation,
    this.completeAddress,
    this.lat,
    this.lng,
    this.status,
    this.reasonRejection,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.registrationFormAttachments,
    this.mailRequest,
  });

  int? id;
  int? userId;
  String? type;
  String? district;
  String? subdistrict;
  String? buildingArea;
  String? landArea;
  String? buildingLocation;
  String? completeAddress;
  double? lat;
  double? lng;
  String? status;
  String? reasonRejection;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  List<RegistrationFormAttachment>? registrationFormAttachments;
  MailRequest? mailRequest;

  factory RegistrationForm1.fromJson(Map<String, dynamic> json) =>
      RegistrationForm1(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        district: json["district"],
        subdistrict: json["subdistrict"],
        buildingArea: json["building_area"],
        landArea: json["land_area"],
        buildingLocation: json["building_location"],
        completeAddress: json["complete_address"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        status: json["status"],
        reasonRejection: json["reason_rejection"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        registrationFormAttachments: List<RegistrationFormAttachment>.from(
            json["registration_form_attachments"]
                .map((x) => RegistrationFormAttachment.fromJson(x))),
        mailRequest: MailRequest.fromJson(json["mail_request"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "district": district,
        "subdistrict": subdistrict,
        "building_area": buildingArea,
        "land_area": landArea,
        "building_location": buildingLocation,
        "complete_address": completeAddress,
        "lat": lat,
        "lng": lng,
        "status": status,
        "reason_rejection": reasonRejection,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
        "registration_form_attachments": List<dynamic>.from(
            registrationFormAttachments!.map((x) => x.toJson())),
        "mail_request": mailRequest!.toJson(),
      };

  void add(List<RegistrationForm1> temporary) {}
}

class MailRequest {
  MailRequest({
    this.id,
    this.registrationFormId,
    this.userId,
    this.letterNumber,
    this.body,
    this.status,
    this.reasonRejection,
    this.createdAt,
    this.updatedAt,
    this.mailPermissions,
  });

  int? id;
  int? registrationFormId;
  dynamic userId;
  dynamic letterNumber;
  dynamic body;
  String? status;
  dynamic reasonRejection;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<MailPermission>? mailPermissions;

  factory MailRequest.fromJson(Map<String, dynamic> json) => MailRequest(
        id: json["id"],
        registrationFormId: json["registration_form_id"],
        userId: json["user_id"],
        letterNumber: json["letter_number"],
        body: json["body"],
        status: json["status"],
        reasonRejection: json["reason_rejection"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mailPermissions: List<MailPermission>.from(
            json["mail_permissions"].map((x) => MailPermission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "registration_form_id": registrationFormId,
        "user_id": userId,
        "letter_number": letterNumber,
        "body": body,
        "status": status,
        "reason_rejection": reasonRejection,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "mail_permissions":
            List<dynamic>.from(mailPermissions!.map((x) => x.toJson())),
      };
}

class MailPermission {
  MailPermission({
    this.id,
    this.userId,
    this.mailRequestId,
    this.level,
    this.reasonRejection,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  int? mailRequestId;
  int? level;
  dynamic reasonRejection;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  factory MailPermission.fromJson(Map<String, dynamic> json) => MailPermission(
        id: json["id"],
        userId: json["user_id"],
        mailRequestId: json["mail_request_id"],
        level: json["level"],
        reasonRejection: json["reason_rejection"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "mail_request_id": mailRequestId,
        "level": level,
        "reason_rejection": reasonRejection,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "user": user!.toJson(),
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
  dynamic resetToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        app: json["app"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        signature: json["signature"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        resetToken: json["reset_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "app": app,
        "email": email,
        "email_verified_at":
            emailVerifiedAt == null ? null : emailVerifiedAt!.toIso8601String(),
        "signature": signature,
        "avatar": avatar == null ? null : avatar,
        "reset_token": resetToken,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class RegistrationFormAttachment {
  RegistrationFormAttachment({
    this.id,
    this.registrationFormId,
    this.file,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? registrationFormId;
  String? file;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory RegistrationFormAttachment.fromJson(Map<String, dynamic> json) =>
      RegistrationFormAttachment(
        id: json["id"],
        registrationFormId: json["registration_form_id"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "registration_form_id": registrationFormId,
        "file": file,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

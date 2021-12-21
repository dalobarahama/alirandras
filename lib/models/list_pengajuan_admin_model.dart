// To parse this JSON data, do
//
//     final listPengajuanHomeModel = listPengajuanHomeModelFromJson(jsonString);

import 'dart:convert';

ListPengajuanHomeModel listPengajuanHomeModelFromJson(String str) =>
    ListPengajuanHomeModel.fromJson(json.decode(str));

String listPengajuanHomeModelToJson(ListPengajuanHomeModel data) =>
    json.encode(data.toJson());

class ListPengajuanHomeModel {
  ListPengajuanHomeModel({
    this.status,
    this.statusCode,
    this.message,
    this.registrationForms,
  });

  String? status;
  int? statusCode;
  String? message;
  List<RegistrationForm>? registrationForms;

  factory ListPengajuanHomeModel.fromJson(Map<String, dynamic> json) =>
      ListPengajuanHomeModel(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        registrationForms: json["registration_forms"] == null
            ? null
            : List<RegistrationForm>.from(json["registration_forms"]
                .map((x) => RegistrationForm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "registration_forms": registrationForms == null
            ? null
            : List<dynamic>.from(registrationForms!.map((x) => x.toJson())),
      };
}

class RegistrationForm {
  RegistrationForm({
    this.id,
    this.userId,
    this.type,
    this.district,
    this.subdistrict,
    this.buildingArea,
    this.landArea,
    this.buildingLocation,
    this.completeAddress,
    this.buildingDesignation,
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
  String? buildingDesignation;
  double? lat;
  double? lng;
  String? status;
  String? reasonRejection;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  List<RegistrationFormAttachment>? registrationFormAttachments;
  MailRequest? mailRequest;

  factory RegistrationForm.fromJson(Map<String, dynamic> json) =>
      RegistrationForm(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        type: json["type"] == null ? null : json["type"],
        district: json["district"] == null ? null : json["district"],
        subdistrict: json["subdistrict"] == null ? null : json["subdistrict"],
        buildingArea:
            json["building_area"] == null ? null : json["building_area"],
        landArea: json["land_area"] == null ? null : json["land_area"],
        buildingLocation: json["building_location"] == null
            ? null
            : json["building_location"],
        completeAddress:
            json["complete_address"] == null ? null : json["complete_address"],
        buildingDesignation: json["building_designation"] == null
            ? null
            : json["building_designation"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
        status: json["status"] == null ? null : json["status"],
        reasonRejection:
            json["reason_rejection"] == null ? null : json["reason_rejection"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        registrationFormAttachments:
            json["registration_form_attachments"] == null
                ? null
                : List<RegistrationFormAttachment>.from(
                    json["registration_form_attachments"]
                        .map((x) => RegistrationFormAttachment.fromJson(x))),
        mailRequest: json["mail_request"] == null
            ? null
            : MailRequest.fromJson(json["mail_request"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "type": type == null ? null : type,
        "district": district == null ? null : district,
        "subdistrict": subdistrict == null ? null : subdistrict,
        "building_area": buildingArea == null ? null : buildingArea,
        "land_area": landArea == null ? null : landArea,
        "building_location": buildingLocation == null ? null : buildingLocation,
        "complete_address": completeAddress == null ? null : completeAddress,
        "building_designation":
            buildingDesignation == null ? null : buildingDesignation,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "status": status == null ? null : status,
        "reason_rejection": reasonRejection == null ? null : reasonRejection,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "user": user == null ? null : user!.toJson(),
        "registration_form_attachments": registrationFormAttachments == null
            ? null
            : List<dynamic>.from(
                registrationFormAttachments!.map((x) => x.toJson())),
        "mail_request": mailRequest == null ? null : mailRequest!.toJson(),
      };
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
        id: json["id"] == null ? null : json["id"],
        registrationFormId: json["registration_form_id"] == null
            ? null
            : json["registration_form_id"],
        userId: json["user_id"],
        letterNumber: json["letter_number"],
        body: json["body"],
        status: json["status"] == null ? null : json["status"],
        reasonRejection: json["reason_rejection"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        mailPermissions: json["mail_permissions"] == null
            ? null
            : List<MailPermission>.from(json["mail_permissions"]
                .map((x) => MailPermission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "registration_form_id":
            registrationFormId == null ? null : registrationFormId,
        "user_id": userId,
        "letter_number": letterNumber,
        "body": body,
        "status": status == null ? null : status,
        "reason_rejection": reasonRejection,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "mail_permissions": mailPermissions == null
            ? null
            : List<dynamic>.from(mailPermissions!.map((x) => x.toJson())),
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
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        mailRequestId:
            json["mail_request_id"] == null ? null : json["mail_request_id"],
        level: json["level"] == null ? null : json["level"],
        reasonRejection: json["reason_rejection"],
        status: json["status"] == null ? null : json["status"],
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
        "mail_request_id": mailRequestId == null ? null : mailRequestId,
        "level": level == null ? null : level,
        "reason_rejection": reasonRejection,
        "status": status == null ? null : status,
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
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        app: json["app"] == null ? null : json["app"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        signature: json["signature"] == null ? null : json["signature"],
        avatar: json["avatar"] == null ? null : json["avatar"],
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
        "reset_token": resetToken,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
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
        id: json["id"] == null ? null : json["id"],
        registrationFormId: json["registration_form_id"] == null
            ? null
            : json["registration_form_id"],
        file: json["file"] == null ? null : json["file"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "registration_form_id":
            registrationFormId == null ? null : registrationFormId,
        "file": file == null ? null : file,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

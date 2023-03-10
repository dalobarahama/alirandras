// To parse this JSON data, do
//
//     final adminHomeModel = adminHomeModelFromJson(jsonString);

import 'dart:convert';

import 'setting_pengajuan.dart';

AdminHomeModel adminHomeModelFromJson(String str) =>
    AdminHomeModel.fromJson(json.decode(str));

class AdminHomeModel {
  AdminHomeModel({
    this.status,
    this.statusCode,
    this.message,
    this.registrationForms,
    this.suratMasuk,
    this.suratDiproses,
  });

  String? status;
  int? statusCode;
  String? message;
  List<RegistrationForm2>? registrationForms;
  int? suratMasuk;
  int? suratDiproses;

  factory AdminHomeModel.fromJson(Map<String, dynamic> json) => AdminHomeModel(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        registrationForms: json["registration_forms"] == null
            ? null
            : List<RegistrationForm2>.from(json["registration_forms"]
                .map((x) => RegistrationForm2.fromJson(x))),
        suratMasuk: json["surat_masuk"] == null ? null : json["surat_masuk"],
        suratDiproses:
            json["surat_diproses"] == null ? null : json["surat_diproses"],
      );
}

class RegistrationForm2 {
  RegistrationForm2({
    this.id,
    this.userId,
    this.type,
    this.noPhone,
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
    this.registrationFormDocuments,
    this.mailRequest,
  });

  int? id;
  int? userId;
  String? type;
  String? noPhone;
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
  List<RegistrationFormDocuments>? registrationFormDocuments;
  MailRequest? mailRequest;

  factory RegistrationForm2.fromJson(Map<String, dynamic> json) =>
      RegistrationForm2(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        type: json["type"] == null ? null : json["type"],
        noPhone: json["no_phone"] == null ? null : json["no_phone"],
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
        registrationFormDocuments: json["registration_form_documents"] == null
            ? null
            : List<RegistrationFormDocuments>.from(
                json["registration_form_documents"]
                    .map((x) => RegistrationFormDocuments.fromJson(x))),
        mailRequest: json["mail_request"] == null
            ? null
            : MailRequest.fromJson(json["mail_request"]),
      );
}

class MailRequest {
  MailRequest(
      {this.id,
      this.registrationFormId,
      this.userId,
      this.letterNumber,
      this.body,
      this.status,
      this.reasonRejection,
      this.createdAt,
      this.updatedAt,
      this.mailPermissions,
      this.checkMailPermission});

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
  CheckMailPermission? checkMailPermission;

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
        checkMailPermission: json["check_mail_permission"] == null
            ? null
            : CheckMailPermission.fromJson(json["check_mail_permission"]),
        mailPermissions: json["mail_permissions"] == null
            ? null
            : List<MailPermission>.from(json["mail_permissions"]
                .map((x) => MailPermission.fromJson(x))),
      );
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
}

class RegistrationFormDocuments {
  RegistrationFormDocuments({
    this.id,
    this.registrationFormId,
    this.document,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? registrationFormId;
  String? document;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory RegistrationFormDocuments.fromJson(Map<String, dynamic> json) =>
      RegistrationFormDocuments(
        id: json["id"] == null ? null : json["id"],
        registrationFormId: json["registration_form_id"] == null
            ? null
            : json["registration_form_id"],
        document: json["document"] == null ? null : json["document"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}

class CheckMailPermission {
  CheckMailPermission({
    this.id,
    this.userId,
    this.mailRequestId,
    this.level,
    this.reasonRejection,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? mailRequestId;
  int? level;
  dynamic reasonRejection;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CheckMailPermission.fromJson(Map<String, dynamic> json) =>
      CheckMailPermission(
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
      };
}

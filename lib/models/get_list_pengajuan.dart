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
    this.applicationLetters1,
  });

  String? status;
  int? statusCode;
  String? message;
  List<ApplicationLetter1>? applicationLetters1;

  factory ListPengajuan.fromJson(Map<String, dynamic> json) => ListPengajuan(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        applicationLetters1: json["application_letters"] == null
            ? null
            : List<ApplicationLetter1>.from(json["application_letters"]
                .map((x) => ApplicationLetter1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "application_letters": applicationLetters1 == null
            ? null
            : List<dynamic>.from(applicationLetters1!.map((x) => x.toJson())),
      };
}

class ApplicationLetter1 {
  ApplicationLetter1({
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
    this.registrationFormDocuments,
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
  dynamic completeAddress;
  String? buildingDesignation;
  double? lat;
  double? lng;
  String? status;
  dynamic reasonRejection;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  List<RegistrationFormAttachment>? registrationFormAttachments;
  List<RegistrationFormDocument>? registrationFormDocuments;
  MailRequest? mailRequest;

  factory ApplicationLetter1.fromJson(Map<String, dynamic> json) =>
      ApplicationLetter1(
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
        completeAddress: json["complete_address"],
        buildingDesignation: json["building_designation"] == null
            ? null
            : json["building_designation"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
        status: json["status"] == null ? null : json["status"],
        reasonRejection: json["reason_rejection"],
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
            : List<RegistrationFormDocument>.from(
                json["registration_form_documents"]
                    .map((x) => RegistrationFormDocument.fromJson(x))),
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
        "complete_address": completeAddress,
        "building_designation": buildingDesignation,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "status": status == null ? null : status,
        "reason_rejection": reasonRejection,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "user": user == null ? null : user!.toJson(),
        "registration_form_attachments": registrationFormAttachments == null
            ? null
            : List<dynamic>.from(
                registrationFormAttachments!.map((x) => x.toJson())),
        "registration_form_documents": registrationFormDocuments == null
            ? null
            : List<dynamic>.from(
                registrationFormDocuments!.map((x) => x.toJson())),
        "mail_request": mailRequest == null ? null : mailRequest!.toJson(),
      };

  void add(List<ApplicationLetter1> temporary) {}
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

class RegistrationFormDocument {
  RegistrationFormDocument({
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

  factory RegistrationFormDocument.fromJson(Map<String, dynamic> json) =>
      RegistrationFormDocument(
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

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "registration_form_id":
            registrationFormId == null ? null : registrationFormId,
        "document": document == null ? null : document,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
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
  String? position;
  dynamic resetToken;
  dynamic fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        app: json["app"] == null ? null : json["app"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        signature: json["signature"],
        avatar: json["avatar"],
        position: json["position"] == null ? null : json["position"],
        resetToken: json["reset_token"],
        fcmToken: json["fcm_token"],
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
        "email_verified_at": emailVerifiedAt,
        "signature": signature,
        "avatar": avatar,
        "position": position == null ? null : position,
        "reset_token": resetToken,
        "fcm_token": fcmToken,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

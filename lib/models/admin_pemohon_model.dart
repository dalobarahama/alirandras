// To parse this JSON data, do
//
//     final getListPemohon = getListPemohonFromJson(jsonString);

import 'dart:convert';

GetListPemohon getListPemohonFromJson(String str) =>
    GetListPemohon.fromJson(json.decode(str));

String getListPemohonToJson(GetListPemohon data) => json.encode(data.toJson());

class GetListPemohon {
  GetListPemohon({
    this.status,
    this.statusCode,
    this.message,
    this.applicationLetters,
  });

  String? status;
  int? statusCode;
  String? message;
  List<ApplicationLetter>? applicationLetters;

  factory GetListPemohon.fromJson(Map<String, dynamic> json) => GetListPemohon(
        status: json["status"] == null ? null : json["status"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        applicationLetters: json["application_letters"] == null
            ? null
            : List<ApplicationLetter>.from(json["application_letters"]
                .map((x) => ApplicationLetter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "application_letters": applicationLetters == null
            ? null
            : List<dynamic>.from(applicationLetters!.map((x) => x.toJson())),
      };
}

class ApplicationLetter {
  ApplicationLetter({
    this.id,
    this.userId,
    this.type,
    this.district,
    this.subdistrict,
    this.buildingArea,
    this.landArea,
    this.buildingLocation,
    this.buildingDesignation,
    this.completeAddress,
    this.lat,
    this.lng,
    this.status,
    this.reasonRejection,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.registrationFormAttachments,
    this.registrationFormDocuments,
  });

  int? id;
  int? userId;
  String? type;
  String? district;
  String? subdistrict;
  String? buildingArea;
  String? landArea;
  String? buildingLocation;
  String? buildingDesignation;
  dynamic completeAddress;
  double? lat;
  double? lng;
  String? status;
  dynamic reasonRejection;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  List<RegistrationFormMent>? registrationFormAttachments;
  List<RegistrationFormMent>? registrationFormDocuments;

  factory ApplicationLetter.fromJson(Map<String, dynamic> json) =>
      ApplicationLetter(
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
        buildingDesignation: json["building_designation"] == null
            ? null
            : json["building_designation"],
        completeAddress: json["complete_address"],
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
                : List<RegistrationFormMent>.from(
                    json["registration_form_attachments"]
                        .map((x) => RegistrationFormMent.fromJson(x))),
        registrationFormDocuments: json["registration_form_documents"] == null
            ? null
            : List<RegistrationFormMent>.from(
                json["registration_form_documents"]
                    .map((x) => RegistrationFormMent.fromJson(x))),
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
        "building_designation":
            buildingDesignation == null ? null : buildingDesignation,
        "complete_address": completeAddress,
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
      };
}

class RegistrationFormMent {
  RegistrationFormMent({
    this.id,
    this.registrationFormId,
    this.file,
    this.createdAt,
    this.updatedAt,
    this.document,
  });

  int? id;
  int? registrationFormId;
  String? file;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? document;

  factory RegistrationFormMent.fromJson(Map<String, dynamic> json) =>
      RegistrationFormMent(
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
        document: json["document"] == null ? null : json["document"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "registration_form_id":
            registrationFormId == null ? null : registrationFormId,
        "file": file == null ? null : file,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "document": document == null ? null : document,
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
  String? avatar;
  dynamic position;
  dynamic resetToken;
  String? fcmToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        app: json["app"] == null ? null : json["app"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        signature: json["signature"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        position: json["position"],
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
        "email_verified_at": emailVerifiedAt,
        "signature": signature,
        "avatar": avatar == null ? null : avatar,
        "position": position,
        "reset_token": resetToken,
        "fcm_token": fcmToken == null ? null : fcmToken,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

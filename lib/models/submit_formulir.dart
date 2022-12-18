// To parse this JSON data, do
//
//     final submitFormulir = submitFormulirFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

SubmitFormulir submitFormulirFromJson(String str) =>
    SubmitFormulir.fromJson(json.decode(str));

String submitFormulirToJson(SubmitFormulir data) => json.encode(data.toJson());

class SubmitFormulir {
  SubmitFormulir({
    this.status,
    this.statusCode,
    this.message,
    this.registrationForm,
  });

  dynamic status;
  int? statusCode;
  String? message;
  RegistrationForm? registrationForm;

  factory SubmitFormulir.fromJson(Map<String, dynamic> json) => SubmitFormulir(
        status: json["status"],
        statusCode: json["status_code"],
        message: json["message"],
        registrationForm: json["registration_form"] == null
            ? null
            : RegistrationForm.fromJson(json["registration_form"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "message": message,
        "registration_form": registrationForm!.toJson(),
      };

  void clear() {}
}

class RegistrationForm {
  RegistrationForm({
    this.userId,
    this.type,
    this.district,
    this.subdistrict,
    this.buildingArea,
    this.landArea,
    this.buildingLocation,
    this.buildingDesignation,
    this.lat,
    this.lng,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.noPhone,
  });

  int? userId;
  String? type;
  String? district;
  String? subdistrict;
  String? buildingArea;
  String? landArea;
  String? buildingLocation;
  String? buildingDesignation;
  String? lat;
  String? lng;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? noPhone;

  factory RegistrationForm.fromJson(Map<String, dynamic> json) =>
      RegistrationForm(
        userId: json["user_id"],
        type: json["type"],
        district: json["district"],
        subdistrict: json["subdistrict"],
        buildingArea: json["building_area"],
        landArea: json["land_area"],
        buildingLocation: json["building_location"],
        buildingDesignation: json["building_designation"],
        lat: json["lat"],
        lng: json["lng"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        noPhone: json["no_phone"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "type": type,
        "district": district,
        "subdistrict": subdistrict,
        "building_area": buildingArea,
        "land_area": landArea,
        "building_location": buildingLocation,
        "building_designation": buildingDesignation,
        "lat": lat,
        "lng": lng,
        "status": status,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
      };
}

// To parse this JSON data, do
//
//     final getKelurahan = getKelurahanFromJson(jsonString);

import 'dart:convert';

List<GetKelurahan> getKelurahanFromJson(String str) => List<GetKelurahan>.from(
    json.decode(str).map((x) => GetKelurahan.fromJson(x)));

String getKelurahanToJson(List<GetKelurahan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetKelurahan {
  GetKelurahan({
    this.id,
    this.code,
    this.districtCode,
    this.name,
    this.meta,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? code;
  String? districtCode;
  String? name;
  Meta? meta;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetKelurahan.fromJson(Map<String, dynamic> json) => GetKelurahan(
        id: json["id"],
        code: json["code"],
        districtCode: json["district_code"],
        name: json["name"],
        meta: Meta.fromJson(json["meta"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "district_code": districtCode,
        "name": name,
        "meta": meta!.toJson(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Meta {
  Meta({
    this.lat,
    this.long,
  });

  String? lat;
  String? long;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}

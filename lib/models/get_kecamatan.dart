// To parse this JSON data, do
//
//     final getKecamatan = getKecamatanFromJson(jsonString);

import 'dart:convert';

List<GetKecamatan> getKecamatanFromJson(String str) => List<GetKecamatan>.from(
    json.decode(str).map((x) => GetKecamatan.fromJson(x)));

String getKecamatanToJson(List<GetKecamatan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetKecamatan {
  GetKecamatan({
    this.id,
    this.code,
    this.cityCode,
    this.name,
    this.meta,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? code;
  String? cityCode;
  String? name;
  Meta? meta;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetKecamatan.fromJson(Map<String, dynamic> json) => GetKecamatan(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        cityCode: json["city_code"] == null ? null : json["city_code"],
        name: json["name"] == null ? null : json["name"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "city_code": cityCode == null ? null : cityCode,
        "name": name == null ? null : name,
        "meta": meta == null ? null : meta!.toJson(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
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
        lat: json["lat"] == null ? null : json["lat"],
        long: json["long"] == null ? null : json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
      };
}

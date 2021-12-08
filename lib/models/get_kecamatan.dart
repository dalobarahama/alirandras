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

  factory GetKecamatan.fromJson(Map<String, dynamic> json) => GetKecamatan(
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

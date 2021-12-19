// To parse this JSON data, do
//
//     final adminPermission = adminPermissionFromJson(jsonString);

import 'dart:convert';

AdminPermission adminPermissionFromJson(String str) => AdminPermission.fromJson(json.decode(str));

String adminPermissionToJson(AdminPermission data) => json.encode(data.toJson());

class AdminPermission {
    AdminPermission({
        this.settingSuratPengajuan,
        this.manajemenPengguna,
        this.permohonan,
        this.suratPengajuan,
    });

    int? settingSuratPengajuan;
    int? manajemenPengguna;
    int? permohonan;
    int? suratPengajuan;

    factory AdminPermission.fromJson(Map<String, dynamic> json) => AdminPermission(
        settingSuratPengajuan: json["setting_surat_pengajuan"] == null ? null : json["setting_surat_pengajuan"],
        manajemenPengguna: json["manajemen_pengguna"] == null ? null : json["manajemen_pengguna"],
        permohonan: json["permohonan"] == null ? null : json["permohonan"],
        suratPengajuan: json["surat_pengajuan"] == null ? null : json["surat_pengajuan"],
    );

    Map<String, dynamic> toJson() => {
        "setting_surat_pengajuan": settingSuratPengajuan == null ? null : settingSuratPengajuan,
        "manajemen_pengguna": manajemenPengguna == null ? null : manajemenPengguna,
        "permohonan": permohonan == null ? null : permohonan,
        "surat_pengajuan": suratPengajuan == null ? null : suratPengajuan,
    };
}

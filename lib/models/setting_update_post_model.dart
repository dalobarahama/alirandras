// To parse this JSON data, do
//
//     final settingUserPost = settingUserPostFromJson(jsonString);

import 'dart:convert';

SettingUserPost settingUserPostFromJson(String str) => SettingUserPost.fromJson(json.decode(str));

String settingUserPostToJson(SettingUserPost data) => json.encode(data.toJson());

class SettingUserPost {
    SettingUserPost({
        this.userIds,
    });

    List<UserId>? userIds;

    factory SettingUserPost.fromJson(Map<String, dynamic> json) => SettingUserPost(
        userIds: json["user_ids"] == null ? null : List<UserId>.from(json["user_ids"].map((x) => UserId.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user_ids": userIds == null ? null : List<dynamic>.from(userIds!.map((x) => x.toJson())),
    };
}

class UserId {
    UserId({
        this.userId,
    });

    int? userId;

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        userId: json["user_id"] == null ? null : json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
    };
}

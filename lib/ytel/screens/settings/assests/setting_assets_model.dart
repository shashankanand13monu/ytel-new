// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SettingAssetsModel settingAssetsModel(String str) =>
    SettingAssetsModel.fromJson(json.decode(str));

String settingAssetModelToJson(SettingAssetsModel data) =>
    json.encode(data.toJson());

class SettingAssetsModel {
  SettingAssetsModel({
    this.status,
    this.count,
    this.page,
    this.payload,
  });

  bool? status;
  int? count;
  int? page;
  List<Payload>? payload;

  factory SettingAssetsModel.fromJson(Map<String, dynamic> json) =>
      SettingAssetsModel(
        status: json["status"],
        count: json["count"],
        page: json["page"],
        payload:
            List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "count": count,
        "page": page,
        "payload": List<dynamic>.from(payload!.map((x) => x.toJson())),
      };
}

class Payload {
  Payload({
    this.accountSid,
    this.type,
    this.name,
    this.description,
    this.creationDate,
    this.modificationDate,
    this.status,
    this.publicUrl,
    this.duration,
    this.mimeType,
    this.size,
  });

  String? accountSid;
  String? type;
  String? name;
  String? description;
  int? creationDate;
  int? modificationDate;
  int? status;
  String? publicUrl;
  int? duration;
  String? mimeType;
  int? size;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        accountSid: json["accountSid"],
        type: json["type"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        creationDate: json["creationDate"],
        modificationDate: json["modificationDate"],
        status: json["status"],
        publicUrl: json["publicUrl"] == null ? null : json["publicUrl"],
        duration: json["duration"] == null ? null : json["duration"],
        mimeType: json["mimeType"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "accountSid": accountSid,
        "type": type,
        "name": name,
        "description": description == null ? null : description,
        "creationDate": creationDate,
        "modificationDate": modificationDate,
        "status": status,
        "publicUrl": publicUrl == null ? null : publicUrl,
        "duration": duration == null ? null : duration,
        "mimeType": mimeType,
        "size": size,
      };
}

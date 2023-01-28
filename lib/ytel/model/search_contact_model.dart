// To parse this JSON data, do
//
//     final searchContactModel = searchContactModelFromJson(jsonString);

import 'dart:convert';

SearchContactModel searchContactModelFromJson(String str) => SearchContactModel.fromJson(json.decode(str));

String searchContactModelToJson(SearchContactModel data) => json.encode(data.toJson());

class SearchContactModel {
  SearchContactModel({
    this.status,
    this.count,
    this.page,
    this.payload,
  });

  bool? status;
  int? count;
  int? page;
  List<Payload>? payload;

  factory SearchContactModel.fromJson(Map<String, dynamic> json) => SearchContactModel(
    status: json["status"],
    count: json["count"],
    page: json["page"],
    payload: json["payload"] == null ? null : List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "count": count,
    "page": page,
    "payload": payload == null ? null : List<dynamic>.from(payload!.map((x) => x.toJson())),
  };
}

class Payload {
  Payload({
    this.accountSid,
    this.contactId,
    this.created,
    this.dnc,
    this.timezone,
    this.extData,
    this.keys,
    this.lastInbox,
    this.lastMethod,
    this.lastUsed,
  });

  String? accountSid;
  String? contactId;
  String? created;
  int? dnc;
  int? timezone;
  ExtData? extData;
  List<String>? keys;
  String? lastInbox;
  String? lastMethod;
  String? lastUsed;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    accountSid: json["accountSid"],
    contactId: json["contactId"],
    created: json["created"],
    dnc: json["dnc"],
    timezone: json["timezone"],
    extData: json["extData"] == null ? null : ExtData.fromJson(json["extData"]),
    keys: json["keys"] == null ? null : List<String>.from(json["keys"].map((x) => x)),
    lastInbox: json["lastInbox"],
    lastMethod: json["lastMethod"],
    lastUsed: json["lastUsed"],
  );

  Map<String, dynamic> toJson() => {
    "accountSid": accountSid,
    "contactId": contactId,
    "created": created,
    "dnc": dnc,
    "timezone": timezone,
    "extData": extData == null ? null : extData!.toJson(),
    "keys": keys == null ? null : List<dynamic>.from(keys!.map((x) => x)),
    "lastInbox": lastInbox,
    "lastMethod": lastMethod,
    "lastUsed": lastUsed,
  };
}

class ExtData {
  ExtData({
    this.phonenumber1,
  });

  String? phonenumber1;

  factory ExtData.fromJson(Map<String, dynamic> json) => ExtData(
    phonenumber1: json["phonenumber1"],
  );

  Map<String, dynamic> toJson() => {
    "phonenumber1": phonenumber1,
  };
}

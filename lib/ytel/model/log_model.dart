// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SearchLogModel searchLogModelFromJson(String str) =>
    SearchLogModel.fromJson(json.decode(str));

String searchLogModelToJson(SearchLogModel data) => json.encode(data.toJson());

class SearchLogModel {
  SearchLogModel({
    this.status,
    this.count,
    this.page,
    this.payload,
  });

  bool? status;
  int? count;
  int? page;
  List<Payload>? payload;

  factory SearchLogModel.fromJson(Map<String, dynamic> json) => SearchLogModel(
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
        "payload": payload == null
            ? null
            : List<dynamic>.from(payload!.map((x) => x.toJson())),
      };
}

class Payload {
  Payload({
    this.accountSid,
    this.yearMonthDay,
    this.smsSid,
    this.apiVersion,
    this.body,
    this.callbackMethod,
    this.callbackUrl,
    this.direction,
    this.dlrStatus,
    this.errorMessage,
    this.fromCountryCode,
    this.fromCountry,
    this.from,
    this.mediaUrl,
    this.metaData,
    this.numberType,
    this.opt,
    this.paccountSid,
    this.price,
    this.smsCount,
    this.smsType,
    this.status,
    this.surcharge,
    this.termCarrier,
    this.to,
    this.toCountryCode,
    this.toCountry,
    this.useType,
    this.date,
  });

  String? accountSid;
  String? yearMonthDay;
  String? smsSid;
  String? apiVersion;
  String? body;
  String? callbackMethod;
  String? callbackUrl;
  String? direction;
  dynamic? dlrStatus;
  String? errorMessage;
  int? fromCountryCode;
  String? fromCountry;
  String? from;
  String? mediaUrl;
  MetaData? metaData;
  String? numberType;
  dynamic? opt;
  String? paccountSid;
  double? price;
  int? smsCount;
  dynamic? smsType;
  String? status;
  double? surcharge;
  String? termCarrier;
  String? to;
  int? toCountryCode;
  String? toCountry;
  String? useType;
  int? date;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        accountSid: json["accountSid"],
        yearMonthDay: json["yearMonthDay"],
        smsSid: json["smsSid"],
        apiVersion: json["apiVersion"],
        body: json["body"],
        callbackMethod: json["callbackMethod"],
        callbackUrl: json["callbackUrl"] == null ? null : json["callbackUrl"],
        direction: json["direction"],
        dlrStatus: json["dlrStatus"],
        errorMessage:
            json["errorMessage"] == null ? null : json["errorMessage"],
        fromCountryCode: json["fromCountryCode"],
        fromCountry: json["fromCountry"],
        from: json["from"],
        mediaUrl: json["mediaUrl"],
        metaData: MetaData.fromJson(json["metaData"]),
        numberType: json["numberType"],
        opt: json["opt"],
        paccountSid: json["paccountSid"],
        price: json["price"].toDouble(),
        smsCount: json["smsCount"],
        smsType: json["smsType"],
        status: json["status"],
        surcharge: json["surcharge"].toDouble(),
        termCarrier: json["termCarrier"] == null ? null : json["termCarrier"],
        to: json["to"],
        toCountryCode: json["toCountryCode"],
        toCountry: json["toCountry"],
        useType: json["useType"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "accountSid": accountSid,
        "yearMonthDay": yearMonthDay,
        "smsSid": smsSid,
        "apiVersion": apiVersion,
        "body": body,
        "callbackMethod": callbackMethod,
        "callbackUrl": callbackUrl == null ? null : callbackUrl,
        "direction": direction,
        "dlrStatus": dlrStatus,
        "errorMessage": errorMessage == null ? null : errorMessage,
        "fromCountryCode": fromCountryCode,
        "fromCountry": fromCountry,
        "from": from,
        "mediaUrl": mediaUrl,
        "metaData": metaData?.toJson(),
        "numberType": numberType,
        "opt": opt,
        "paccountSid": paccountSid,
        "price": price,
        "smsCount": smsCount,
        "smsType": smsType,
        "status": status,
        "surcharge": surcharge,
        "termCarrier": termCarrier == null ? null : termCarrier,
        "to": to,
        "toCountryCode": toCountryCode,
        "toCountry": toCountry,
        "useType": useType,
        "date": date,
      };
}

class MetaData {
  MetaData({
    this.app,
    this.repliedToMessageTime,
    this.contactId,
    this.origin,
    this.publish,
  });

  String? app;
  String? repliedToMessageTime;
  String? contactId;
  String? origin;
  String? publish;

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        app: json["app"],
        repliedToMessageTime: json["repliedToMessageTime"] == null
            ? null
            : json["repliedToMessageTime"],
        contactId: json["contactId"] == null ? null : json["contactId"],
        origin: json["origin"] == null ? null : json["origin"],
        publish: json["publish"] == null ? null : json["publish"],
      );

  Map<String, dynamic> toJson() => {
        "app": app,
        "repliedToMessageTime":
            repliedToMessageTime == null ? null : repliedToMessageTime,
        "contactId": contactId == null ? null : contactId,
        "origin": origin == null ? null : origin,
        "publish": publish == null ? null : publish,
      };
}

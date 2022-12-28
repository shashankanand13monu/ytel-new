// To parse this JSON data, do
//
//     final numberModel = numberModelFromJson(jsonString);

import 'dart:convert';

NumberModel numberModelFromJson(String str) => NumberModel.fromJson(json.decode(str));

String numberModelToJson(NumberModel data) => json.encode(data.toJson());

class NumberModel {
    NumberModel({
        this.status,
        this.count,
        this.page,
        this.payload,
    });

    bool? status;
    int? count;
    int? page;
    List<Payload>? payload;

    factory NumberModel.fromJson(Map<String, dynamic> json) => NumberModel(
        status: json["status"],
        count: json["count"],
        page: json["page"],
        payload: List<Payload>.from(json["payload"].map((x) => Payload.fromJson(x))),
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
        this.numberSetId,
        this.cnam,
        this.name,
        this.forwardNumber,
        this.callerIdName,
        this.voiceUrl,
        this.voiceMethod,
        this.voiceFallbackUrl,
        this.voiceFallbackMethod,
        this.hangupCallbackUrl,
        this.hangupCallbackMethod,
        this.smsUrl,
        this.smsMethod,
        this.smsFallbackUrl,
        this.smsFallbackMethod,
        this.heartbeatUrl,
        this.heartbeatMethod,
        this.routeTag,
        this.rateConfig,
        this.campaignRegistry,
        this.keywordActions,
    });

    String? accountSid;
    String? numberSetId;
    String? cnam;
    String? name;
    String? forwardNumber;
    String? callerIdName;
    String? voiceUrl;
    Method? voiceMethod;
    String? voiceFallbackUrl;
    Method? voiceFallbackMethod;
    String? hangupCallbackUrl;
    Method? hangupCallbackMethod;
    String? smsUrl;
    Method? smsMethod;
    String? smsFallbackUrl;
    Method? smsFallbackMethod;
    String? heartbeatUrl;
    Method? heartbeatMethod;
    String? routeTag;
    RateConfig? rateConfig;
    String? campaignRegistry;
    Map<String, KeywordAction>? keywordActions;

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        accountSid: json["accountSid"],
        numberSetId: json["numberSetId"],
        cnam: json["cnam"] == null ? null : json["cnam"],
        name: json["name"],
        forwardNumber: json["forwardNumber"] == null ? null : json["forwardNumber"],
        callerIdName: json["callerIdName"] == null ? null : json["callerIdName"],
        voiceUrl: json["voiceUrl"] == null ? null : json["voiceUrl"],
        voiceMethod: json["voiceMethod"] == null ? null : methodValues.map[json["voiceMethod"]],
        voiceFallbackUrl: json["voiceFallbackUrl"] == null ? null : json["voiceFallbackUrl"],
        voiceFallbackMethod: json["voiceFallbackMethod"] == null ? null : methodValues.map[json["voiceFallbackMethod"]],
        hangupCallbackUrl: json["hangupCallbackUrl"] == null ? null : json["hangupCallbackUrl"],
        hangupCallbackMethod: json["hangupCallbackMethod"] == null ? null : methodValues.map[json["hangupCallbackMethod"]],
        smsUrl: json["smsUrl"] == null ? null : json["smsUrl"],
        smsMethod: json["smsMethod"] == null ? null : methodValues.map[json["smsMethod"]],
        smsFallbackUrl: json["smsFallbackUrl"] == null ? null : json["smsFallbackUrl"],
        smsFallbackMethod: json["smsFallbackMethod"] == null ? null : methodValues.map[json["smsFallbackMethod"]],
        heartbeatUrl: json["heartbeatUrl"] == null ? null : json["heartbeatUrl"],
        heartbeatMethod: json["heartbeatMethod"] == null ? null : methodValues.map[json["heartbeatMethod"]],
        routeTag: json["routeTag"] == null ? null : json["routeTag"],
        rateConfig: json["rateConfig"] == null ? null : RateConfig.fromJson(json["rateConfig"]),
        campaignRegistry: json["campaignRegistry"] == null ? null : json["campaignRegistry"],
        keywordActions: json["keywordActions"] == null ? null : Map.from(json["keywordActions"]).map((k, v) => MapEntry<String, KeywordAction>(k, KeywordAction.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "accountSid": accountSid,
        "numberSetId": numberSetId,
        "cnam": cnam == null ? null : cnam,
        "name": name,
        "forwardNumber": forwardNumber == null ? null : forwardNumber,
        "callerIdName": callerIdName == null ? null : callerIdName,
        "voiceUrl": voiceUrl == null ? null : voiceUrl,
        "voiceMethod": voiceMethod == null ? null : methodValues.reverse[voiceMethod],
        "voiceFallbackUrl": voiceFallbackUrl == null ? null : voiceFallbackUrl,
        "voiceFallbackMethod": voiceFallbackMethod == null ? null : methodValues.reverse[voiceFallbackMethod],
        "hangupCallbackUrl": hangupCallbackUrl == null ? null : hangupCallbackUrl,
        "hangupCallbackMethod": hangupCallbackMethod == null ? null : methodValues.reverse[hangupCallbackMethod],
        "smsUrl": smsUrl == null ? null : smsUrl,
        "smsMethod": smsMethod == null ? null : methodValues.reverse[smsMethod],
        "smsFallbackUrl": smsFallbackUrl == null ? null : smsFallbackUrl,
        "smsFallbackMethod": smsFallbackMethod == null ? null : methodValues.reverse[smsFallbackMethod],
        "heartbeatUrl": heartbeatUrl == null ? null : heartbeatUrl,
        "heartbeatMethod": heartbeatMethod == null ? null : methodValues.reverse[heartbeatMethod],
        "routeTag": routeTag == null ? null : routeTag,
        "rateConfig": rateConfig == null ? null : rateConfig!.toJson(),
        "campaignRegistry": campaignRegistry == null ? null : campaignRegistry,
        "keywordActions": keywordActions == null ? null : Map.from(keywordActions!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

enum Method { POST, GET }

final methodValues = EnumValues({
    "GET": Method.GET,
    "POST": Method.POST
});

class KeywordAction {
    KeywordAction({
        this.campaignId,
    });

    String? campaignId;

    factory KeywordAction.fromJson(Map<String, dynamic> json) => KeywordAction(
        campaignId: json["campaignId"],
    );

    Map<String, dynamic> toJson() => {
        "campaignId": campaignId,
    };
}

class RateConfig {
    RateConfig({
        this.att,
        this.global,
        this.tmobile,
        this.verizon,
    });

    String? att;
    String? global;
    String? tmobile;
    String? verizon;

    factory RateConfig.fromJson(Map<String, dynamic> json) => RateConfig(
        att: json["att"],
        global: json["global"] == null ? null : json["global"],
        tmobile: json["tmobile"] == null ? null : json["tmobile"],
        verizon: json["verizon"],
    );

    Map<String, dynamic> toJson() => {
        "att": att,
        "global": global == null ? null : global,
        "tmobile": tmobile == null ? null : tmobile,
        "verizon": verizon,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k) );
        }
        return reverseMap??map.map((key, value) => MapEntry(value, key));
    }
}

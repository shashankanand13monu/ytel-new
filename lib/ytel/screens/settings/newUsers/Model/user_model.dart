// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        this.clientId,
        this.firstName,
        this.lastName,
        this.displayName,
        this.username,
        this.password,
        this.emailAddress,
        this.parentAcctId,
        this.belongAcctId,
        this.phone,
        this.source,
        this.avatar,
        this.createAtInEpoch,
        this.createAt,
        this.webrtcNumber,
        this.inboxes,
        this.ucaasExtension,
        this.ucaasCode,
        this.twoFactorEnabled,
        this.status,
        this.roles,
    });

    String? clientId;
    String? firstName;
    String? lastName;
    String? displayName;
    String? username;
    Password? password;
    String? emailAddress;
    String? parentAcctId;
    String? belongAcctId;
    String? phone;
    dynamic? source;
    String? avatar;
    DateTime? createAtInEpoch;
    DateTime? createAt;
    String? webrtcNumber;
    dynamic? inboxes;
    dynamic? ucaasExtension;
    dynamic? ucaasCode;
    int? twoFactorEnabled;
    Status? status;
    List<String>? roles;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        clientId: json["clientId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        displayName: json["displayName"] == null ? null : json["displayName"],
        username: json["username"],
        password: passwordValues.map[json["password"]],
        emailAddress: json["emailAddress"] == null ? null : json["emailAddress"],
        parentAcctId: json["parentAcctId"],
        belongAcctId: json["belongAcctId"],
        phone: json["phone"],
        source: json["source"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        createAtInEpoch: DateTime.parse(json["createAtInEpoch"]),
        createAt: DateTime.parse(json["createAt"]),
        webrtcNumber: json["webrtcNumber"] == null ? null : json["webrtcNumber"],
        inboxes: json["inboxes"],
        ucaasExtension: json["ucaasExtension"],
        ucaasCode: json["ucaasCode"],
        twoFactorEnabled: json["twoFactorEnabled"] == null ? null : json["twoFactorEnabled"],
        status: statusValues.map[json["status"]],
        roles: List<String>.from(json["roles"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "firstName": firstName,
        "lastName": lastName,
        "displayName": displayName == null ? null : displayName,
        "username": username,
        "password": passwordValues.reverse[password],
        "emailAddress": emailAddress == null ? null : emailAddress,
        "parentAcctId": parentAcctId,
        "belongAcctId": belongAcctId,
        "phone": phone,
        "source": source,
        "avatar": avatar == null ? null : avatar,
        "createAtInEpoch": createAtInEpoch?.toIso8601String(),
        "createAt": createAt?.toIso8601String(),
        "webrtcNumber": webrtcNumber == null ? null : webrtcNumber,
        "inboxes": inboxes,
        "ucaasExtension": ucaasExtension,
        "ucaasCode": ucaasCode,
        "twoFactorEnabled": twoFactorEnabled == null ? null : twoFactorEnabled,
        "status": statusValues.reverse[status],
        "roles": roles!=null? List<dynamic>.from(roles!.map((x) => x)):[],
    };
}

enum Password { EMPTY }

final passwordValues = EnumValues({
    "**********": Password.EMPTY
});

enum Status { ACTIVE, INACTIVE }

final statusValues = EnumValues({
    "active": Status.ACTIVE,
    "inactive": Status.INACTIVE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap??=map.map((key, value) => MapEntry(value, key));
    }
}

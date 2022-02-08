// To parse this JSON data, do
//
//     final registerSuccessModel = registerSuccessModelFromJson(jsonString);

import 'dart:convert';

RegisterSuccessModel registerSuccessModelFromJson(String str) =>
    RegisterSuccessModel.fromJson(json.decode(str));

String registerSuccessModelToJson(RegisterSuccessModel data) =>
    json.encode(data.toJson());

class RegisterSuccessModel {
  RegisterSuccessModel({
    this.message,
    this.codenum,
    this.status,
    this.result,
  });

  String message;
  int codenum;
  bool status;
  Result result;

  factory RegisterSuccessModel.fromJson(Map<String, dynamic> json) =>
      RegisterSuccessModel(
        message: json["message"],
        codenum: json["codenum"],
        status: json["status"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "codenum": codenum,
        "status": status,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    this.clientData,
  });

  List<ClientDatum> clientData;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        clientData: List<ClientDatum>.from(
            json["client_data"].map((x) => ClientDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "client_data": List<dynamic>.from(clientData.map((x) => x.toJson())),
      };
}

class ClientDatum {
  ClientDatum({
    this.name,
    this.phone,
    this.id,
    this.fullname,
    this.lang,
    this.address,
    this.email,
    this.token,
  });

  String name;
  String phone;
  int id;
  String fullname;
  String lang;
  String address;
  String email;
  String token;

  factory ClientDatum.fromJson(Map<String, dynamic> json) => ClientDatum(
        name: json["name"],
        phone: json["phone"],
        id: json["id"],
        fullname: json["fullname"],
        lang: json["lang"],
        address: json["address"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "id": id,
        "fullname": fullname,
        "lang": lang,
        "address": address,
        "email": email,
        "token": token,
      };
}

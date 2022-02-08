// To parse this JSON data, do
//
//     final failRequestModel = failRequestModelFromJson(jsonString);

import 'dart:convert';

FailedResponseModel failedResponseModelFromJson(String str) =>
    FailedResponseModel.fromJson(json.decode(str));

String failedResponseModelToJson(FailedResponseModel data) =>
    json.encode(data.toJson());

class FailedResponseModel {
  FailedResponseModel({
    this.message,
    this.codenum,
    this.status,
  });

  String message;
  int codenum;
  bool status;

  factory FailedResponseModel.fromJson(Map<String, dynamic> json) =>
      FailedResponseModel(
        message: json["message"],
        codenum: json["codenum"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "codenum": codenum,
        "status": status,
      };
}

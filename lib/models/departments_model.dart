// To parse this JSON data, do
//
//     final departmentsModel = departmentsModelFromJson(jsonString);

import 'dart:convert';

DepartmentsModel departmentsModelFromJson(String str) =>
    DepartmentsModel.fromJson(json.decode(str));

String departmentsModelToJson(DepartmentsModel data) =>
    json.encode(data.toJson());

class DepartmentsModel {
  DepartmentsModel({
    this.message,
    this.messageid,
    this.status,
    this.result,
  });

  String message;
  int messageid;
  bool status;
  Result result;

  factory DepartmentsModel.fromJson(Map<String, dynamic> json) =>
      DepartmentsModel(
        message: json["Message"],
        messageid: json["Messageid"],
        status: json["status"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Messageid": messageid,
        "status": status,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    this.categoryName,
    this.allDepartments,
  });

  String categoryName;
  List<AllDepartment> allDepartments;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        categoryName: json["category_name"],
        allDepartments: List<AllDepartment>.from(
            json["all_departments"].map((x) => AllDepartment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_name": categoryName,
        "all_departments":
            List<dynamic>.from(allDepartments.map((x) => x.toJson())),
      };
}

class AllDepartment {
  AllDepartment({
    this.depImage,
    this.depName,
    this.catId,
  });

  String depImage;
  String depName;
  int catId;

  factory AllDepartment.fromJson(Map<String, dynamic> json) => AllDepartment(
        depImage: json["dep_image"],
        depName: json["dep_name"],
        catId: json["cat_id"],
      );

  Map<String, dynamic> toJson() => {
        "dep_image": depImage,
        "dep_name": depName,
        "cat_id": catId,
      };
}

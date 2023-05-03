// To parse this JSON data, do
//
//     final departmentsModel = departmentsModelFromJson(jsonString);

// DepartmentsModel departmentsModelFromJson(String str) =>
//     DepartmentsModel.fromJson(json.decode(str));
// String departmentsModelToJson(DepartmentsModel data) =>
//     json.encode(data.toJson());

class DepartmentsModel {
  String? message;
  int? messageid;
  bool? status;
  Result? result;

  DepartmentsModel({
    this.message,
    this.messageid,
    this.status,
    this.result,
  });

  factory DepartmentsModel.fromJson(Map<String, dynamic> json) =>
      DepartmentsModel(
        message: json["Message"],
        messageid: json["Messageid"],
        status: json["status"],
        result: Result.fromJson(json["result"]),
      );

// Map<String, dynamic> toJson() => {
//       "Message": message,
//       "Messageid": messageid,
//       "status": status,
//       "result": result.toJson(),
//     };
}

class Result {
  String? categoryName;
  List<AllDepartment>? allDepartments;

  Result({
    this.categoryName,
    this.allDepartments,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        categoryName: json["category_name"],
        allDepartments: List<AllDepartment>.from(
            json["all_departments"].map((x) => AllDepartment.fromJson(x))),
      );

// Map<String, dynamic> toJson() => {
//       "category_name": categoryName,
//       "all_departments":
//           List<dynamic>.from(allDepartments.map((x) => x.toJson())),
//     };
}

class AllDepartment {
  String? depImage;
  String? depName;
  int? catId;

  AllDepartment({
    this.depImage,
    this.depName,
    this.catId,
  });

  factory AllDepartment.fromJson(Map<String, dynamic> json) => AllDepartment(
        depImage: json["dep_image"],
        depName: json["dep_name"],
        catId: json["cat_id"],
      );

// Map<String, dynamic> toJson() => {
//       "dep_image": depImage,
//       "dep_name": depName,
//       "cat_id": catId,
//     };
}

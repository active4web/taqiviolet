// To parse this JSON data, do
//
//     final productReviewsModel = productReviewsModelFromJson(jsonString);

import 'dart:convert';

ProductReviewsModel productReviewsModelFromJson(String str) =>
    ProductReviewsModel.fromJson(json.decode(str));

String productReviewsModelToJson(ProductReviewsModel data) =>
    json.encode(data.toJson());

class ProductReviewsModel {
  ProductReviewsModel({
    this.message,
    this.errNum,
    this.status,
    this.total,
    this.result,
  });

  String message;
  int errNum;
  bool status;
  int total;
  Result result;

  factory ProductReviewsModel.fromJson(Map<String, dynamic> json) =>
      ProductReviewsModel(
        message: json["message"],
        errNum: json["errNum"],
        status: json["status"],
        total: json["total"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errNum": errNum,
        "status": status,
        "total": total,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    this.allRates,
  });

  List<AllRate> allRates;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        allRates: List<AllRate>.from(
            json["all_rates"].map((x) => AllRate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_rates": List<dynamic>.from(allRates.map((x) => x.toJson())),
      };
}

class AllRate {
  AllRate({
    this.comments,
    this.rateValue,
    this.createdAt,
    this.username,
    this.prodId,
    this.allSlider,
  });

  String comments;
  String rateValue;
  DateTime createdAt;
  String username;
  int prodId;
  List<AllSlider> allSlider;

  factory AllRate.fromJson(Map<String, dynamic> json) => AllRate(
        comments: json["comments"],
        rateValue: json["rate_value"],
        createdAt: DateTime.parse(json["created_at"]),
        username: json["username"],
        prodId: json["prod_id"],
        allSlider: List<AllSlider>.from(
            json["all_slider"].map((x) => AllSlider.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "comments": comments,
        "rate_value": rateValue,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "username": username,
        "prod_id": prodId,
        "all_slider": List<dynamic>.from(allSlider.map((x) => x.toJson())),
      };
}

class AllSlider {
  AllSlider({
    this.image,
  });

  String image;

  factory AllSlider.fromJson(Map<String, dynamic> json) => AllSlider(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

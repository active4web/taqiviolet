// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) =>
    ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) =>
    json.encode(data.toJson());

class ProductDetailsModel {
  ProductDetailsModel({
    this.message,
    this.codenum,
    this.status,
    this.result,
  });

  String message;
  int codenum;
  bool status;
  Result result;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
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
    this.allRelated,
    this.allSlider,
    this.allColor,
    this.allRate,
    this.serviceDetails,
  });

  List<AllRelated> allRelated;
  List<AllSlider> allSlider;
  List<AllColor> allColor;
  List<AllRate> allRate;
  List<ServiceDetail> serviceDetails;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        allRelated: List<AllRelated>.from(
            json["all_related"].map((x) => AllRelated.fromJson(x))),
        allSlider: List<AllSlider>.from(
            json["all_slider"].map((x) => AllSlider.fromJson(x))),
        allColor: List<AllColor>.from(
            json["all_color"].map((x) => AllColor.fromJson(x))),
        allRate: List<AllRate>.from(
            json["all_rate"].map((x) => AllRate.fromJson(x))),
        serviceDetails: List<ServiceDetail>.from(
            json["service_details"].map((x) => ServiceDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_related": List<dynamic>.from(allRelated.map((x) => x.toJson())),
        "all_slider": List<dynamic>.from(allSlider.map((x) => x.toJson())),
        "all_color": List<dynamic>.from(allColor.map((x) => x.toJson())),
        "all_rate": List<dynamic>.from(allRate.map((x) => x.toJson())),
        "service_details":
            List<dynamic>.from(serviceDetails.map((x) => x.toJson())),
      };
}

class AllColor {
  AllColor({
    this.color,
  });

  String color;

  factory AllColor.fromJson(Map<String, dynamic> json) => AllColor(
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
      };
}

class AllRate {
  AllRate({
    this.username,
    this.userrate,
    this.usercomment,
    this.rateId,
  });

  String username;
  String userrate;
  String usercomment;
  int rateId;

  factory AllRate.fromJson(Map<String, dynamic> json) => AllRate(
        username: json["username"],
        userrate: json["userrate"],
        usercomment: json["usercomment"],
        rateId: json["rate_id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "userrate": userrate,
        "usercomment": usercomment,
        "rate_id": rateId,
      };
}

class AllRelated {
  AllRelated({
    this.productImage,
    this.serviceName,
    this.totalRate,
  });

  String productImage;
  String serviceName;
  String totalRate;

  factory AllRelated.fromJson(Map<String, dynamic> json) => AllRelated(
        productImage: json["product_image"],
        serviceName: json["service_name"],
        totalRate: json["total_rate"],
      );

  Map<String, dynamic> toJson() => {
        "product_image": productImage,
        "service_name": serviceName,
        "total_rate": totalRate,
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

class ServiceDetail {
  ServiceDetail(
      {this.favExit,
      this.totalRate,
      this.totalSales,
      this.productImage,
      this.shareLink,
      this.serviceName,
      this.sliderType,
      this.videoLink,
      this.price,
      this.oldPrice,
      this.description,
      this.id,
      this.isFav});

  int favExit;
  String totalRate;
  String totalSales;
  String productImage;
  String shareLink;
  String serviceName;
  String sliderType;
  String videoLink;
  String price;
  String oldPrice;
  String description;
  int id;
  bool isFav;

  factory ServiceDetail.fromJson(Map<String, dynamic> json) => ServiceDetail(
        favExit: json["fav_exit"],
        isFav: json["fav_exit"] == 1 ? true : false,
        totalRate: json["total_rate"],
        totalSales: json["total_sales"],
        productImage: json["product_image"],
        shareLink: json["share_link"],
        serviceName: json["service_name"],
        sliderType: json["slider_type"],
        videoLink: json["video_link"],
        price: json["price"],
        oldPrice: json["old_price"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "fav_exit": favExit,
        "total_rate": totalRate,
        "total_sales": totalSales,
        "product_image": productImage,
        "share_link": shareLink,
        "service_name": serviceName,
        "slider_type": sliderType,
        "video_link": videoLink,
        "price": price,
        "old_price": oldPrice,
        "description": description,
        "id": id,
      };
}

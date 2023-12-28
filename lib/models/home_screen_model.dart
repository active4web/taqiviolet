// To parse this JSON data, do
//
//     final homeScreenModel = homeScreenModelFromJson(jsonString);

// import 'dart:convert';
//
// HomeScreenModel homeScreenModelFromJson(String str) =>
//     HomeScreenModel.fromJson(json.decode(str));
//
// String homeScreenModelToJson(HomeScreenModel data) =>
//     json.encode(data.toJson());

class HomeScreenModel {
  HomeScreenModel({
    this.message,
    this.codenum,
    this.status,
    this.lang,
    this.result,
  });

  String? message;
  int? codenum;
  bool? status;
  String? lang;
  Result? result;

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) =>
      HomeScreenModel(
        message: json["message"],
        codenum: json["codenum"],
        status: json["status"],
        lang: json["\u0024lang"],
        result: Result.fromJson(json["result"]),
      );

// Map<String, dynamic> toJson() => {
//       "message": message,
//       "codenum": codenum,
//       "status": status,
//       "\u0024lang": lang,
//       "result": result.toJson(),
//     };
}

class Result {
  Result({
    this.mainOffers,
    this.allCategories,
    this.mainOffer,
    this.mainOfferId,
    this.allOffers,
    this.allFeatures,
  });

  List<MainOffer>? mainOffers;
  List<AllCategory>? allCategories;
  String? mainOffer;
  String? mainOfferId;
  List<AllOffer>? allOffers;
  List<AllFeature>? allFeatures;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        mainOffers: List<MainOffer>.from(
            json["main_offers"].map((x) => MainOffer.fromJson(x))),
        allCategories: List<AllCategory>.from(
            json["all_categories"].map((x) => AllCategory.fromJson(x))),
        mainOffer: json["main_offer"],
        mainOfferId: json["main_offer_id"],
        allOffers: List<AllOffer>.from(
            json["all_offers"].map((x) => AllOffer.fromJson(x))),
        allFeatures: List<AllFeature>.from(
            json["all_features"].map((x) => AllFeature.fromJson(x))),
      );

// Map<String, dynamic> toJson() => {
//       "main_offers": List<dynamic>.from(mainOffers.map((x) => x.toJson())),
//       "all_categories":
//           List<dynamic>.from(allCategories.map((x) => x.toJson())),
//       "main_offer": mainOffer,
//       "main_offer_id": mainOfferId,
//       "all_offers": List<dynamic>.from(allOffers.map((x) => x.toJson())),
//       "all_features": List<dynamic>.from(allFeatures.map((x) => x.toJson())),
//     };
}

class AllCategory {
  AllCategory({
    this.totalDepartment,
    this.categoryImage,
    this.categoryName,
    this.catId,
  });

  int? totalDepartment;
  String? categoryImage;
  String? categoryName;
  int? catId;

  factory AllCategory.fromJson(Map<String, dynamic> json) => AllCategory(
        totalDepartment: json["total_department"],
        categoryImage: json["category_image"],
        categoryName: json["category_name"],
        catId: json["cat_id"],
      );

// Map<String, dynamic> toJson() => {
//       "total_department": totalDepartment,
//       "category_image": categoryImage,
//       "category_name": categoryName,
//       "cat_id": catId,
//     };
}

class AllFeature {
  AllFeature({
    this.totalDepartment,
    this.featureCategoryImage,
    this.featureCategoryName,
    this.featureCatId,
  });

  int? totalDepartment;
  String? featureCategoryImage;
  String? featureCategoryName;
  int? featureCatId;

  factory AllFeature.fromJson(Map<String, dynamic> json) => AllFeature(
        totalDepartment: json["total_department"],
        featureCategoryImage: json["feature_category_image"],
        featureCategoryName: json["feature_category_name"],
        featureCatId: json["feature_cat_id"],
      );

// Map<String, dynamic> toJson() => {
//       "total_department": totalDepartment,
//       "feature_category_image": featureCategoryImage,
//       "feature_category_name": featureCategoryName,
//       "feature_cat_id": featureCatId,
//     };
}

class AllOffer {
  AllOffer({
    this.categoryImage,
    this.offerName,
    this.smallDesc,
    this.offerId,
  });

  String? categoryImage;
  String? offerName;
  String? smallDesc;
  int? offerId;

  factory AllOffer.fromJson(Map<String, dynamic> json) => AllOffer(
        categoryImage: json["category_image"],
        offerName: json["offer_name"],
        smallDesc: json["small_desc"],
        offerId: json["offer_id"],
      );

// Map<String, dynamic> toJson() => {
//       "category_image": categoryImage,
//       "offer_name": offerName,
//       "small_desc": smallDesc,
//       "offer_id": offerId,
//     };
}

class MainOffer {
  MainOffer({
    this.image,
    this.link,
    this.serviceId,
  });

  String? image;
  String? link;
  String? serviceId;

  factory MainOffer.fromJson(Map<String, dynamic> json) => MainOffer(
        image: json["image"],
        link: json["link"],
        serviceId: json["service_id"],
      );

// Map<String, dynamic> toJson() => {
//       "image": image,
//       "link": link,
//       "service_id": serviceId,
//     };
}

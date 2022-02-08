// To parse this JSON data, do
//
//     final favouritesProductsModel = favouritesProductsModelFromJson(jsonString);

import 'dart:convert';

FavouritesProductsModel favouritesProductsModelFromJson(String str) =>
    FavouritesProductsModel.fromJson(json.decode(str));

String favouritesProductsModelToJson(FavouritesProductsModel data) =>
    json.encode(data.toJson());

class FavouritesProductsModel {
  FavouritesProductsModel({
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

  factory FavouritesProductsModel.fromJson(Map<String, dynamic> json) =>
      FavouritesProductsModel(
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
    this.allFavourites,
  });

  List<AllFavourite> allFavourites;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        allFavourites: List<AllFavourite>.from(
            json["all_favourites"].map((x) => AllFavourite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_favourites":
            List<dynamic>.from(allFavourites.map((x) => x.toJson())),
      };
}

class AllFavourite {
  AllFavourite({
    this.favExit,
    this.isFav,
    this.totalRate,
    this.price,
    this.oldPrice,
    this.stock,
    this.discountValue,
    this.prodId,
    this.totalSales,
    this.productImage,
    this.shareLink,
    this.serviceName,
  });

  int favExit;
  bool isFav;
  String totalRate;
  String price;
  String oldPrice;
  String stock;
  String discountValue;
  int prodId;
  String totalSales;
  String productImage;
  String shareLink;
  String serviceName;

  factory AllFavourite.fromJson(Map<String, dynamic> json) => AllFavourite(
        favExit: json["fav_exit"],
        isFav: json["fav_exit"] == 1 ? true : false,
        totalRate: json["total_rate"],
        price: json["price"],
        oldPrice: json["old_price"],
        stock: json["stock"],
        discountValue: json["discount_value"],
        prodId: json["prod_id"],
        totalSales: json["total_sales"],
        productImage: json["product_image"],
        shareLink: json["share_link"],
        serviceName: json["service_name"],
      );

  Map<String, dynamic> toJson() => {
        "fav_exit": favExit,
        "total_rate": totalRate,
        "price": price,
        "old_price": oldPrice,
        "stock": stock,
        "discount_value": discountValue,
        "prod_id": prodId,
        "total_sales": totalSales,
        "product_image": productImage,
        "share_link": shareLink,
        "service_name": serviceName,
      };
}

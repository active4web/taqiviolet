class ProductsModel {
  ProductsModel({
    this.message,
    this.messageid,
    this.status,
    this.total,
    this.result,
  });

  String? message;
  int? messageid;
  bool? status;
  int? total;
  Result? result;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        message: json["Message"],
        messageid: json["Messageid"],
        status: json["status"],
        total: json["total"],
        result: Result.fromJson(json["result"]),
      );

/*  Map<String, dynamic> toJson() => {
        "Message": message,
        "Messageid": messageid,
        "status": status,
        "total": total,
        "result": result.toJson(),
      };*/
}

class Result {
  Result({
    this.categoryDetails,
    this.allProducts,
  });

  CategoryDetails? categoryDetails;
  List<AllProduct>? allProducts;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        categoryDetails: CategoryDetails.fromJson(json["category_details"]),
        allProducts: List<AllProduct>.from(
            json["all_products"].map((x) => AllProduct.fromJson(x))),
      );

/*  Map<String, dynamic> toJson() => {
        "category_details": categoryDetails.toJson(),
        "all_products": List<dynamic>.from(allProducts.map((x) => x.toJson())),
      };*/
}

class AllProduct {
  AllProduct(
      {this.favExit,
      this.totalRate,
      this.productImage,
      this.price,
      this.oldPrice,
      this.stock,
      this.productName,
      this.prodId,
      this.isFav});

  int? favExit;
  bool? isFav;
  String? totalRate;
  String? productImage;
  String? price;
  String? oldPrice;
  String? stock;
  String? productName;
  int? prodId;

  factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
        favExit: json["fav_exit"],
        isFav: json["fav_exit"] == 1 ? true : false,
        totalRate: json["total_rate"],
        productImage: json["product_image"],
        price: json["price"],
        oldPrice: json["old_price"],
        stock: json["stock"],
        productName: json["product_name"],
        prodId: json["prod_id"],
      );

/*  Map<String, dynamic> toJson() => {
        "fav_exit": favExit,
        "total_rate": totalRate,
        "product_image": productImage,
        "price": price,
        "old_price": oldPrice,
        "stock": stock,
        "product_name": productName,
        "prod_id": prodId,
      };*/
}

class CategoryDetails {
  CategoryDetails({
    this.categoryImage,
    this.categoryName,
    this.catId,
  });

  String? categoryImage;
  String? categoryName;
  int? catId;

  factory CategoryDetails.fromJson(Map<String, dynamic> json) =>
      CategoryDetails(
        categoryImage: json["category_image"],
        categoryName: json["category_name"],
        catId: json["cat_id"],
      );

/*  Map<String, dynamic> toJson() => {
        "category_image": categoryImage,
        "category_name": categoryName,
        "cat_id": catId,
      };*/
}

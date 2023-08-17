// class MyProductsDetailsModel {
//   MyProductsDetailsModel({
//     this.status,
//     this.errNum,
//     this.msg,
//     this.data,
//   });

//   MyProductsDetailsModel.fromJson(dynamic json) {
//     status = json['status'];
//     errNum = json['errNum'];
//     msg = json['msg'];
//     data = json['Data'] != null
//         ? MyProductDetailsData.fromJson(json['Data'])
//         : null;
//   }
//   bool? status;
//   String? errNum;
//   String? msg;
//   MyProductDetailsData data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['errNum'] = errNum;
//     map['msg'] = msg;
//     if (data != null) {
//       map['Data'] = data.toJson();
//     }
//     return map;
//   }
// }

// class MyProductDetailsData {
//   MyProductDetailsData({
//     this.numberoftimestobuy,
//     this.productDetails,
//     this.productfeatures,
//     this.productSizes,
//     this.relatedProducts,
//     this.productUrl,
//   });

//   MyProductDetailsData.fromJson(dynamic json) {
//     numberoftimestobuy = json['Number-of-times-to-buy'];
//     if (json['Product-Details'] != null) {
//       productDetails = [];
//       json['Product-Details'].forEach((v) {
//         productDetails.add(ProductDetails.fromJson(v));
//       });
//     }
//     if (json['productfeatures'] != null) {
//       productfeatures = [];
//       json['productfeatures'].forEach((v) {
//         productfeatures.add(Productfeatures.fromJson(v));
//       });
//     }
//     if (json['Related Products'] != null) {
//       relatedProducts = [];
//       json['Related Products'].forEach((v) {
//         relatedProducts.add(RelatedProducts.fromJson(v));
//       });
//     }
//     if (json['productsize'] != null) {
//       relatedProducts = [];
//       json['productsize'].forEach((v) {
//         productSizes.add(ProductSizes.fromJson(v));
//       });
//     }
//     productUrl = json['productUrl'];
//   }
//   int? numberoftimestobuy;
//   List<ProductDetails> productDetails;
//   List<Productfeatures> productfeatures;
//   List<RelatedProducts> relatedProducts;
//   List<ProductSizes> productSizes;
//   String? productUrl;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['Number-of-times-to-buy'] = numberoftimestobuy;
//     if (productDetails != null) {
//       map['Product-Details'] = productDetails.map((v) => v.toJson()).toList();
//     }
//     if (productfeatures != null) {
//       map['productfeatures'] = productfeatures.map((v) => v.toJson()).toList();
//     }
//     if (relatedProducts != null) {
//       map['Related Products'] = relatedProducts.map((v) => v.toJson()).toList();
//     }
//     if (productSizes != null) {
//       map['productsize'] = productSizes.map((v) => v.toJson()).toList();
//     }
//     map['productUrl'] = productUrl;
//     return map;
//   }
// }

// class RelatedProducts {
//   RelatedProducts({
//     this.id,
//     this.name,
//     this.nameSearch,
//     this.oldPrice,
//     this.currentPrice,
//     this.details,
//     this.quantity,
//     this.subCategoryId,
//     this.categoryId,
//     this.isActive,
//     this.storeId,
//     this.createdAt,
//     this.updatedAt,
//     this.image,
//     this.hasFavorites,
//     this.hasRosters,
//     this.hasReviews,
//     this.reviewComment,
//   });

//   RelatedProducts.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     nameSearch = json['name_search'];
//     oldPrice = json['old_price'];
//     currentPrice = json['current_price'];
//     details = json['details'];
//     quantity = json['quantity'];
//     subCategoryId = json['sub_category_id'];
//     categoryId = json['category_id'];
//     isActive = json['is_active'];
//     storeId = json['store_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     image = json['image'];
//     hasFavorites = json['hasFavorites'];
//     hasRosters = json['hasRosters'];
//     hasReviews = json['hasReviews'];
//     reviewComment = json['ReviewComment'];
//   }
//   int? id;
//   String? name;
//   String? nameSearch;
//   int? oldPrice;
//   int? currentPrice;
//   String? details;
//   String? quantity;
//   int? subCategoryId;
//   int? categoryId;
//   int? isActive;
//   int? storeId;
//   String? createdAt;
//   String? updatedAt;
//   String? image;
//   int? hasFavorites;
//   int? hasRosters;
//   String? hasReviews;
//   String? reviewComment;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['name_search'] = nameSearch;
//     map['old_price'] = oldPrice;
//     map['current_price'] = currentPrice;
//     map['details'] = details;
//     map['quantity'] = quantity;
//     map['sub_category_id'] = subCategoryId;
//     map['category_id'] = categoryId;
//     map['is_active'] = isActive;
//     map['store_id'] = storeId;
//     map['created_at'] = createdAt;
//     map['updated_at'] = updatedAt;
//     map['image'] = image;
//     map['hasFavorites'] = hasFavorites;
//     map['hasRosters'] = hasRosters;
//     map['hasReviews'] = hasReviews;
//     map['ReviewComment'] = reviewComment;
//     return map;
//   }
// }

// class Productfeatures {
//   Productfeatures({
//     this.id,
//     this.name,
//     this.description,
//   });

//   Productfeatures.fromJson(dynamic json) {
//     id = json['ID'];
//     name = json['name'];
//     description = json['description'];
//   }
//   int? id;
//   String? name;
//   String? description;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['ID'] = id;
//     map['name'] = name;
//     map['description'] = description;
//     return map;
//   }
// }

// class ProductDetails {
//   ProductDetails({
//     this.id,
//     this.name,
//     this.nameSearch,
//     this.oldPrice,
//     this.currentPrice,
//     this.details,
//     this.smartPrice,
//     this.quantity,
//     this.subCategoryId,
//     this.categoryId,
//     this.isActive,
//     this.storeId,
//     this.createdAt,
//     this.updatedAt,
//     this.image,
//     this.images,
//     this.hasFavorites,
//     this.hasRosters,
//     this.reviewRate,
//     this.reviewComment,
//   });

//   ProductDetails.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     nameSearch = json['name_search'];
//     oldPrice = json['old_price'];
//     currentPrice = json['current_price'];
//     smartPrice = json['smart_price'];
//     details = json['details'];
//     quantity = json['quantity'];
//     subCategoryId = json['sub_category_id'];
//     categoryId = json['category_id'];
//     isActive = json['is_active'];
//     storeId = json['store_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     image = json['image'];
//     images = json['images'] != null ? json['images'].cast<String>() : [];
//     hasFavorites = json['hasFavorites'];
//     hasRosters = json['hasRosters'];
//     reviewRate = json['ReviewRate'];
//     reviewComment = json['ReviewComment'];
//     hasCart = json['hascart'];
//   }
//   int? id;
//   String? name;
//   String? nameSearch;
//   num oldPrice;
//   num currentPrice;
//   num smartPrice;
//   String? details;
//   String? quantity;
//   int? subCategoryId;
//   int? categoryId;
//   int? isActive;
//   int? storeId;
//   String? createdAt;
//   String? updatedAt;
//   String? image;
//   List<String> images;
//   int? hasFavorites;
//   int? hasRosters;
//   String? reviewRate;
//   String? reviewComment;
//   int? hasCart;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['name_search'] = nameSearch;
//     map['old_price'] = oldPrice;
//     map['current_price'] = currentPrice;
//     map['smart_price'] = smartPrice;
//     map['details'] = details;
//     map['quantity'] = quantity;
//     map['sub_category_id'] = subCategoryId;
//     map['category_id'] = categoryId;
//     map['is_active'] = isActive;
//     map['store_id'] = storeId;
//     map['created_at'] = createdAt;
//     map['updated_at'] = updatedAt;
//     map['image'] = image;
//     map['images'] = images;
//     map['hasFavorites'] = hasFavorites;
//     map['hasRosters'] = hasRosters;
//     map['ReviewRate'] = reviewRate;
//     map['ReviewComment'] = reviewComment;
//     map['hascart'] = hasCart;
//     return map;
//   }
// }

// class ProductSizes {
//   ProductSizes({
//     this.id,
//     this.name,
//   });
//   int? id;
//   String? name;
//   ProductSizes.fromJson(Map<String, dynamic> json) {
//     id = json['ID'];
//     name = json['name'];
//   }
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['ID'] = this.id;
//     map['name'] = this.name;
//     return map;
//   }
// }
class MyProductsDetailsModel {
  bool? status;
  String? errNum;
  String? msg;
  MyProductDetailsData? data;

  MyProductsDetailsModel({this.status, this.errNum, this.msg, this.data});

  MyProductsDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['Data'] != null
        ? new MyProductDetailsData.fromJson(json['Data'])
        : null;
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['status'] = this.status;
//   data['errNum'] = this.errNum;
//   data['msg'] = this.msg;
//   if (this.data != null) {
//     data['Data'] = this.data.toJson();
//   }
//   return data;
// }
}

class MyProductDetailsData {
  dynamic numberOfTimesToBuy;
  List<ProductDetails>? productDetails;
  List<Productsize>? productsize;
  List<Productfeatures>? productfeatures;
  List<RelatedProducts>? relatedProducts;
  String? productUrl;

  MyProductDetailsData(
      {this.numberOfTimesToBuy,
      this.productDetails,
      this.productsize,
      this.productfeatures,
      this.relatedProducts,
      this.productUrl});

  MyProductDetailsData.fromJson(Map<String, dynamic> json) {
    numberOfTimesToBuy = json['Number-of-times-to-buy'];
    if (json['Product-Details'] != null) {
      productDetails = <ProductDetails>[];
      json['Product-Details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    if (json['productsize'] != null) {
      productsize = <Productsize>[];
      json['productsize'].forEach((v) {
        productsize!.add(new Productsize.fromJson(v));
      });
    }
    if (json['productfeatures'] != null) {
      productfeatures = <Productfeatures>[];
      json['productfeatures'].forEach((v) {
        productfeatures!.add(new Productfeatures.fromJson(v));
      });
    }
    if (json['Related Products'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['Related Products'].forEach((v) {
        relatedProducts!.add(new RelatedProducts.fromJson(v));
      });
    }
    productUrl = json['productUrl'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['Number-of-times-to-buy'] = this.numberOfTimesToBuy;
//   if (this.productDetails != null) {
//     data['Product-Details'] =
//         this.productDetails.map((v) => v.toJson()).toList();
//   }
//   if (this.productsize != null) {
//     data['productsize'] = this.productsize.map((v) => v.toJson()).toList();
//   }
//   if (this.productfeatures != null) {
//     data['productfeatures'] =
//         this.productfeatures.map((v) => v.toJson()).toList();
//   }
//   if (this.relatedProducts != null) {
//     data['Related Products'] =
//         this.relatedProducts.map((v) => v.toJson()).toList();
//   }
//   data['productUrl'] = this.productUrl;
//   return data;
// }
}

class ProductDetails {
  dynamic id;
  dynamic smartType;
  String? name;
  String? nameSearch;
  dynamic oldPrice;
  dynamic currentPrice;
  dynamic smartPrice;
  String? details;
  String? quantity;
  dynamic subCategoryId;
  dynamic categoryId;
  dynamic isActive;
  String? deliveryTime;
  String? createdAt;
  String? updatedAt;
  String? image;

  String? serialNo;

  List<String>? images;
  dynamic hascart;
  dynamic hasFavorites;
  dynamic hasRosters;
  int? cartTotal;
  String? hasReviews;

  ProductDetails(
      {this.id,
      this.name,
        this.cartTotal,
      this.smartType,
      this.nameSearch,
      this.oldPrice,
      this.currentPrice,
      this.smartPrice,
      this.details,
      this.quantity,
      this.subCategoryId,
        this.deliveryTime,
      this.categoryId,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.serialNo,
      this.images,
      this.hascart,
      this.hasFavorites,
      this.hasRosters,
      this.hasReviews});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartTotal = json['cart_total'];
    smartType = json['smart_type'];
    name = json['name'];
    deliveryTime = json['delivery_time'];
    nameSearch = json['name_search'];
    oldPrice = json['old_price'];
    currentPrice = json['current_price'];
    smartPrice = json['smart_price'];
    details = json['details'];
    quantity = json['quantity'];
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    isActive = json['is_active'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];

    serialNo = json['serial_no'];

    images = json['images'].cast<String>();
    hascart = json['hascart'];
    hasFavorites = json['hasFavorites'];
    hasRosters = json['hasRosters'];
    hasReviews = json['hasReviews'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['name'] = this.name;
//   data['name_search'] = this.nameSearch;
//   data['old_price'] = this.oldPrice;
//   data['current_price'] = this.currentPrice;
//   data['smart_price'] = this.smartPrice;
//   data['details'] = this.details;
//   data['quantity'] = this.quantity;
//   data['sub_category_id'] = this.subCategoryId;
//   data['category_id'] = this.categoryId;
//   data['is_active'] = this.isActive;
//   data['created_at'] = this.createdAt;
//   data['updated_at'] = this.updatedAt;
//   data['image'] = this.image;
//   data['serial_no'] = this.serialNo;
//   data['images'] = this.images;
//   data['hascart'] = this.hascart;
//   data['hasFavorites'] = this.hasFavorites;
//   data['hasRosters'] = this.hasRosters;
//   data['hasReviews'] = this.hasReviews;
//   return data;
// }
}

class Productsize {
  int? iD;
  String? name;

  Productsize({this.iD, this.name});

  Productsize.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['name'];
  }
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['ID'] = this.iD;
//   data['name'] = this.name;
//   return data;
// }
}

class Productfeatures {
  int? iD;
  String? name;
  String? description;

  Productfeatures({this.iD, this.name, this.description});

  Productfeatures.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['name'];
    description = json['description'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['ID'] = this.iD;
//   data['name'] = this.name;
//   data['description'] = this.description;
//   return data;
// }
}

class RelatedProducts {
  int? id;
  String? name;
  String? nameSearch;
  dynamic oldPrice;
  dynamic currentPrice;
  String? details;
  String? quantity;
  dynamic subCategoryId;
  dynamic categoryId;
  dynamic smartPrice;
  dynamic isActive;
  dynamic storeId;
  String? createdAt;
  String? updatedAt;
  String? image;
  dynamic hasFavorites;
  dynamic hasRosters;
  String? hasReviews;

  RelatedProducts(
      {this.id,
      this.name,
      this.nameSearch,
      this.oldPrice,
      this.currentPrice,
      this.details,
      this.quantity,
      this.subCategoryId,
      this.categoryId,
      this.isActive,
        this.smartPrice,
      this.storeId,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.hasFavorites,
      this.hasRosters,
      this.hasReviews});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    smartPrice = json['smart_price'];
    nameSearch = json['name_search'];
    oldPrice = json['old_price'];
    currentPrice = json['current_price'];
    details = json['details'];
    quantity = json['quantity'];
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    isActive = json['is_active'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    hasFavorites = json['hasFavorites'];
    hasRosters = json['hasRosters'];
    hasReviews = json['hasReviews'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['name'] = this.name;
//   data['name_search'] = this.nameSearch;
//   data['old_price'] = this.oldPrice;
//   data['current_price'] = this.currentPrice;
//
//   data['details'] = this.details;
//   data['quantity'] = this.quantity;
//   data['sub_category_id'] = this.subCategoryId;
//   data['category_id'] = this.categoryId;
//   data['is_active'] = this.isActive;
//   data['store_id'] = this.storeId;
//   data['created_at'] = this.createdAt;
//   data['updated_at'] = this.updatedAt;
//   data['image'] = this.image;
//
//   data['hasFavorites'] = this.hasFavorites;
//   data['hasRosters'] = this.hasRosters;
//   data['hasReviews'] = this.hasReviews;
//   return data;
// }
}

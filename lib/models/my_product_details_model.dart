// class MYProductDetailsModel {
//   bool status;
//   String errNum;
//   String msg;
//   ProductDetails productDetails;
//
//   MYProductDetailsModel(
//       {this.status, this.errNum, this.msg, this.productDetails});
//
//   MYProductDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     errNum = json['errNum'];
//     msg = json['msg'];
//     productDetails =  ProductDetails.fromJson(json['ProductDetails'])
//      ;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['errNum'] = this.errNum;
//     data['msg'] = this.msg;
//     if (this.productDetails != null) {
//       data['ProductDetails'] = this.productDetails.toJson();
//     }
//     return data;
//   }
// }
//
// class ProductDetails {
//   int numberOfTimesToBuy;
//   List<ProductDetailsData> productDetails;
//   List<RelatedProducts> relatedProducts;
//   String productUrl;
//
//   ProductDetails(
//       {this.numberOfTimesToBuy,
//         this.productDetails,
//         this.relatedProducts,
//         this.productUrl});
//
//   ProductDetails.fromJson(Map<String, dynamic> json) {
//     numberOfTimesToBuy = json['Number-of-times-to-buy'];
//     if (json['Product-Details'] != null) {
//       productDetails = <ProductDetailsData>[];
//       json['Product-Details'].forEach((v) {
//         productDetails.add(new ProductDetailsData.fromJson(v));
//       });
//     }
//     if (json['Related Products'] != null) {
//       relatedProducts = <RelatedProducts>[];
//       json['Related Products'].forEach((v) {
//         relatedProducts.add(new RelatedProducts.fromJson(v));
//       });
//     }
//     productUrl = json['productUrl'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Number-of-times-to-buy'] = this.numberOfTimesToBuy;
//     if (this.productDetails != null) {
//       data['Product-Details'] =
//           this.productDetails.map((v) => v.toJson()).toList();
//     }
//     if (this.relatedProducts != null) {
//       data['Related Products'] =
//           this.relatedProducts.map((v) => v.toJson()).toList();
//     }
//     data['productUrl'] = this.productUrl;
//     return data;
//   }
// }
//
// class ProductDetailsData {
//   int id;
//   String name;
//   String price;
//   int discount;
//   String details;
//   String quantity;
//   int subCategoryId;
//   int categoryId;
//   int isActive;
//   int storeId;
//   String createdAt;
//   String updatedAt;
//   String images;
//   int hasFavorites;
//   int hasReviews;
//
//   ProductDetailsData(
//       {this.id,
//         this.name,
//         this.price,
//         this.discount,
//         this.details,
//         this.quantity,
//         this.subCategoryId,
//         this.categoryId,
//         this.isActive,
//         this.storeId,
//         this.createdAt,
//         this.updatedAt,
//         this.images,
//         this.hasFavorites,
//         this.hasReviews});
//
//   ProductDetailsData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     discount = json['discount'];
//     details = json['details'];
//     quantity = json['quantity'];
//     subCategoryId = json['sub_category_id'];
//     categoryId = json['category_id'];
//     isActive = json['is_active'];
//     storeId = json['store_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     images = json['images'];
//     hasFavorites = json['hasFavorites'];
//     hasReviews = json['hasReviews'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['discount'] = this.discount;
//     data['details'] = this.details;
//     data['quantity'] = this.quantity;
//     data['sub_category_id'] = this.subCategoryId;
//     data['category_id'] = this.categoryId;
//     data['is_active'] = this.isActive;
//     data['store_id'] = this.storeId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['images'] = this.images;
//     data['hasFavorites'] = this.hasFavorites;
//     data['hasReviews'] = this.hasReviews;
//     return data;
//   }
// }
//
// class RelatedProducts {
//   int id;
//   Name name;
//   String price;
//   Null discount;
//   Name details;
//   String quantity;
//   Null subCategoryId;
//   int categoryId;
//   int isActive;
//   int storeId;
//   String createdAt;
//   String updatedAt;
// String  images;
//   RelatedProducts(
//       {this.id,this.images,
//         this.name,
//         this.price,
//         this.discount,
//         this.details,
//         this.quantity,
//         this.subCategoryId,
//         this.categoryId,
//         this.isActive,
//         this.storeId,
//         this.createdAt,
//         this.updatedAt});
//
//   RelatedProducts.fromJson(Map<String, dynamic> json) {
//     images = json['images'];
//     id = json['id'];
//     name =  Name.fromJson(json['name'])  ;
//     price = json['price'];
//     discount = json['discount'];
//     details =
//  Name.fromJson(json['details']) ;
//     quantity = json['quantity'];
//     subCategoryId = json['sub_category_id'];
//     categoryId = json['category_id'];
//     isActive = json['is_active'];
//     storeId = json['store_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.name != null) {
//       data['name'] = this.name.toJson();
//     }
//     data['price'] = this.price;
//     data['discount'] = this.discount;
//     if (this.details != null) {
//       data['details'] = this.details.toJson();
//     }
//     data['quantity'] = this.quantity;
//     data['sub_category_id'] = this.subCategoryId;
//     data['category_id'] = this.categoryId;
//     data['is_active'] = this.isActive;
//     data['store_id'] = this.storeId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Name {
//   String en;
//   String ar;
//   String it;
//
//   Name({this.en, this.ar, this.it});
//
//   Name.fromJson(Map<String, dynamic> json) {
//     en = json['en'];
//     ar = json['ar'];
//     it = json['it'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['en'] = this.en;
//     data['ar'] = this.ar;
//     data['it'] = this.it;
//     return data;
//   }
// }

//
//
// class MYProductDetailsModel {
//   bool status;
//   String errNum;
//   String msg;
//   ProductDetails productDetails;
//
//   MYProductDetailsModel(
//       {this.status, this.errNum, this.msg, this.productDetails});
//
//   MYProductDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     errNum = json['errNum'];
//     msg = json['msg'];
//     productDetails =  ProductDetails.fromJson(json['ProductDetails'])
//     ;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['errNum'] = this.errNum;
//     data['msg'] = this.msg;
//     if (this.productDetails != null) {
//       data['ProductDetails'] = this.productDetails.toJson();
//     }
//     return data;
//   }
// }
//
// class ProductDetails {
//   int numberOfTimesToBuy;
//   List<ProductDetailsData> productDetailsdata;
//   List<RelatedProducts> relatedProducts;
//   String productUrl;
//
//   ProductDetails(
//       {this.numberOfTimesToBuy,
//         this.productDetailsdata,
//         this.relatedProducts,
//         this.productUrl});
//
//   ProductDetails.fromJson(Map<String, dynamic> json) {
//     numberOfTimesToBuy = json['Number-of-times-to-buy'];
//     if (json['Product-Details'] != null) {
//       productDetailsdata = <ProductDetailsData>[];
//       json['Product-Details'].forEach((v) {
//         productDetailsdata.add(new ProductDetailsData.fromJson(v));
//       });
//     }
//     if (json['Related Products'] != null) {
//       relatedProducts = <RelatedProducts>[];
//       json['Related Products'].forEach((v) {
//         relatedProducts.add(new RelatedProducts.fromJson(v));
//       });
//     }
//     productUrl = json['productUrl'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Number-of-times-to-buy'] = this.numberOfTimesToBuy;
//
//       data['Product-Details'] =
//           this.productDetailsdata.map((v) => v.toJson()).toList();
//
//     if (this.relatedProducts != null) {
//       data['Related Products'] =
//           this.relatedProducts.map((v) => v.toJson()).toList();
//     }
//     data['productUrl'] = this.productUrl;
//     return data;
//   }
// }
//
// class ProductDetailsData {
//   int id;
//   String name;
//   String price;
//   int discount;
//   String details;
//   String quantity;
//   int subCategoryId;
//   int categoryId;
//   int isActive;
//   int storeId;
//   String createdAt;
//   String updatedAt;
//   String images;
//   int hasFavorites;
//   String reviewRate;
//   String reviewComment;
//
//   ProductDetailsData(
//       {this.id,
//         this.name,
//         this.price,
//         this.discount,
//         this.details,
//         this.quantity,
//         this.subCategoryId,
//         this.categoryId,
//         this.isActive,
//         this.storeId,
//         this.createdAt,
//         this.updatedAt,
//         this.images,
//         this.hasFavorites,
//         this.reviewRate,
//         this.reviewComment});
//
//   ProductDetailsData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     discount = json['discount'];
//     details = json['details'];
//     quantity = json['quantity'];
//     subCategoryId = json['sub_category_id'];
//     categoryId = json['category_id'];
//     isActive = json['is_active'];
//     storeId = json['store_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     images = json['images'];
//     hasFavorites = json['hasFavorites'];
//     reviewRate = json['ReviewRate'];
//     reviewComment = json['ReviewComment'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['discount'] = this.discount;
//     data['details'] = this.details;
//     data['quantity'] = this.quantity;
//     data['sub_category_id'] = this.subCategoryId;
//     data['category_id'] = this.categoryId;
//     data['is_active'] = this.isActive;
//     data['store_id'] = this.storeId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['images'] = this.images;
//     data['hasFavorites'] = this.hasFavorites;
//     data['ReviewRate'] = this.reviewRate;
//     data['ReviewComment'] = this.reviewComment;
//     return data;
//   }
// }
//
// class RelatedProducts {
//   int id;
//   String name;
//   String price;
//   String discount;
//   String details;
//   String quantity;
//   int subCategoryId;
//   int categoryId;
//   int isActive;
//   int storeId;
//   String createdAt;
//   String updatedAt;
//   String images;
//   int hasFavorites;
//   int reviewRate;
//   String reviewComment;
//   int hasReviews;
//
//   RelatedProducts(
//       {this.id,
//         this.name,
//         this.price,
//         this.discount,
//         this.details,
//         this.quantity,
//         this.subCategoryId,
//         this.categoryId,
//         this.isActive,
//         this.storeId,
//         this.createdAt,
//         this.updatedAt,
//         this.images,
//         this.hasFavorites,
//         this.reviewRate,
//         this.reviewComment,
//         this.hasReviews});
//
//   RelatedProducts.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     price = json['price'];
//     discount = json['discount'];
//     details = json['details'];
//     quantity = json['quantity'];
//     subCategoryId = json['sub_category_id'];
//     categoryId = json['category_id'];
//     isActive = json['is_active'];
//     storeId = json['store_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     images = json['images'];
//     hasFavorites = json['hasFavorites'];
//     reviewRate = json['ReviewRate'];
//     reviewComment = json['ReviewComment'];
//     hasReviews = json['hasReviews'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['price'] = this.price;
//     data['discount'] = this.discount;
//     data['details'] = this.details;
//     data['quantity'] = this.quantity;
//     data['sub_category_id'] = this.subCategoryId;
//     data['category_id'] = this.categoryId;
//     data['is_active'] = this.isActive;
//     data['store_id'] = this.storeId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['images'] = this.images;
//     data['hasFavorites'] = this.hasFavorites;
//     data['ReviewRate'] = this.reviewRate;
//     data['ReviewComment'] = this.reviewComment;
//     data['hasReviews'] = this.hasReviews;
//     return data;
//   }
// }


class MYProductDetailsModel {
  bool status;
  String errNum;
  String msg;
  MYProductDetailsData data;

  MYProductDetailsModel({this.status, this.errNum, this.msg, this.data});

  MYProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data =   MYProductDetailsData.fromJson(json['Data']) ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class MYProductDetailsData {
  int numberOfTimesToBuy;
  List<ProductDetails> productDetails;
  List<ProductDetails> relatedProducts;
  String productUrl;

  MYProductDetailsData(
      {this.numberOfTimesToBuy,
        this.productDetails,
        this.relatedProducts,
        this.productUrl});

  MYProductDetailsData.fromJson(Map<String, dynamic> json) {
    numberOfTimesToBuy = json['Number-of-times-to-buy'];
    if (json['Product-Details'] != null) {
      productDetails = <ProductDetails>[];
      json['Product-Details'].forEach((v) {
        productDetails.add(new ProductDetails.fromJson(v));
      });
    }
    if (json['Related Products'] != null) {
      relatedProducts = <ProductDetails>[];
      json['Related Products'].forEach((v) {
        relatedProducts.add(new ProductDetails.fromJson(v));
      });
    }
    productUrl = json['productUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Number-of-times-to-buy'] = this.numberOfTimesToBuy;
    if (this.productDetails != null) {
      data['Product-Details'] =
          this.productDetails.map((v) => v.toJson()).toList();
    }
    if (this.relatedProducts != null) {
      data['Related Products'] =
          this.relatedProducts.map((v) => v.toJson()).toList();
    }
    data['productUrl'] = this.productUrl;
    return data;
  }
}

class ProductDetails {
  int id;
  String name;
  int price;
  int discount;
  String details;
  String quantity;
  int subCategoryId;
  int categoryId;
  int isActive;
  int storeId;
  String createdAt;
  String updatedAt;
  String images;

  ProductDetails(
      {this.id,
        this.name,
        this.price,
        this.discount,
        this.details,
        this.quantity,
        this.subCategoryId,
        this.categoryId,
        this.isActive,
        this.storeId,
        this.createdAt,
        this.updatedAt,
        this.images});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    details = json['details'];
    quantity = json['quantity'];
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    isActive = json['is_active'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['details'] = this.details;
    data['quantity'] = this.quantity;
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['is_active'] = this.isActive;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['images'] = this.images;
    return data;
  }
}

class ConstructionLinkModel {
  bool? status;
  String? errNum;
  String? msg;
  Content? data;
  ConstructionLinkModel({
    this.status,
    this.errNum,
    this.msg,
    this.data,
  });

  ConstructionLinkModel.fromJson(Map<String,dynamic> json) {

    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? Content.fromJson(json['data']) : null;
  }

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['status'] = this.status;
  data['errNum'] = this.errNum;
  data['msg'] = this.msg;
  if (this.data != null) {
    data['data'] = this.data!.toJson();
  }
  return data;
}

}

class Content {
  String? offerImage;
  String? videoLink;
  List<ProductList>? productList;
  int? orderId;
  String? inspirationImage;

  Content({
    this.offerImage,
    this.videoLink,
    this.productList,
    this.orderId,
    this.inspirationImage,
  });

  Content.fromJson(Map<String,dynamic> json) {
    offerImage = json['offerImage'];
    videoLink = json['videoLink'];
    orderId = json['order_id'];
    inspirationImage = json['insp_mop_img'];
    if (json['product_list'] != null) {
      productList = [];
      json['product_list'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
  }

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['offerImage'] = this.offerImage;
  data['videoLink'] = this.videoLink;
  data['order_id'] = this.orderId;
  data['insp_mop_img'] = this.inspirationImage;
  if (this.productList != null) {
    data['product_list'] = this.productList!.map((v) => v.toJson()).toList();
  }
  return data;
}
}

class ProductList {
  int? id;
  String? name;
  String? nameSearch;
  var oldPrice;
  var currentPrice;
  String? details;
  String? quantity;
  int? subCategoryId;
  int? categoryId;
  int? isActive;
  int? storeId;
  String? createdAt;
  String? updatedAt;
  String? image;
  int? hasFavorites;
  String? hasReview;

  ProductList({
    this.id,
    this.name,
    this.nameSearch,
    this.oldPrice,
    this.currentPrice,
    this.details,
    this.quantity,
    this.subCategoryId,
    this.categoryId,
    this.isActive,
    this.storeId,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.hasFavorites,
    this.hasReview,
  });

  ProductList.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    name = json['name'];
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
    hasReview = json['hasReviews'].toString();
  }

Map<String, dynamic> toJson() {
  final map = <String, dynamic>{};
  map['id'] = id;
  map['name'] = name;
  map['name_search'] = nameSearch;
  map['old_price'] = oldPrice;
  map['current_price'] = currentPrice;
  map['details'] = details;
  map['quantity'] = quantity;
  map['sub_category_id'] = subCategoryId;
  map['category_id'] = categoryId;
  map['is_active'] = isActive;
  map['store_id'] = storeId;
  map['created_at'] = createdAt;
  map['updated_at'] = updatedAt;
  map['image'] = image;
  map['hasFavorites'] = hasFavorites;
  map['hasReviews'] = hasReview;
  return map;
}
}

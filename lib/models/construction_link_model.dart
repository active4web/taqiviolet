class ConstructionLinkModel {
  ConstructionLinkModel({
    this.status,
    this.errNum,
    this.msg,
    this.data,
  });

  ConstructionLinkModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? Content.fromJson(json['data']) : null;
  }
  bool status;
  String errNum;
  String msg;
  Content data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data.toJson();
    }
    return map;
  }
}

class Content {
  Content({
    this.offerImage,
    this.videoLink,
    this.productList,
  });

  Content.fromJson(dynamic json) {
    offerImage = json['offerImage'];
    videoLink = json['videoLink'];
    if (json['product_list'] != null) {
      productList = [];
      json['product_list'].forEach((v) {
        productList.add(ProductList.fromJson(v));
      });
    }
  }
  String offerImage;
  String videoLink;
  List<ProductList> productList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offerImage'] = offerImage;
    map['videoLink'] = videoLink;
    if (productList != null) {
      map['product_list'] = productList.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProductList {
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

  ProductList.fromJson(dynamic json) {
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
  int id;
  String name;
  String nameSearch;
  num oldPrice;
  num currentPrice;
  String details;
  String quantity;
  int subCategoryId;
  int categoryId;
  int isActive;
  int storeId;
  String createdAt;
  String updatedAt;
  String image;
  int hasFavorites;
  String hasReview;

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

class SearchResultsModel {
  SearchResultsModel({
    this.status,
    this.errNum,
    this.msg,
    this.data,
  });

  SearchResultsModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(ResultData.fromJson(v));
      });
    }
  }
  bool? status;
  String? errNum;
  String? msg;
  List<ResultData>? data;

/*  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }*/
}

class ResultData {
  ResultData({
    this.id,
    this.name,
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
    this.reviewRate,
  });

  ResultData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
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
    reviewRate = json['ReviewRate'];
  }
  int? id;
  String? name;
  int? oldPrice;
  int? currentPrice;
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
  String? reviewRate;

/*  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = oldPrice;
    map['discount'] = currentPrice;
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
    map['ReviewRate'] = reviewRate;
    return map;
  }*/
}

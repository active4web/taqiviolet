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
        data.add(ResultData.fromJson(v));
      });
    }
  }
  bool status;
  String errNum;
  String msg;
  List<ResultData> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ResultData {
  ResultData({
    this.id,
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
    this.images,
  });

  ResultData.fromJson(dynamic json) {
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
  int id;
  String name;
  int price;
  dynamic discount;
  String details;
  String quantity;
  dynamic subCategoryId;
  int categoryId;
  int isActive;
  int storeId;
  String createdAt;
  String updatedAt;
  String images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['discount'] = discount;
    map['details'] = details;
    map['quantity'] = quantity;
    map['sub_category_id'] = subCategoryId;
    map['category_id'] = categoryId;
    map['is_active'] = isActive;
    map['store_id'] = storeId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['images'] = images;
    return map;
  }
}

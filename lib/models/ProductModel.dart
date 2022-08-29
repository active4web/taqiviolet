class ProductFromCatModel {
  ProductFromCatModel({
    this.status,
    this.errNum,
    this.msg,
    this.data,
  });

  ProductFromCatModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(DataProduct.fromJson(v));
      });
    }
  }
  bool status;
  String errNum;
  String msg;
  List<DataProduct> data;

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

class DataProduct {
  DataProduct({
    this.id,
    this.name,
    this.nameSearch,
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
    this.image,
  });

  DataProduct.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    nameSearch = json['name_search'];
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
    image = json['image'];
  }
  num id;
  String name;
  String nameSearch;
  num price;
  num discount;
  String details;
  String quantity;
  num subCategoryId;
  num categoryId;
  num isActive;
  num storeId;
  String createdAt;
  String updatedAt;
  String image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['name_search'] = nameSearch;
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
    map['image'] = image;
    return map;
  }
}

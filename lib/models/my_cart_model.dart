class MyCartModel {
  bool status;
  String errNum;
  String msg;
  List<MyCartData> data;

  MyCartModel({this.status, this.errNum, this.msg, this.data});

  MyCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <MyCartData>[];
      json['data'].forEach((v) {
        data.add(new MyCartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyCartData {
  int id;
  String name;
  int price;
  int discount;
  String details;
  int quantity;
  int subCategoryId;
  int categoryId;
  int isActive;
  int storeId;
  String createdAt;
  String updatedAt;
  String images;
  int hasFavorites;
  int hasRosters;
  String reviewRate;
  String reviewComment;
  int hasReviews;

  MyCartData(
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
        this.images,
        this.hasFavorites,
        this.hasRosters,
        this.reviewRate,
        this.reviewComment,
        this.hasReviews});

  MyCartData.fromJson(Map<String, dynamic> json) {
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
    hasFavorites = json['hasFavorites'];
    hasRosters = json['hasRosters'];
    reviewRate = json['ReviewRate'];
    reviewComment = json['ReviewComment'];
    hasReviews = json['hasReviews'];
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
    data['hasFavorites'] = this.hasFavorites;
    data['hasRosters'] = this.hasRosters;
    data['ReviewRate'] = this.reviewRate;
    data['ReviewComment'] = this.reviewComment;
    data['hasReviews'] = this.hasReviews;
    return data;
  }
}

class OfferProductsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  OfferProductsModel({this.status, this.errNum, this.msg, this.data});

  OfferProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

/*
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
*/
}

class Data {
  int? id;
  String? name;
  String? nameSearch;
  int? oldPrice;
  int? currentPrice;
  String? smartPrice;
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
  int? hasRosters;
  String? hasReviews;
  String? reviewComment;

  Data(
      {this.id,
      this.name,
      this.nameSearch,
      this.oldPrice,
      this.currentPrice,
      this.smartPrice,
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
      this.hasRosters,
      this.hasReviews,
      this.reviewComment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameSearch = json['name_search'];
    oldPrice = json['old_price'];
    currentPrice = json['current_price'];
    smartPrice = json['smart_price'];
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
    reviewComment = json['ReviewComment'];
  }

/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_search'] = this.nameSearch;
    data['old_price'] = this.oldPrice;
    data['current_price'] = this.currentPrice;
    data['smart_price'] = this.smartPrice;
    data['details'] = this.details;
    data['quantity'] = this.quantity;
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['is_active'] = this.isActive;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['hasFavorites'] = this.hasFavorites;
    data['hasRosters'] = this.hasRosters;
    data['hasReviews'] = this.hasReviews;
    data['ReviewComment'] = this.reviewComment;
    return data;
  }
*/
}

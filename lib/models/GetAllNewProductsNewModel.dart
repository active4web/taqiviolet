class GetAllNewProductsNewModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  GetAllNewProductsNewModel({this.status, this.errNum, this.msg, this.data});

  GetAllNewProductsNewModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic nameSearch;
  dynamic oldPrice;
  dynamic currentPrice;
  dynamic smartPrice;
  dynamic details;
  dynamic quantity;
  dynamic subCategoryId;
  dynamic categoryId;
  dynamic isActive;
  dynamic storeId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic image;
  dynamic altText;
  dynamic titleImg;
  dynamic slug;
  dynamic serialNo;
  dynamic taxAmount;
  dynamic deliveryTime;
  dynamic commissionClassA;
  dynamic commissionClassB;
  dynamic commissionClassC;
  dynamic hasFavorites;
  dynamic hasRosters;
  dynamic hasReviews;
  dynamic reviewComment;

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
        this.altText,
        this.titleImg,
        this.slug,
        this.serialNo,
        this.taxAmount,
        this.deliveryTime,
        this.commissionClassA,
        this.commissionClassB,
        this.commissionClassC,
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
    altText = json['alt_text'];
    titleImg = json['title_img'];
    slug = json['slug'];
    serialNo = json['serial_no'];
    taxAmount = json['tax_amount'];
    deliveryTime = json['delivery_time'];
    commissionClassA = json['commission_class_A'];
    commissionClassB = json['commission_class_B'];
    commissionClassC = json['commission_class_C'];
    hasFavorites = json['hasFavorites'];
    hasRosters = json['hasRosters'];
    hasReviews = json['hasReviews'];
    reviewComment = json['ReviewComment'];
  }

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
    data['alt_text'] = this.altText;
    data['title_img'] = this.titleImg;
    data['slug'] = this.slug;
    data['serial_no'] = this.serialNo;
    data['tax_amount'] = this.taxAmount;
    data['delivery_time'] = this.deliveryTime;
    data['commission_class_A'] = this.commissionClassA;
    data['commission_class_B'] = this.commissionClassB;
    data['commission_class_C'] = this.commissionClassC;
    data['hasFavorites'] = this.hasFavorites;
    data['hasRosters'] = this.hasRosters;
    data['hasReviews'] = this.hasReviews;
    data['ReviewComment'] = this.reviewComment;
    return data;
  }
}

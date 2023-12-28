class DataInListModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  DataInListModel({this.status, this.errNum, this.msg, this.data});

  DataInListModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

// Map<String?, dynamic> toJson() {
//   final Map<String?, dynamic> data = new Map<String?, dynamic>();
//   data['status'] = this.status;
//   data['errNum'] = this.errNum;
//   data['msg'] = this.msg;
//   if (this.data != null) {
//     data['data'] = this.data.toJson();
//   }
//   return data;
// }
}

class Data {
  Roster? roster;
  List<Products>? products;

  Data({this.roster, this.products});

  Data.fromJson(Map<String?, dynamic> json) {
    roster = new Roster.fromJson(json['Roster']);
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

// Map<String?, dynamic> toJson() {
//   final Map<String?, dynamic> data = new Map<String?, dynamic>();
//   if (this.roster != null) {
//     data['Roster'] = this.roster.toJson();
//   }
//   if (this.products != null) {
//     data['products'] = this.products.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}

class Roster {
  int? id;
  int? clientId;
  String? name;
  String? link;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  Roster(
      {this.id,
      this.clientId,
      this.name,
      this.link,
      this.createdAt,
      this.updatedAt,
      this.items});

  Roster.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    name = json['name'];
    link = json['link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

// Map<String?, dynamic> toJson() {
//   final Map<String?, dynamic> data = new Map<String?, dynamic>();
//   data['id'] = this.id;
//   data['client_id'] = this.clientId;
//   data['name'] = this.name;
//   data['link'] = this.link;
//   data['created_at'] = this.createdAt;
//   data['updated_at'] = this.updatedAt;
//   if (this.items != null) {
//     data['items'] = this.items.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}

class Items {
  int? id;
  int? rosterId;
  int? productId;
  String? createdAt;
  String? updatedAt;

  Items(
      {this.id, this.rosterId, this.productId, this.createdAt, this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rosterId = json['roster_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

// Map<String?, dynamic> toJson() {
//   final Map<String?, dynamic> data = new Map<String?, dynamic>();
//   data['id'] = this.id;
//   data['roster_id'] = this.rosterId;
//   data['product_id'] = this.productId;
//   data['created_at'] = this.createdAt;
//   data['updated_at'] = this.updatedAt;
//   return data;
// }
}

class Products {
  int? id;
  String? name;
  int? price;
  int? discount;
  String? details;
  String? quantity;
  int? subCategoryId;
  int? categoryId;
  int? isActive;
  int? storeId;
  String? createdAt;
  String? updatedAt;
  String? images;
  int? hasFavorites;
  int? hasRosters;
  int? hasReviews;
  String? reviewRate;
  String? reviewComment;

  Products(
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
      this.hasReviews,
      this.reviewRate,
      this.reviewComment});

  Products.fromJson(Map<String?, dynamic> json) {
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
    hasReviews = json['hasReviews'];
    reviewRate = json['ReviewRate'];
    reviewComment = json['ReviewComment'];
  }

// Map<String?, dynamic> toJson() {
//   final Map<String?, dynamic> data = new Map<String?, dynamic>();
//   data['id'] = this.id;
//   data['name'] = this.name;
//   data['price'] = this.price;
//   data['discount'] = this.discount;
//   data['details'] = this.details;
//   data['quantity'] = this.quantity;
//   data['sub_category_id'] = this.subCategoryId;
//   data['category_id'] = this.categoryId;
//   data['is_active'] = this.isActive;
//   data['store_id'] = this.storeId;
//   data['created_at'] = this.createdAt;
//   data['updated_at'] = this.updatedAt;
//   data['images'] = this.images;
//   data['hasFavorites'] = this.hasFavorites;
//   data['hasRosters'] = this.hasRosters;
//   data['hasReviews'] = this.hasReviews;
//   data['ReviewRate'] = this.reviewRate;
//   data['ReviewComment'] = this.reviewComment;
//   return data;
// }
}

class FavoritesModel {
  bool status;
  String errNum;
  String msg;
  Data data;

  FavoritesModel({this.status, this.errNum, this.msg, this.data});

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<FavsListModel> list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<FavsListModel>();
      json['list'].forEach((v) {
        list.add(new FavsListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavsListModel {
  String listName;
  int listId;
  List<ListProducts> listProducts;

  FavsListModel({this.listName, this.listId, this.listProducts});

  FavsListModel.fromJson(Map<String, dynamic> json) {
    listName = json['list_name'];
    listId = json['list_id'];
    if (json['list_products'] != null) {
      listProducts = new List<ListProducts>();
      json['list_products'].forEach((v) {
        listProducts.add(new ListProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list_name'] = this.listName;
    data['list_id'] = this.listId;
    if (this.listProducts != null) {
      data['list_products'] = this.listProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListProducts {
  String name;
  num oldPrice;
  int id;
  String image;
  int subCategoryId;
  num currentPrice;
  int storeId;
  int smartPrice;
  String quantity;
  String details;
  int hasFavorites;
  int hasRosters;
  String hasReviews;

  ListProducts(
      {this.name,
      this.oldPrice,
      this.id,
      this.image,
      this.subCategoryId,
      this.currentPrice,
      this.storeId,
      this.smartPrice,
      this.quantity,
      this.details,
      this.hasFavorites,
      this.hasRosters,
      this.hasReviews});

  ListProducts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    oldPrice = json['old_price'];
    id = json['id'];
    image = json['image'];
    subCategoryId = json['sub_category_id'];
    currentPrice = json['current_price'];
    storeId = json['store_id'];
    smartPrice = json['smart_price'];
    quantity = json['quantity'];
    details = json['details'];
    hasFavorites = json['hasFavorites'];
    hasRosters = json['hasRosters'];
    hasReviews = json['hasReviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['old_price'] = this.oldPrice;
    data['id'] = this.id;
    data['image'] = this.image;
    data['sub_category_id'] = this.subCategoryId;
    data['current_price'] = this.currentPrice;
    data['store_id'] = this.storeId;
    data['smart_price'] = this.smartPrice;
    data['quantity'] = this.quantity;
    data['details'] = this.details;
    data['hasFavorites'] = this.hasFavorites;
    data['hasRosters'] = this.hasRosters;
    data['hasReviews'] = this.hasReviews;
    return data;
  }
}

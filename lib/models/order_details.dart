class OrderDetails {
  bool status;
  String errNum;
  String msg;
  List<Data> data;

  OrderDetails({this.status, this.errNum, this.msg, this.data});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  Name name;
  String price;
  String discount;
  Name details;
  String quantity;
  int subCategoryId;
  int categoryId;
  int isActive;
  int storeId;
  String createdAt;
  String updatedAt;

  Data(
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
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name =   Name.fromJson(json['name'])  ;
    price = json['price'];
    discount = json['discount'];
    details =
     Name.fromJson(json['details'])  ;
    quantity = json['quantity'];
    subCategoryId = json['sub_category_id'];
    categoryId = json['category_id'];
    isActive = json['is_active'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['price'] = this.price;
    data['discount'] = this.discount;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['quantity'] = this.quantity;
    data['sub_category_id'] = this.subCategoryId;
    data['category_id'] = this.categoryId;
    data['is_active'] = this.isActive;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Name {
  String en;
  String ar;
  String it;

  Name({this.en, this.ar, this.it});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
    it = json['it'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    data['it'] = this.it;
    return data;
  }
}

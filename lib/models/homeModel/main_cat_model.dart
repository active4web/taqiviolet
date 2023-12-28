class HomeScreenMainCatModel {
  bool? status;
  String? errNum;
  Msg? msg;
  List<Data>? data;

  HomeScreenMainCatModel({this.status, this.errNum, this.msg, this.data});

  HomeScreenMainCatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'] != null ? new Msg.fromJson(json['msg']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

}

class Data {
  int? id;
  String? name;
  String? image;
  String? imageMop;
  String? description;
  num? isActive;
  String? createdAt;
  String? updatedAt;
  num? storeId;
  num? hasSubCategories;

  Data(
      {this.id,
        this.name,
        this.image,
        this.imageMop,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.storeId,
        this.hasSubCategories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    imageMop = json['image_mop'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storeId = json['store_id'];
    hasSubCategories = json['hasSubCategories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['image_mop'] = this.imageMop;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['store_id'] = this.storeId;
    data['hasSubCategories'] = this.hasSubCategories;
    return data;
  }
}

class Msg {
  num? maxPrice;
  num? minPrice;

  Msg({this.maxPrice, this.minPrice});

  Msg.fromJson(Map<String, dynamic> json) {
    maxPrice = json['max_price'];
    minPrice = json['min_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max_price'] = this.maxPrice;
    data['min_price'] = this.minPrice;
    return data;
  }
}
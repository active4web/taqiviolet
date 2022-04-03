class HomeScreenMainCatModel {
  bool status;
  String errNum;
  String msg;
  List<Data> data;

  HomeScreenMainCatModel({this.status, this.errNum, this.msg, this.data});

  HomeScreenMainCatModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  String image;
  String description;
  int isActive;
  String createdAt;
  String updatedAt;
  int storeId;
  int hasSubCategories;

  Data(
      {
        this.hasSubCategories,
        this.id,
        this.name,
        this.image,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.storeId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    storeId = json['store_id'];
    hasSubCategories=json["hasSubCategories"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['store_id'] = this.storeId;
    data["hasSubCategories"]=this.hasSubCategories;
    return data;
  }
}

class SubCatDataModel {
  bool status;
  String errNum;
  String msg;
  List<SubCatData> date;

  SubCatDataModel({this.status, this.errNum, this.msg, this.date});

  SubCatDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['date'] != null) {
      date = <SubCatData>[];
      json['date'].forEach((v) {
        date.add(new SubCatData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.date != null) {
      data['date'] = this.date.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCatData {
  int id;
  String name;
  String details;
  String image;
  int categoryId;
  int isActive;
  int storeId;
  String createdAt;
  String updatedAt;

  SubCatData(
      {this.id,
        this.name,
        this.details,
        this.image,
        this.categoryId,
        this.isActive,
        this.storeId,
        this.createdAt,
        this.updatedAt});

  SubCatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    image = json['image'];
    categoryId = json['category_id'];
    isActive = json['is_active'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['is_active'] = this.isActive;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

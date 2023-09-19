class GetdataprofileModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  GetdataprofileModel({this.status, this.errNum, this.msg, this.data});

  GetdataprofileModel.fromJson(Map<String, dynamic> json) {
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
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? firebaseId;
  String? lang;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? isActive;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.address,
        this.firebaseId,
        this.lang,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    firebaseId = json['firebase_id'];
    lang = json['lang'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['firebase_id'] = this.firebaseId;
    data['lang'] = this.lang;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    return data;
  }
}

class SendContactUsModel {
  SendContactUsModel({
    this.status,
    this.errNum,
    this.msg,
    this.data,
  });

  SendContactUsModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool status;
  String errNum;
  String msg;
  Data data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.name,
    this.phone,
    this.message,
    this.type,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data.fromJson(dynamic json) {
    name = json['name'];
    phone = json['phone'];
    message = json['message'];
    type = json['type'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String name;
  String phone;
  String message;
  int type;
  String email;
  String updatedAt;
  String createdAt;
  int id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    map['message'] = message;
    map['type'] = type;
    map['email'] = email;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }
}

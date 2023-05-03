class RegisterSuccessModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  RegisterSuccessModel({this.status, this.errNum, this.msg, this.data});

  RegisterSuccessModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? id;
  String? email;
  String? phone;
  String? lang;
  String? address;
  String? token;

  Data(
      {this.name,
        this.id,
        this.email,
        this.phone,
        this.lang,
        this.address,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    lang = json['lang'];
    address = json['address'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['lang'] = this.lang;
    data['address'] = this.address;
    data['token'] = this.token;
    return data;
  }
}
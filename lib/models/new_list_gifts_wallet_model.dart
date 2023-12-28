class NewListGiftsWalletModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  NewListGiftsWalletModel({this.status, this.errNum, this.msg, this.data});

  NewListGiftsWalletModel.fromJson(Map<String, dynamic> json) {
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
  List<Listgiftwallets>? listgiftwallets;

  Data({this.listgiftwallets});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['listgiftwallets'] != null) {
      listgiftwallets = <Listgiftwallets>[];
      json['listgiftwallets'].forEach((v) {
        listgiftwallets!.add(new Listgiftwallets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listgiftwallets != null) {
      data['listgiftwallets'] =
          this.listgiftwallets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listgiftwallets {
  int? iD;
  String? phone;
  String? price;
  String? image;
  String? message;
  String? name;
  int? clientId;

  Listgiftwallets(
      {this.iD,
        this.phone,
        this.price,
        this.name,
        this.image,
        this.message,
        this.clientId});

  Listgiftwallets.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    phone = json['phone'];
    name = json['sender_name'];
    price = json['price'];
    image = json['Image'];
    message = json['message'];
    clientId = json['client_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['sender_name'] = this.name;
    data['phone'] = this.phone;
    data['price'] = this.price;
    data['Image'] = this.image;
    data['message'] = this.message;
    data['client_id'] = this.clientId;
    return data;
  }
}

class MyCartModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  MyCartModel({this.status, this.errNum, this.msg, this.data});

  MyCartModel.fromJson(Map<String, dynamic> json) {
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
  int? cashback;
  int? totalCoupons;
  int? totalGft;
  List<ListItem>? listItem;

  Data({this.cashback, this.listItem ,this.totalCoupons,this.totalGft});

  Data.fromJson(Map<String, dynamic> json) {
    cashback = json['cashback'];
    totalCoupons = json['total_coupons'];
    totalGft = json['total_gift'];
    if (json['list_item'] != null) {
      listItem = <ListItem>[];
      json['list_item'].forEach((v) {
        listItem!.add(new ListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cashback'] = this.cashback;
    data['total_gift'] = this.totalGft;
    data['total_coupons'] = this.totalCoupons;
    if (this.listItem != null) {
      data['list_item'] = this.listItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListItem {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic quantity;
  dynamic cardId;
  dynamic smartPrice;
  dynamic price;
  dynamic features;

  ListItem(
      {this.id,
        this.name,
        this.image,
        this.quantity,
        this.cardId,
        this.smartPrice,
        this.price,
        this.features});

  ListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    cardId = json['card_id'];
    smartPrice = json['smart_price'];
    price = json['price'];
    features = json['features'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['card_id'] = this.cardId;
    data['smart_price'] = this.smartPrice;
    data['price'] = this.price;
    data['features'] = this.features;
    return data;
  }
}

class MyCartModel {
  bool status;
  String errNum;
  String msg;
  CartData data;

  MyCartModel({this.status, this.errNum, this.msg, this.data});

  MyCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new CartData.fromJson(json['data']) : null;
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

class CartData {
  num cashback;
  List<CartListItems> listItem;

  CartData({this.cashback, this.listItem});

  CartData.fromJson(Map<String, dynamic> json) {
    cashback = json['cashback'];
    if (json['list_item'] != null) {
      listItem = new List<CartListItems>();
      json['list_item'].forEach((v) {
        listItem.add(new CartListItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cashback'] = this.cashback;
    if (this.listItem != null) {
      data['list_item'] = this.listItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartListItems {
  int id;
  String name;
  String image;
  int quantity;
  num price;
  String features;

  CartListItems(
      {this.id,
      this.name,
      this.image,
      this.quantity,
      this.price,
      this.features});

  CartListItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    features = json['features'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['features'] = this.features;
    return data;
  }
}

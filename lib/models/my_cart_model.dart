class MyCartModel {
  dynamic
  status;
  dynamic errNum;
  dynamic msg;
  GetData? data;

  MyCartModel({this.status, this.errNum, this.msg, this.data});

  MyCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new GetData.fromJson(json['data']) : null;
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

class GetData {
  dynamic cashback;
  List<ListItem>? listItem;

  GetData({this.cashback, this.listItem});

  GetData.fromJson(Map<String, dynamic> json) {
    cashback = json['cashback'];
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
    if (this.listItem != null) {
      data['list_item'] = this.listItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListItem {
  int? id;
  dynamic name;
  dynamic image;
  dynamic quantity;
  dynamic smartPrice;
  dynamic price;
  dynamic features;

  ListItem(
      {this.id,
        this.name,
        this.image,
        this.quantity,
        this.smartPrice,
        this.price,
        this.features});

  ListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
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
    data['smart_price'] = this.smartPrice;
    data['price'] = this.price;
    data['features'] = this.features;
    return data;
  }
}

class DetailsMyListModel {
  bool? status;
  dynamic errNum;
  dynamic msg;
  Data? data;

  DetailsMyListModel({this.status, this.errNum, this.msg, this.data});

  DetailsMyListModel.fromJson(Map<String, dynamic> json) {
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
  List<ListProducts>? listProducts;

  Data({this.listProducts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list_products'] != null) {
      listProducts = <ListProducts>[];
      json['list_products'].forEach((v) {
        listProducts!.add(new ListProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listProducts != null) {
      data['list_products'] =
          this.listProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListProducts {
  dynamic name;
  dynamic oldPrice;
  dynamic id;
  dynamic image;
  dynamic currentPrice;
  dynamic smartPrice;
  dynamic quantity;

  ListProducts(
      {this.name,
        this.oldPrice,
        this.id,
        this.image,
        this.currentPrice,
        this.smartPrice,
        this.quantity});

  ListProducts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    oldPrice = json['old_price'];
    id = json['id'];
    image = json['image'];
    currentPrice = json['current_price'];
    smartPrice = json['smart_price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['old_price'] = this.oldPrice;
    data['id'] = this.id;
    data['image'] = this.image;
    data['current_price'] = this.currentPrice;
    data['smart_price'] = this.smartPrice;
    data['quantity'] = this.quantity;
    return data;
  }
}

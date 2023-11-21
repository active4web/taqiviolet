class CartProductsPricesModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  CartProductsPricesModel({this.status, this.errNum, this.msg, this.data});

  CartProductsPricesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['Data'] = this.data?.toJson();
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
    final listProducts = this.listProducts;
    if (listProducts != null) {
      data['list_products'] = listProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListProducts {
  String? quantity;
  dynamic currentPrice;
  dynamic oldPrice;
  int? id;
  dynamic smartPrice;

  ListProducts(
      {this.quantity,
      this.currentPrice,
      this.oldPrice,
      this.id,
      this.smartPrice});

  ListProducts.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    currentPrice = json['current_price'];
    oldPrice = json['old_price'];
    id = json['id'];
    smartPrice = json['smart_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['current_price'] = this.currentPrice;
    data['old_price'] = this.oldPrice;
    data['id'] = this.id;
    data['smart_price'] = this.smartPrice;
    return data;
  }
}

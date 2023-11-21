class InventoryModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  InventoryModel({this.status, this.errNum, this.msg, this.data});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? image;
  int? productId;
  String? productName;
  int? productOldPrice;
  double? productCurrentPrice;
  String? productQuantity;
  String? productQuantityOrignal;
  int? productSerialNo;
  int? productQuantitySold;

  Data(
      {this.image,
        this.productId,
        this.productName,
        this.productOldPrice,
        this.productCurrentPrice,
        this.productQuantity,
        this.productSerialNo,
        this.productQuantityOrignal,
        this.productQuantitySold});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    productId = json['product_id'];
    productName = json['product_name'];
    productOldPrice = json['product_old_price'];
    productCurrentPrice = json['product_current_price'];
    productQuantity = json['product_quantity'];
    productSerialNo = json['product_serial_no'];
    productQuantitySold = json['product_quantity_sold'];
    productQuantityOrignal = json['product_quantity_orignal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_old_price'] = this.productOldPrice;
    data['product_current_price'] = this.productCurrentPrice;
    data['product_quantity'] = this.productQuantity;
    data['product_serial_no'] = this.productSerialNo;
    data['product_quantity_sold'] = this.productQuantitySold;
    data['product_quantity_orignal'] = this.productQuantityOrignal;
    return data;
  }
}
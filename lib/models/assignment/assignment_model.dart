class AssignmentModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  AssignmentModel({this.status, this.errNum, this.msg, this.data});

  AssignmentModel.fromJson(Map<String, dynamic> json) {
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
  num? productId;
  String? productName;
  num? tax;
  num? insurance;
  num? zakat;
  num? profitProduct;
  num? visaPercentage;
  num? discount;
  num? shipping;
  num? developement;
  num? advertising;
  num? productOldPrice;
  num? productCurrentPrice;
  String? productQuantity;
  String? productQuantityOrignal;
  String? productSerialNo;
  num? productQuantitySold;

  Data(
      {this.image,
        this.productId,
        this.productName,
        this.tax,
        this.insurance,
        this.zakat,
        this.profitProduct,
        this.visaPercentage,
        this.discount,
        this.shipping,
        this.developement,
        this.advertising,
        this.productOldPrice,
        this.productCurrentPrice,
        this.productQuantity,
        this.productQuantityOrignal,
        this.productSerialNo,
        this.productQuantitySold});

  Data.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    productId = json['product_id'];
    productName = json['product_name'];
    tax = json['tax'];
    insurance = json['insurance'];
    zakat = json['zakat'];
    profitProduct = json['profit_product'];
    visaPercentage = json['visa_percentage'];
    discount = json['discount'];
    shipping = json['shipping'];
    developement = json['developement'];
    advertising = json['advertising'];
    productOldPrice = json['product_old_price'];
    productCurrentPrice = json['product_current_price'];
    productQuantity = json['product_quantity'];
    productQuantityOrignal = json['product_quantity_orignal'];
    productSerialNo = json['product_serial_no'];
    productQuantitySold = json['product_quantity_sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['tax'] = this.tax;
    data['insurance'] = this.insurance;
    data['zakat'] = this.zakat;
    data['profit_product'] = this.profitProduct;
    data['visa_percentage'] = this.visaPercentage;
    data['discount'] = this.discount;
    data['shipping'] = this.shipping;
    data['developement'] = this.developement;
    data['advertising'] = this.advertising;
    data['product_old_price'] = this.productOldPrice;
    data['product_current_price'] = this.productCurrentPrice;
    data['product_quantity'] = this.productQuantity;
    data['product_quantity_orignal'] = this.productQuantityOrignal;
    data['product_serial_no'] = this.productSerialNo;
    data['product_quantity_sold'] = this.productQuantitySold;
    return data;
  }
}
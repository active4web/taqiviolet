class ListRequestModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  ListRequestModel({this.status, this.errNum, this.msg, this.data});

  ListRequestModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? details;
  int? isActive;
  int? clientId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  int? status;
  String? image;
  String? productName;
  num? productOldPrice;
  num? productCurrentPrice;
  String? productQuantity;
  String? productSerialNo;
  List<dynamic>? featurName;
  List<dynamic>? featurDescription;

  Data(
      {this.id,
        this.details,
        this.isActive,
        this.clientId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.image,
        this.productName,
        this.productOldPrice,
        this.productCurrentPrice,
        this.productQuantity,
        this.productSerialNo,
        this.featurName,
        this.featurDescription});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    isActive = json['is_active'];
    clientId = json['client_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    image = json['image'];
    productName = json['product_name'];
    productOldPrice = json['product_old_price'];
    productCurrentPrice = json['product_current_price'];
    productQuantity = json['product_quantity'];
    productSerialNo = json['product_serial_no'];
    featurName = json['featur_name'];
    featurDescription = json['featur_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details;
    data['is_active'] = this.isActive;
    data['client_id'] = this.clientId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['image'] = this.image;
    data['product_name'] = this.productName;
    data['product_old_price'] = this.productOldPrice;
    data['product_current_price'] = this.productCurrentPrice;
    data['product_quantity'] = this.productQuantity;
    data['product_serial_no'] = this.productSerialNo;
    data['featur_name'] = this.featurName;
    data['featur_description'] = this.featurDescription;
    return data;
  }
}
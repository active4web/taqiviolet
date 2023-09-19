class MakeOrderNewNewNewModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  MakeOrderNewNewNewModel({this.status, this.errNum, this.msg, this.data});

  MakeOrderNewNewNewModel.fromJson(Map<String, dynamic> json) {
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
  dynamic codeOrder;
  dynamic clientId;
  dynamic paymentStatus;
  dynamic paymentType;
  dynamic promoCodeId;
  dynamic status;
  dynamic subTotal;
  dynamic total;
  dynamic deliveryCost;
  dynamic username;
  dynamic userphone;
  dynamic storeId;
  dynamic countryId;
  dynamic cityId;
  dynamic address;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;

  Data(
      {this.codeOrder,
        this.clientId,
        this.paymentStatus,
        this.paymentType,
        this.promoCodeId,
        this.status,
        this.subTotal,
        this.total,
        this.deliveryCost,
        this.username,
        this.userphone,
        this.storeId,
        this.countryId,
        this.cityId,
        this.address,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    codeOrder = json['code_order'];
    clientId = json['client_id'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    promoCodeId = json['promo_code_id'];
    status = json['status'];
    subTotal = json['sub_total'];
    total = json['total'];
    deliveryCost = json['delivery_cost'];
    username = json['username'];
    userphone = json['userphone'];
    storeId = json['store_id'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    address = json['address'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_order'] = this.codeOrder;
    data['client_id'] = this.clientId;
    data['payment_status'] = this.paymentStatus;
    data['payment_type'] = this.paymentType;
    data['promo_code_id'] = this.promoCodeId;
    data['status'] = this.status;
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    data['delivery_cost'] = this.deliveryCost;
    data['username'] = this.username;
    data['userphone'] = this.userphone;
    data['store_id'] = this.storeId;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

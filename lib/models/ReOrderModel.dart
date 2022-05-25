class ReOrderModel {
  bool status;
  String errNum;
  String msg;
  List<ReOrderData> data;

  ReOrderModel({this.status, this.errNum, this.msg, this.data});

  ReOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ReOrderData>[];
      json['data'].forEach((v) {
        data.add(new ReOrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReOrderData {
  int id;
  String codeOrder;
  int clientId;
  int storeId;
  int addressId;
  Null promoCodeId;
  int deliveryCost;
  int subTotal;
  int total;
  String status;
  String paymentStatus;
  String paymentType;
  int isActive;
  String createdAt;
  String updatedAt;

  ReOrderData(
      {this.id,
        this.codeOrder,
        this.clientId,
        this.storeId,
        this.addressId,
        this.promoCodeId,
        this.deliveryCost,
        this.subTotal,
        this.total,
        this.status,
        this.paymentStatus,
        this.paymentType,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  ReOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeOrder = json['code_order'];
    clientId = json['client_id'];
    storeId = json['store_id'];
    addressId = json['address_id'];
    promoCodeId = json['promo_code_id'];
    deliveryCost = json['delivery_cost'];
    subTotal = json['sub_total'];
    total = json['total'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code_order'] = this.codeOrder;
    data['client_id'] = this.clientId;
    data['store_id'] = this.storeId;
    data['address_id'] = this.addressId;
    data['promo_code_id'] = this.promoCodeId;
    data['delivery_cost'] = this.deliveryCost;
    data['sub_total'] = this.subTotal;
    data['total'] = this.total;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['payment_type'] = this.paymentType;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

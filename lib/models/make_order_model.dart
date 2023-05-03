class MakeOrderModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  MakeOrderModel({this.status, this.errNum, this.msg, this.data});

  MakeOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['errNum'] = this.errNum;
  //   data['msg'] = this.msg;
  //   if (this.data != null) {
  //     data['data'] = this.data.toJson();
  //   }
  //   return data;
  // }
}

class Data {
  int? codeOrder;
  int? clientId;
  String? paymentStatus;
  String? paymentType;
  int? promoCodeId;
  String? status;
  String? subTotal;
  dynamic total;
  dynamic deliveryCost;
  int? storeId;
  String? updatedAt;
  String? createdAt;
  int? id;

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
      this.storeId,
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
    storeId = json['store_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['code_order'] = this.codeOrder;
//   data['client_id'] = this.clientId;
//   data['payment_status'] = this.paymentStatus;
//   data['payment_type'] = this.paymentType;
//   data['promo_code_id'] = this.promoCodeId;
//   data['status'] = this.status;
//   data['sub_total'] = this.subTotal;
//   data['total'] = this.total;
//   data['delivery_cost'] = this.deliveryCost;
//   data['store_id'] = this.storeId;
//   data['updated_at'] = this.updatedAt;
//   data['created_at'] = this.createdAt;
//   data['id'] = this.id;
//   return data;
// }
}

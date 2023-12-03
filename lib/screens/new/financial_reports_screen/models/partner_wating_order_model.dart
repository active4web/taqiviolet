class PartnerWatingOrderModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  PartnerWatingOrderModel({this.status, this.errNum, this.msg, this.data});

  PartnerWatingOrderModel.fromJson(Map<String, dynamic> json) {
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

}

class Data {
  num? id;
  String? codeOrder;
  dynamic productRate;
  num? clientId;
  dynamic storeId;
  String? address;
  num? promoCodeId;
  num? promoCodeValue;
  dynamic deliveryType;
  num? deliveryCost;
  num? subTotal;
  num? total;
  String? status;
  String? paymentStatus;
  String? paymentType;
  dynamic username;
  dynamic userphone;
  dynamic orderDate;

  Data(
      {this.id,
        this.codeOrder,
        this.productRate,
        this.clientId,
        this.storeId,
        this.address,
        this.promoCodeId,
        this.promoCodeValue,
        this.deliveryType,
        this.deliveryCost,
        this.subTotal,
        this.total,
        this.status,
        this.paymentStatus,
        this.paymentType,
        this.username,
        this.userphone,
        this.orderDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeOrder = json['code_order'];
    productRate = json['product_rate'];
    clientId = json['client_id'];
    storeId = json['store_id'];
    address = json['address'];
    promoCodeId = json['promo_code_id'];
    promoCodeValue = json['promo_code_value'];
    deliveryType = json['delivery_type'];
    deliveryCost = json['delivery_cost'];
    subTotal = json['sub_total'];
    total = json['total'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    username = json['username'];
    userphone = json['userphone'];
    orderDate = json['order_date'];
  }

}
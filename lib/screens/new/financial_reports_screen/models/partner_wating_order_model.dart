class PartnerWatingOrderModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Order>? data;

  PartnerWatingOrderModel({this.status, this.errNum, this.msg, this.data});

  PartnerWatingOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Order>[];
      json['data'].forEach((v) {
        data!.add(new Order.fromJson(v));
      });
    }
  }

}

class Order {
  dynamic id;
  String? codeOrder;
  dynamic productRate;
  dynamic clientId;
  dynamic storeId;
  String? address;
  dynamic promoCodeId;
  dynamic promoCodeValue;
  dynamic deliveryType;
  dynamic deliveryCost;
  dynamic subTotal;
  dynamic total;
  String? status;
  String? paymentStatus;
  String? paymentType;
  dynamic username;
  dynamic userphone;
  dynamic orderDate;

  Order(
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

  Order.fromJson(Map<String, dynamic> json) {
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
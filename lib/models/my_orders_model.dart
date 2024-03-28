class MyOrdersModel {
  bool? status;
  String? errNum;
  String? msg;
  List<MyOrdersData>? data;

  MyOrdersModel({this.status, this.errNum, this.msg, this.data});

  MyOrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <MyOrdersData>[];
      json['data'].forEach((v) {
        data!.add(new MyOrdersData.fromJson(v));
      });
    }
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['status'] = this.status;
//   data['errNum'] = this.errNum;
//   data['msg'] = this.msg;
//   if (this.data != null) {
//     data['data'] = this.data.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}

class MyOrdersData {
  dynamic id;
  String? codeOrder;
  int? clientId;
  int? storeId;
  String? address;
  dynamic promoCodeVal;
  dynamic deliveryCost;
  dynamic subTotal;
  dynamic total;
  String? status;
  String? paymentStatus;
  String? paymentType;
  String? userName;
  String? userPhone;
  String? orderDate;
  String? orderDeliveryDate;
  dynamic itemCount;
  String? date;

  MyOrdersData({
    this.id,
    this.codeOrder,
    this.clientId,
    this.storeId,
    this.address,
    this.promoCodeVal,
    this.deliveryCost,
    this.subTotal,
    this.total,
    this.status,
    this.paymentStatus,
    this.paymentType,
    this.userName,
    this.userPhone,
    this.orderDate,
    this.orderDeliveryDate,
  });

  MyOrdersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeOrder = json['code_order'];
    clientId = json['client_id'];
    storeId = json['store_id'];
    address = json['address_id'];
    promoCodeVal = json['promo_code_value'];
    deliveryCost = json['delivery_cost'];
    subTotal = json['sub_total'];
    total = json['total'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    userName = json['username'];
    userPhone = json['userphone'];
    orderDate = json['order_date'];
    orderDeliveryDate = json['delivery_date'];
    itemCount = json['items_count'];
    date=json['created_at'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['code_order'] = this.codeOrder;
//   data['client_id'] = this.clientId;
//   data['store_id'] = this.storeId;
//   data['address_id'] = this.address;
//   data['promo_code_value'] = this.promoCodeVal;
//   data['delivery_cost'] = this.deliveryCost;
//   data['sub_total'] = this.subTotal;
//   data['total'] = this.total;
//   data['status'] = this.status;
//   data['payment_status'] = this.paymentStatus;
//   data['payment_type'] = this.paymentType;
//   data['username'] = this.userName;
//   data['userphone'] = this.userPhone;
//   data['order_date'] = this.orderDate;
//   data['delivery_date'] = this.orderDeliveryDate;
//   return data;
// }
}

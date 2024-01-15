class MakeNewOrderModel {
  bool? status;
  String? message;
  Data? data;

  MakeNewOrderModel({this.status, this.message, this.data});

  MakeNewOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Order? order;
  Order? lastOrder;

  Data({this.order, this.lastOrder});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    lastOrder = json['last_order'] != null
        ? new Order.fromJson(json['last_order'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.lastOrder != null) {
      data['last_order'] = this.lastOrder!.toJson();
    }
    return data;
  }
}

class Order {
  String? id;
  String? codeOrder;
  String? paymentStatus;
  String? paymentType;
  String? promoCodeId;
  String? subTotal;
  String? deliveryCost;
  String? total;
  String? status;
  String? address;
  String? userName;
  String? userPhone;
  String? countryRefCode;
  String? stateId;
  String? paymentRefCode;
  String? stateName;
  String? rateStatus;
  String? rateComment;
  String? deliveryDate;
  String? cashBackAmount;
  String? cardId;
  String? email;
  String? countryId;
  String? amount;
  String? createdAt;
  String? updatedAt;
  dynamic productsCount;

  Order(
      {this.id,
        this.codeOrder,
        this.paymentStatus,
        this.paymentType,
        this.promoCodeId,
        this.subTotal,
        this.deliveryCost,
        this.total,
        this.status,
        this.address,
        this.userName,
        this.userPhone,
        this.countryRefCode,
        this.stateId,
        this.paymentRefCode,
        this.stateName,
        this.rateStatus,
        this.rateComment,
        this.deliveryDate,
        this.cashBackAmount,
        this.cardId,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.productsCount,
      this.email,
      this.countryId});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeOrder = json['code_order'];
    paymentStatus = json['payment_status'];
    paymentType = json['payment_type'];
    promoCodeId = json['promo_code_id'];
    subTotal = json['sub_total'];
    deliveryCost = json['delivery_cost'];
    total = json['total'];
    status = json['status'];
    address = json['address'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    countryRefCode = json['country_ref_code'];
    stateId = json['state_id'];
    paymentRefCode = json['payment_ref_code'];
    stateName = json['state_name'];
    rateStatus = json['rate_status'];
    rateComment = json['rate_comment'];
    deliveryDate = json['delivery_date'];
    cashBackAmount = json['cash_back_amount'];
    cardId = json['card_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['user_email'];
    countryId = json['country_id'];
    productsCount = json['products_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code_order'] = this.codeOrder;
    data['payment_status'] = this.paymentStatus;
    data['payment_type'] = this.paymentType;
    data['promo_code_id'] = this.promoCodeId;
    data['sub_total'] = this.subTotal;
    data['delivery_cost'] = this.deliveryCost;
    data['total'] = this.total;
    data['status'] = this.status;
    data['address'] = this.address;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['country_ref_code'] = this.countryRefCode;
    data['state_id'] = this.stateId;
    data['payment_ref_code'] = this.paymentRefCode;
    data['state_name'] = this.stateName;
    data['rate_status'] = this.rateStatus;
    data['rate_comment'] = this.rateComment;
    data['delivery_date'] = this.deliveryDate;
    data['cash_back_amount'] = this.cashBackAmount;
    data['card_id'] = this.cardId;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['products_count'] = this.productsCount;
    return data;
  }
}
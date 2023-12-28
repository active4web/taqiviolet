class UpdateOrderModel {
  bool? status;
  String? message;
  Data? data;

  UpdateOrderModel({this.status, this.message, this.data});

  UpdateOrderModel.fromJson(Map<String, dynamic> json) {
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
  String? amount;

  Data(
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
        this.amount});

  Data.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
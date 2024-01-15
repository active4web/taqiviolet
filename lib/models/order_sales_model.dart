import '../screens/new/financial_reports_screen/models/partner_wating_order_model.dart';

class OrderSalesModel {
  bool? status;
  String? message;
  Data? data;

  OrderSalesModel({this.status, this.message, this.data});

  OrderSalesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<Order>? orders;
  PromoCode? promoCode;

  Data({this.orders, this.promoCode});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(new Order.fromJson(v));
      });
    }
    promoCode = json['promo_code'] != null
        ? new PromoCode.fromJson(json['promo_code'])
        : null;
  }

}


class PromoCode {
  String? id;
  String? code;
  String? value;
  String? startDate;
  String? end;
  String? counts;

  PromoCode(
      {this.id, this.code, this.value, this.startDate, this.end, this.counts});

  PromoCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    value = json['value'];
    startDate = json['start_date'];
    end = json['end'];
    counts = json['counts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['value'] = this.value;
    data['start_date'] = this.startDate;
    data['end'] = this.end;
    data['counts'] = this.counts;
    return data;
  }
}
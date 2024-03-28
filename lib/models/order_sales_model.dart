import 'package:safsofa/models/partner_orders_model.dart';

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
  String? promoCode;
  Orders? orders;

  Data({this.promoCode, this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    promoCode = json['promo_code'];
    orders =
    json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promo_code'] = this.promoCode;
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    return data;
  }
}

class Orders {
  List<Waiting>? waiting;
  List<Waiting>? current;
  List<Waiting>? holding;
  List<Waiting>? old;

  Orders({this.waiting, this.current, this.holding, this.old});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['waiting'] != null) {
      waiting = <Waiting>[];
      json['waiting'].forEach((v) {
        waiting!.add(new Waiting.fromJson(v));
      });
    }
    if (json['current'] != null) {
      current = <Waiting>[];
      json['current'].forEach((v) {
        current!.add(new Waiting.fromJson(v));
      });
    }
    if (json['holding'] != null) {
      holding = <Waiting>[];
      json['holding'].forEach((v) {
        holding!.add(new Waiting.fromJson(v));
      });
    }
    if (json['old'] != null) {
      old = <Waiting>[];
      json['old'].forEach((v) {
        old!.add(new Waiting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.waiting != null) {
      data['waiting'] = this.waiting!.map((v) => v.toJson()).toList();
    }
    if (this.current != null) {
      data['current'] = this.current!.map((v) => v.toJson()).toList();
    }
    if (this.holding != null) {
      data['holding'] = this.holding!.map((v) => v.toJson()).toList();
    }
    if (this.old != null) {
      data['old'] = this.old!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
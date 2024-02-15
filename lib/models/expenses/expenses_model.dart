class ExpensesModel {
  bool? status;
  String? message;
  List<Data>? data;

  ExpensesModel({this.status, this.message, this.data});

  ExpensesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? details;
  String? totalMoney;
  String? file;
  String? createdAt;

  Data({this.id, this.details, this.totalMoney, this.file, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    totalMoney = json['total_money'];
    file = json['file'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['details'] = this.details;
    data['total_money'] = this.totalMoney;
    data['file'] = this.file;
    data['created_at'] = this.createdAt;
    return data;
  }
}
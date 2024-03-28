class CommitmentsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  CommitmentsModel({this.status, this.errNum, this.msg, this.data});

  CommitmentsModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? subject;
  int? monthlyDues;
  String? totalMoney;
  String? paymentMethod;
  int? annualDues;
  String? file;
  int? status;
  String? date;

  Data(
      {this.subject,
        this.monthlyDues,
        this.totalMoney,
        this.paymentMethod,
        this.annualDues,
        this.status,
        this.date});

  Data.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    monthlyDues = json['monthly_dues'];
    totalMoney = json['total_money'];
    paymentMethod = json['payment_method'];
    annualDues = json['annual_dues'];
    status = json['status'];
    date = json['date'];
    file=json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['monthly_dues'] = this.monthlyDues;
    data['total_money'] = this.totalMoney;
    data['payment_method'] = this.paymentMethod;
    data['annual_dues'] = this.annualDues;
    data['status'] = this.status;
    data['date'] = this.date;
    return data;
  }
}
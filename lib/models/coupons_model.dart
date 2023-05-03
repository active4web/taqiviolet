class CouponsModel {
  dynamic status;
  dynamic errNum;
  dynamic msg;
  Data? data;

  CouponsModel({this.status, this.errNum, this.msg, this.data});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CouponLists>? couponLists;

  Data({this.couponLists});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['coupon_lists'] != null) {
      couponLists = <CouponLists>[];
      json['coupon_lists'].forEach((v) {
        couponLists!.add(new CouponLists.fromJson(v));
      });
    }
  }
}

class CouponLists {
  dynamic id;
  dynamic value;
  dynamic startDate;
  dynamic endDate;
  dynamic coupon;
  dynamic status;

  CouponLists(
      {this.id,
        this.value,
        this.startDate,
        this.endDate,
        this.coupon,
        this.status});

  CouponLists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    coupon = json['coupon'];
    status = json['status'];
  }
}

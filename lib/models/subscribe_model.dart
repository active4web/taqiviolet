class SubscribeModel {
  SubscribeModel({
    this.status,
    this.errNum,
    this.msg,
  });

  SubscribeModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
  }

  bool? status;
  String? errNum;
  String? msg;

/* Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['msg'] = msg;
    return map;
  }*/
}

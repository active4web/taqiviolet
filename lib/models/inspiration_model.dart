class InspirationModel {
  InspirationModel({
    this.status,
    this.errNum,
    this.msg,
    this.data,
  });

  InspirationModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }
  bool status;
  String errNum;
  String msg;
  List<Data> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.image,
    this.urllink,
  });

  Data.fromJson(dynamic json) {
    id = json['ID'];
    image = json['Image'];
    urllink = json['url-link'];
  }
  int id;
  String image;
  String urllink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Image'] = image;
    map['url-link'] = urllink;
    return map;
  }
}

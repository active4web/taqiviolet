class InspirationModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  InspirationModel({this.status, this.errNum, this.msg, this.data});

  InspirationModel.fromJson(Map<String, dynamic> json) {
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

class Data {
  int? iD;
  String? image;
  int? urlLink;
  String? productName;
  int? hasFavorites;

  Data(
      {this.iD, this.image, this.urlLink, this.productName, this.hasFavorites});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    image = json['Image'];
    urlLink = json['url-link'];
    productName = json['product-name'];
    hasFavorites = json['hasFavorites'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['ID'] = this.iD;
  //   data['Image'] = this.image;
  //   data['url-link'] = this.urlLink;
  //   data['product-name'] = this.productName;
  //   data['hasFavorites'] = this.hasFavorites;
  //   return data;
  // }
}

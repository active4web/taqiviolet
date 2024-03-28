class OfferModel {
  bool? status;
  String? errNum;
  String? msg;
  List<OfferModelData>? data;

  OfferModel({this.status, this.errNum, this.msg, this.data});

  OfferModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <OfferModelData>[];
      json['data'].forEach((v) {
        data!.add(new OfferModelData.fromJson(v));
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

class OfferModelData {
  int? iD;
  String? title;
  String? title2;
  String? title3;
  String? title4;
  String? title5;
  String? content;
  String? image;
  int? discount;
  String? details;

  OfferModelData(
      {this.iD,
        this.title,
        this.content,
        this.image,
        this.discount,
        this.details});

  OfferModelData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
    title2 = json['title2'];
    title3 = json['title3'];
    title4 = json['title4'];
    title5 = json['title5'];
    content = json['Content'];
    image = json['Image'];
    discount = json['Discount'];
    details = json['Details'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['ID'] = this.iD;
  //   data['Title'] = this.title;
  //   data['Content'] = this.content;
  //   data['Image'] = this.image;
  //   data['Discount'] = this.discount;
  //   data['Details'] = this.details;
  //   return data;
  // }
}

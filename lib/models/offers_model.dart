class OffersModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  OffersModel({this.status, this.errNum, this.msg, this.data});

  OffersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? keyOffer;
  String? promoCodeName;
  String? offerImage;

  Data({this.keyOffer, this.promoCodeName, this.offerImage});

  Data.fromJson(Map<String, dynamic> json) {
    keyOffer = json['key_offer'];
    promoCodeName = json['promo_code_name'];
    offerImage = json['offer_image'];
  }

}
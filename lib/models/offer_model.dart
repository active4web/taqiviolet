import 'package:flutter/cupertino.dart';

class OfferModel {
  OfferModel({
   @ required this.status,
   @ required this.errNum,
   @ required this.msg,
   @ required this.data,
  });
   bool status;
 String errNum;
   String msg;
    List<DataOffer> data;

  OfferModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = List.from(json['data']).map((e)=>DataOffer.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class DataOffer {
  DataOffer({
   @ required this.ID,
   @ required this.Title,
   @ required this.Content,
   @ required this.Image,
   @ required this.Discount,
   @ required this.Details,
  });
    int ID;
    String Title;
    String Content;
    String Image;
    String Discount;
    String Details;

  DataOffer.fromJson(Map<String, dynamic> json){
    ID = json['ID'];
    Title = json['Title'];
    Content = json['Content'];
    Image = json['Image'];
    Discount = json['Discount'];
    Details = json['Details'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ID'] = ID;
    _data['Title'] = Title;
    _data['Content'] = Content;
    _data['Image'] = Image;
    _data['Discount'] = Discount;
    _data['Details'] = Details;
    return _data;
  }
}

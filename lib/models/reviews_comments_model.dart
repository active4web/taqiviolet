class ReviewsCommentsModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  ReviewsCommentsModel({this.status, this.errNum, this.msg, this.data});

  ReviewsCommentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

/* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }*/
}

class Data {
  List<CommentData>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CommentData>[];
      json['list'].forEach((v) {
        list!.add(new CommentData.fromJson(v));
      });
    }
  }
/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }*/
}

class CommentData {
  String? comment;
  String? rate;
  String? date;
  int? productId;
  String? clientName;
  List<String>? listImg;

  CommentData(
      {this.comment,
      this.rate,
      this.date,
      this.productId,
      this.clientName,
      this.listImg});

  CommentData.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    rate = json['rate'];
    date = json['date'];
    productId = json['product_id'];
    clientName = json['client_name'];
    listImg = json['list_img'].cast<String>();
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['rate'] = this.rate;
    data['date'] = this.date;
    data['product_id'] = this.productId;
    data['client_name'] = this.clientName;
    data['list_img'] = this.listImg;
    return data;
  }*/
}

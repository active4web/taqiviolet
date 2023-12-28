class NewListCardsModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  NewListCardsModel({this.status, this.errNum, this.msg, this.data});

  NewListCardsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Listcards>? listcards;

  Data({this.listcards});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['listcards'] != null) {
      listcards = <Listcards>[];
      json['listcards'].forEach((v) {
        listcards!.add(new Listcards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listcards != null) {
      data['listcards'] = this.listcards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listcards {
  int? id;
  String? code;
  String? name;
  String? image;
  String? price;
  String? status;
  String? end;
  int? counts;
  dynamic createdAt;
  dynamic updatedAt;
  String? startDate;

  Listcards(
      {this.id,
        this.code,
        this.name,
        this.image,
        this.price,
        this.status,
        this.end,
        this.counts,
        this.createdAt,
        this.updatedAt,
        this.startDate});

  Listcards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    status = json['status'];
    end = json['end'];
    counts = json['counts'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['status'] = this.status;
    data['end'] = this.end;
    data['counts'] = this.counts;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['start_date'] = this.startDate;
    return data;
  }
}

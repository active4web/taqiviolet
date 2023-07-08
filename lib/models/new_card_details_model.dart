class NewCardDetailsModel {
  bool? status;
  String? errNum;
  String? msg;
  Data? data;

  NewCardDetailsModel({this.status, this.errNum, this.msg, this.data});

  NewCardDetailsModel.fromJson(Map<String, dynamic> json) {
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
  List<Listcardimages>? listcardimages;
  List<Listcardprice>? listcardprice;

  Data({this.listcardimages, this.listcardprice});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Listcardimages'] != null) {
      listcardimages = <Listcardimages>[];
      json['Listcardimages'].forEach((v) {
        listcardimages!.add(new Listcardimages.fromJson(v));
      });
    }
    if (json['Listcardprice'] != null) {
      listcardprice = <Listcardprice>[];
      json['Listcardprice'].forEach((v) {
        listcardprice!.add(new Listcardprice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listcardimages != null) {
      data['Listcardimages'] =
          this.listcardimages!.map((v) => v.toJson()).toList();
    }
    if (this.listcardprice != null) {
      data['Listcardprice'] =
          this.listcardprice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listcardimages {
  int? id;
  String? name;
  int? listId;
  String? image;
  String? status;
  String? createdAt;
  Null? updatedAt;

  Listcardimages(
      {this.id,
        this.name,
        this.listId,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  Listcardimages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    listId = json['list_id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['list_id'] = this.listId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Listcardprice {
  int? id;
  int? listId;
  String? price;
  String? status;
  int? counts;
  String? createdAt;
  Null? updatedAt;

  Listcardprice(
      {this.id,
        this.listId,
        this.price,
        this.status,
        this.counts,
        this.createdAt,
        this.updatedAt});

  Listcardprice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listId = json['list_id'];
    price = json['price'];
    status = json['status'];
    counts = json['counts'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['list_id'] = this.listId;
    data['price'] = this.price;
    data['status'] = this.status;
    data['counts'] = this.counts;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

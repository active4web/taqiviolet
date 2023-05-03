class MyListModel {
  bool? status;
  dynamic errNum;
  dynamic msg;
  Data? data;

  MyListModel({this.status, this.errNum, this.msg, this.data});

  MyListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }*/
}

class Data {
  List<Lists>? list;

  Data({this.list});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Lists>[];
      json['list'].forEach((v) {
        list!.add(new Lists.fromJson(v));
      });
    }
  }

/*  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }*/
}

class Lists {
  dynamic listName;
  dynamic listId;
  dynamic listImg1;
  dynamic listImg2;
  dynamic listImg3;
  dynamic listImg4;
  dynamic listImg5;
  dynamic totalProducts;
/*  MainList? mainList;*/

  Lists(
      {this.listName,
        this.listId,
        this.listImg1,
        this.listImg2,
        this.listImg3,
        this.listImg4,
        this.listImg5,
        this.totalProducts,
      /*  this.mainList*/});

  Lists.fromJson(Map<String, dynamic> json) {
    listName = json['list_name'];
    listId = json['list_id'];
    listImg1 = json['list_img1'];
    listImg2 = json['list_img2'];
    listImg3 = json['list_img3'];
    listImg4 = json['list_img4'];
    listImg5 = json['list_img5'];
    totalProducts = json['total_products'];

    /* mainList = json['mainList'] != null
        ? new MainList.fromJson(json['mainList'])
        : null;*/
  }


}

/*class MainList {
  dynamic id;
  dynamic clientId;
  dynamic productId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic listId;

  MainList(
      {this.id,
        this.clientId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.listId});

  MainList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    listId = json['list_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['list_id'] = this.listId;
    return data;
  }
}*/

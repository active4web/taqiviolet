class FavoritesListsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  FavoritesListsModel({this.status, this.errNum, this.msg, this.data});

  FavoritesListsModel.fromJson(Map<String, dynamic> json) {
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

/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
*/
}

class Data {
  int? iD;
  int? clientId;
  String? name;
  String? image;
  String? createdAt;

  Data({this.iD, this.clientId, this.name, this.image, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    clientId = json['client_id'];
    name = json['name'];
    image = json['Image'];
    createdAt = json['created_at'];
  }

/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['client_id'] = this.clientId;
    data['name'] = this.name;
    data['Image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
*/
}

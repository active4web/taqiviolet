class ListsModel {
  bool status;
  String errNum;
  String msg;
  Data data;

  ListsModel({this.status, this.errNum, this.msg, this.data});

  ListsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data =   Data.fromJson(json['data']) ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<MainList> mainList;
  List<ShareList> shareList;

  Data({this.mainList, this.shareList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['MainList'] != null) {
      mainList = <MainList>[];
      json['MainList'].forEach((v) {
        mainList.add(new MainList.fromJson(v));
      });
    }
    if (json['ShareList'] != null) {
      shareList = <ShareList>[];
      json['ShareList'].forEach((v) {
        shareList.add(new ShareList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainList != null) {
      data['MainList'] = this.mainList.map((v) => v.toJson()).toList();
    }
    if (this.shareList != null) {
      data['ShareList'] = this.shareList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainList {
  int id;
  int clientId;
  String name;
  Null link;
  String createdAt;
  String updatedAt;

  MainList(
      {this.id,
        this.clientId,
        this.name,
        this.link,
        this.createdAt,
        this.updatedAt});

  MainList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    name = json['name'];
    link = json['link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['name'] = this.name;
    data['link'] = this.link;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ShareList {
  int id;
  int rosterId;
  int clientId;
  int type;
  String createdAt;
  String updatedAt;

  ShareList(
      {this.id,
        this.rosterId,
        this.clientId,
        this.type,
        this.createdAt,
        this.updatedAt});

  ShareList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rosterId = json['roster_id'];
    clientId = json['client_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roster_id'] = this.rosterId;
    data['client_id'] = this.clientId;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

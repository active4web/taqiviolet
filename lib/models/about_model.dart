class AboutModel {
  bool status;
  String errNum;
  String msg;
  List<AboutModelData> data;

  AboutModel({this.status, this.errNum, this.msg, this.data});

  AboutModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <AboutModelData>[];
      json['data'].forEach((v) {
        data.add(new AboutModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AboutModelData {
  int id;
  String createdAt;
  String updatedAt;
  String txtName;
  int type;

  AboutModelData({this.id, this.createdAt, this.updatedAt, this.txtName, this.type});

  AboutModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    txtName = json['txt_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['txt_name'] = this.txtName;
    data['type'] = this.type;
    return data;
  }
}

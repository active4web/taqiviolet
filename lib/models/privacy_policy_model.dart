class PrivacyPolicyModel {
  bool status;
  String errNum;
  String msg;
  List<PrivacyPolicyData> data;

  PrivacyPolicyModel({this.status, this.errNum, this.msg, this.data});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <PrivacyPolicyData>[];
      json['data'].forEach((v) {
        data.add(new PrivacyPolicyData.fromJson(v));
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

class PrivacyPolicyData {
  int id;
  String content;
  String title;
  String image;
  int type;
  String createdAt;
  String updatedAt;

  PrivacyPolicyData(
      {this.id,
      this.content,
      this.title,
      this.image,
      this.type,
      this.createdAt,
      this.updatedAt});

  PrivacyPolicyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    title = json['title'];
    image = json['image'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['title'] = this.title;
    data['image'] = this.image;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

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
  String title;
  String content;
  String image;

  AboutModelData({
    this.id,
    this.title,
    this.content,
    this.image,
  });

  AboutModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content_app'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content_app'] = this.content;
    data['image'] = this.image;

    return data;
  }
}

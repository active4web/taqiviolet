class SuccessStoriesModel {
  bool status;
  String errNum;
  String msg;
  List<SuccessStoriesData> data;

  SuccessStoriesModel({this.status, this.errNum, this.msg, this.data});

  SuccessStoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <SuccessStoriesData>[];
      json['data'].forEach((v) {
        data.add(new SuccessStoriesData.fromJson(v));
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

class SuccessStoriesData {
  int id;
  String content;
  String title;
  List<String> image;
  String createdAt;
  String updatedAt;

  SuccessStoriesData(
      {this.id,
        this.content,
        this.title,
        this.image,
        this.createdAt,
        this.updatedAt});

  SuccessStoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    title = json['title'];
    image = json['image'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['title'] = this.title;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

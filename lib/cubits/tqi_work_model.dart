class TqiWorkModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  TqiWorkModel({this.status, this.errNum, this.msg, this.data});

  TqiWorkModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    errNum = json["errNum"];
    msg = json["msg"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> _data = <String, dynamic>{};
  //   _data["status"] = status;
  //   _data["errNum"] = errNum;
  //   _data["msg"] = msg;
  //   if (data != null) {
  //     _data["data"] = data.map((e) => e.toJson()).toList();
  //   }
  //   return _data;
  // }
}

class Data {
  String? title;
  String? contentApp;
  String? image;
  int? id;
  String? content;

  Data({this.title, this.contentApp, this.image, this.id, this.content});

  Data.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    contentApp = json["content_app"];
    image = json["image"];
    id = json["id"];
    content = json["content"];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> _data = <String, dynamic>{};
  //   _data["title"] = title;
  //   _data["content_app"] = contentApp;
  //   _data["image"] = image;
  //   _data["id"] = id;
  //   _data["content"] = content;
  //   return _data;
  // }
}

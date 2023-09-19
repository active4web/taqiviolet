class PrivacyPolicyDetailsModel {
  bool? status;
  String? errNum;
  String? msg;
  List<Data>? data;

  PrivacyPolicyDetailsModel({this.status, this.errNum, this.msg, this.data});

  PrivacyPolicyDetailsModel.fromJson(Map<String, dynamic> json) {
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

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['status'] = this.status;
//   data['errNum'] = this.errNum;
//   data['msg'] = this.msg;
//   if (this.data != null) {
//     data['data'] = this.data.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}

class Data {
  int? id;
  String? title;
  String? content;
  String? contentApp;
  String? image;
  int? type;
  String? file;
  int? footer;
  String? createdAt;
  String? updatedAt;
  int? appView;
  int? idCat;

  Data(
      {this.id,
      this.title,
      this.content,
      this.contentApp,
      this.image,
      this.type,
      this.file,
      this.footer,
      this.createdAt,
      this.updatedAt,
      this.appView,
      this.idCat});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    contentApp = json['content_app'];
    image = json['image'];
    type = json['type'];
    file = json['file'];
    footer = json['footer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    appView = json['app_view'];
    idCat = json['id_cat'];
  }

/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['content_app'] = this.contentApp;
    data['image'] = this.image;
    data['type'] = this.type;
    data['file'] = this.file;
    data['footer'] = this.footer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['app_view'] = this.appView;
    data['id_cat'] = this.idCat;
    return data;
  }
*/
}

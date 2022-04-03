class StoreModel {
  bool status;
  String errNum;
  String msg;
  List<DataOfStore> data;

  StoreModel({this.status, this.errNum, this.msg, this.data});

  StoreModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <DataOfStore>[];
      json['data'].forEach((v) {
        data.add(new DataOfStore.fromJson(v));
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

class DataOfStore {
  int iD;
  String name;
  String phone;
  String aboutUS;
  String faceBookLink;
  String instagramLink;
  String twitterLink;
  String judgments;
  String replacement;
  String image;
  Null categoryId;

  DataOfStore(
      {this.iD,
        this.name,
        this.phone,
        this.aboutUS,
        this.faceBookLink,
        this.instagramLink,
        this.twitterLink,
        this.judgments,
        this.replacement,
        this.image,
        this.categoryId});

  DataOfStore.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    phone = json['Phone'];
    aboutUS = json['AboutUS'];
    faceBookLink = json['FaceBookLink'];
    instagramLink = json['InstagramLink'];
    twitterLink = json['twitterLink'];
    judgments = json['Judgments'];
    replacement = json['Replacement'];
    image = json['Image'];
    categoryId = json['Category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Phone'] = this.phone;
    data['AboutUS'] = this.aboutUS;
    data['FaceBookLink'] = this.faceBookLink;
    data['InstagramLink'] = this.instagramLink;
    data['twitterLink'] = this.twitterLink;
    data['Judgments'] = this.judgments;
    data['Replacement'] = this.replacement;
    data['Image'] = this.image;
    data['Category_id'] = this.categoryId;
    return data;
  }
}


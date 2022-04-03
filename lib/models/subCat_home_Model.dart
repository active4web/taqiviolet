class SubCatDataModel {
  bool status;
  String errNum;
  String msg;
  List<DateSubCat> date;

  SubCatDataModel({this.status, this.errNum, this.msg, this.date});

  SubCatDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['date'] != null) {
      date = <DateSubCat>[];
      json['date'].forEach((v) {
        date.add(new DateSubCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.date != null) {
      data['date'] = this.date.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateSubCat {
  int iD;
  String name;
  String details;
  String image;
  int categoryId;

  DateSubCat({this.iD, this.name, this.details, this.image, this.categoryId});

  DateSubCat.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    details = json['Details'];
    image = json['Image'];
    categoryId = json['Category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Details'] = this.details;
    data['Image'] = this.image;
    data['Category_id'] = this.categoryId;
    return data;
  }
}

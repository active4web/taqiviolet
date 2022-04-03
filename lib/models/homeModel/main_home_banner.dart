class HomeScreenMainCatBannerModel {
  bool status;
  String errNum;
  String msg;
  List<DataBanner> data;

  HomeScreenMainCatBannerModel({this.status, this.errNum, this.msg, this.data});

  HomeScreenMainCatBannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <DataBanner>[];
      json['data'].forEach((v) {
        data.add(new DataBanner.fromJson(v));
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

class DataBanner {
  int iD;
  String image;

  DataBanner({this.iD, this.image});

  DataBanner.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Image'] = this.image;
    return data;
  }
}

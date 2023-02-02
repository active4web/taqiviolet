class ContactUs {
  bool status;
  String errNum;
  String msg;
  Data data;

  ContactUs({this.status, this.errNum, this.msg, this.data});

  ContactUs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = new Data.fromJson(json['data']);
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
  int iD;
  String youtubeLink;
  String tiktokLink;
  String instagramLink;
  String twitterLink;
  String phone;
  String mail;

  Data({
    this.iD,
    this.youtubeLink,
    this.tiktokLink,
    this.instagramLink,
    this.twitterLink,
    this.phone,
    this.mail,
  });

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    youtubeLink = json['youtube-link'];
    tiktokLink = json['tiktok-link'];
    instagramLink = json['Instagram-link'];
    twitterLink = json['Twitter-link'];
    phone = json['Phone'];
    mail = json['Mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['youtube-link'] = this.youtubeLink;
    data['tiktok-link'] = this.tiktokLink;
    data['Instagram-link'] = this.instagramLink;
    data['Twitter-link'] = this.twitterLink;
    data['Phone'] = this.phone;
    data['Mail'] = this.mail;

    return data;
  }
}

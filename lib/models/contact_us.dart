class ContactUs {
  ContactUs({
    this.status,
    this.errNum,
    this.msg,
    this.data,
  });

  ContactUs.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null
        ? Data.fromJson(Map<String, dynamic>.from(json['data']))
        : null;
  }
  bool status;
  String errNum;
  String msg;
  Data data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.youtubelink,
    this.tiktoklink,
    this.instagramlink,
    this.twitterlink,
    this.phone,
    this.mail,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    youtubelink = json['youtube-link'];
    tiktoklink = json['tiktok-link'];
    instagramlink = json['Instagram-link'];
    twitterlink = json['Twitter-link'];
    phone = json['Phone'];
    mail = json['Mail'];
  }
  int id;
  String youtubelink;
  String tiktoklink;
  String instagramlink;
  String twitterlink;
  String phone;
  String mail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['youtube-link'] = youtubelink;
    map['tiktok-link'] = tiktoklink;
    map['Instagram-link'] = instagramlink;
    map['Twitter-link'] = twitterlink;
    map['Phone'] = phone;
    map['Mail'] = mail;
    return map;
  }
}

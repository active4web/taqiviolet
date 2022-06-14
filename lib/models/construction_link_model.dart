class ConstructionLinkModel {
  ConstructionLinkModel({
    this.status,
    this.errNum,
    this.msg,
    this.data,
  });

  ConstructionLinkModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? Content.fromJson(json['data']) : null;
  }
  bool status;
  String errNum;
  String msg;
  Content data;

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

class Content {
  Content({
    this.offerImage,
    this.videoLink,
    this.constraction,
  });

  Content.fromJson(dynamic json) {
    offerImage = json['offerImage'];
    videoLink = json['videoLink'];
    if (json['constraction'] != null) {
      constraction = [];
      json['constraction'].forEach((v) {
        constraction.add(Constraction.fromJson(v));
      });
    }
  }
  String offerImage;
  String videoLink;
  List<Constraction> constraction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offerImage'] = offerImage;
    map['videoLink'] = videoLink;
    if (constraction != null) {
      map['constraction'] = constraction.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Constraction {
  Constraction({
    this.id,
    this.title,
    this.link,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  Constraction.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int id;
  String title;
  String link;
  String image;
  String createdAt;
  String updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['link'] = link;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

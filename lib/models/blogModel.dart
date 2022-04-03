class BlogModel {
  bool status;
  String errNum;
  String msg;
  Data data;

  BlogModel({this.status, this.errNum, this.msg, this.data});

  BlogModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  List<Blogs> blogs;
  List<LastBlogs> lastblog;

  Data({this.blogs, this.lastblog});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs.add(new Blogs.fromJson(v));
      });
    }
    if (json['lastblog'] != null) {
      lastblog = <LastBlogs>[];
      json['lastblog'].forEach((v) {
        lastblog.add(new LastBlogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blogs != null) {
      data['blogs'] = this.blogs.map((v) => v.toJson()).toList();
    }
    if (this.lastblog != null) {
      data['lastblog'] = this.lastblog.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  int iD;
  String title;
  String content;
  String image;
  String time;
  String createdAt;

  Blogs(
      {this.iD,
        this.title,
        this.content,
        this.image,
        this.time,
        this.createdAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
    content = json['Content'];
    image = json['Image'];
    time = json['Time'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Title'] = this.title;
    data['Content'] = this.content;
    data['Image'] = this.image;
    data['Time'] = this.time;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class LastBlogs {
  int iD;
  String title;
  String content;
  String image;
  String time;
  String createdAt;

  LastBlogs(
      {this.iD,
        this.title,
        this.content,
        this.image,
        this.time,
        this.createdAt});

  LastBlogs.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['Title'];
    content = json['Content'];
    image = json['Image'];
    time = json['Time'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Title'] = this.title;
    data['Content'] = this.content;
    data['Image'] = this.image;
    data['Time'] = this.time;
    data['created_at'] = this.createdAt;
    return data;
  }
}
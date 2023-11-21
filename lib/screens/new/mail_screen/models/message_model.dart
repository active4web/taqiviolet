class MessageModel {
  bool? status;
  String? message;
  List<Data>? data;

  MessageModel({this.status, this.message, this.data});

  MessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

}

class Data {
  int? id;
  int? senderId;
  int? reserverId;
  String? senderName;
  String? reserverName;
  int? parentId;
  String? title;
  String? content;
  String? createdAt;
  String? senderReadAt;
  String? reserverReadAt;
  int? authId;
  List<Emails>? emails;

  Data(
      {this.id,
        this.senderId,
        this.reserverId,
        this.senderName,
        this.reserverName,
        this.parentId,
        this.title,
        this.content,
        this.createdAt,
        this.authId,
        this.emails,this.senderReadAt,this.reserverReadAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    reserverId = json['reserver_id'];
    senderName = json['sender_name'];
    reserverName = json['reserver_name'];
    parentId = json['parent_id'];
    title = json['title'];
    content = json['content'];
    senderReadAt=json['sender_read_at'];
    reserverReadAt=json['reserver_read_at'];
    createdAt = json['created_at'];
    authId = json['auth_id'];
    if (json['emails'] != null) {
      emails = <Emails>[];
      json['emails'].forEach((v) {
        emails!.add(new Emails.fromJson(v));
      });
    }
  }

}

class Emails {
  int? id;
  int? senderId;
  int? reserverId;
  String? senderName;
  String? reserverName;
  int? parentId;
  String? title;
  String? content;
  String? createdAt;
  int? authId;
  List<String>? emails;

  Emails(
      {this.id,
        this.senderId,
        this.reserverId,
        this.senderName,
        this.reserverName,
        this.parentId,
        this.title,
        this.content,
        this.createdAt,
        this.authId,
        this.emails});

  Emails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    reserverId = json['reserver_id'];
    senderName = json['sender_name'];
    reserverName = json['reserver_name'];
    parentId = json['parent_id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    authId = json['auth_id'];
    if (json['emails'] != null) {
      emails = <String>[];
      json['emails'].forEach((v) {
        emails!.add(v);
      });
    }
  }

}
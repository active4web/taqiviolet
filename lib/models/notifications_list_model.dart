// To parse this JSON data, do
//
//     final notificationsListModel = notificationsListModelFromJson(jsonString);

import 'dart:convert';

NotificationsListModel notificationsListModelFromJson(String str) =>
    NotificationsListModel.fromJson(json.decode(str));

String notificationsListModelToJson(NotificationsListModel data) =>
    json.encode(data.toJson());

class NotificationsListModel {
  NotificationsListModel({
    this.message,
    this.codenum,
    this.status,
    this.total,
    this.result,
  });

  String message;
  int codenum;
  bool status;
  int total;
  Result result;

  factory NotificationsListModel.fromJson(Map<String, dynamic> json) =>
      NotificationsListModel(
        message: json["message"],
        codenum: json["codenum"],
        status: json["status"],
        total: json["total"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "codenum": codenum,
        "status": status,
        "total": total,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    this.allNotifications,
  });

  List<AllNotification> allNotifications;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        allNotifications: List<AllNotification>.from(
            json["all_notifications"].map((x) => AllNotification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "all_notifications":
            List<dynamic>.from(allNotifications.map((x) => x.toJson())),
      };
}

class AllNotification {
  AllNotification({
    this.title,
    this.id,
    this.body,
    this.isRead,
    this.createdAt,
    this.img,
  });

  String title;
  int id;
  String body;
  int isRead;
  DateTime createdAt;
  String img;

  factory AllNotification.fromJson(Map<String, dynamic> json) =>
      AllNotification(
        title: json["title"],
        id: json["id"],
        body: json["body"],
        isRead: json["is_read"],
        createdAt: DateTime.parse(json["created_at"]),
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "body": body,
        "is_read": isRead,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "img": img,
      };
}
